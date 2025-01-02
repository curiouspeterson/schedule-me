-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Profiles table
CREATE TABLE IF NOT EXISTS profiles (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID UNIQUE NOT NULL,  -- References Supabase auth.users
    email TEXT NOT NULL,
    full_name TEXT NOT NULL,
    role TEXT NOT NULL CHECK (role IN ('admin', 'manager', 'employee')),
    organization_id UUID NOT NULL,
    phone_number TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Coverage Requirements table
CREATE TABLE IF NOT EXISTS coverage_requirements (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    organization_id UUID NOT NULL,
    day_of_week INTEGER NOT NULL CHECK (day_of_week BETWEEN 0 AND 6),
    shift_start TIME NOT NULL,
    shift_end TIME NOT NULL,
    required_staff_count INTEGER NOT NULL CHECK (required_staff_count > 0),
    role TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    UNIQUE(organization_id, day_of_week, shift_start, shift_end, role)
);

-- Schedule Assignments table
CREATE TABLE IF NOT EXISTS schedule_assignments (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    employee_id UUID NOT NULL REFERENCES profiles(id),
    coverage_requirement_id UUID NOT NULL REFERENCES coverage_requirements(id),
    date DATE NOT NULL,
    shift_start TIME NOT NULL,
    shift_end TIME NOT NULL,
    status TEXT NOT NULL CHECK (status IN ('scheduled', 'confirmed', 'completed', 'cancelled')),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    UNIQUE(employee_id, date, shift_start)
);

-- Shift Swap Requests table
CREATE TABLE IF NOT EXISTS shift_swap_requests (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    requester_assignment_id UUID NOT NULL REFERENCES schedule_assignments(id),
    requested_employee_id UUID REFERENCES profiles(id),
    status TEXT NOT NULL CHECK (status IN ('pending', 'accepted', 'rejected', 'cancelled')),
    notes TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Employee Availability table
CREATE TABLE IF NOT EXISTS employee_availability (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    employee_id UUID NOT NULL REFERENCES profiles(id),
    day_of_week INTEGER NOT NULL CHECK (day_of_week BETWEEN 0 AND 6),
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    availability_type TEXT NOT NULL CHECK (availability_type IN ('preferred', 'available', 'unavailable')),
    recurring BOOLEAN NOT NULL DEFAULT true,
    specific_date DATE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    UNIQUE(employee_id, day_of_week, start_time, end_time, specific_date)
);

-- Notifications table
CREATE TABLE IF NOT EXISTS notifications (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES profiles(id),
    title TEXT NOT NULL,
    message TEXT NOT NULL,
    type TEXT NOT NULL CHECK (type IN ('shift_update', 'swap_request', 'reminder', 'system')),
    read BOOLEAN NOT NULL DEFAULT false,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Drop existing indexes if they exist to avoid errors
DROP INDEX IF EXISTS idx_profiles_organization;
DROP INDEX IF EXISTS idx_coverage_requirements_org_day;
DROP INDEX IF EXISTS idx_schedule_assignments_employee;
DROP INDEX IF EXISTS idx_schedule_assignments_date;
DROP INDEX IF EXISTS idx_shift_swap_requests_requester;
DROP INDEX IF EXISTS idx_employee_availability_employee;
DROP INDEX IF EXISTS idx_notifications_user_unread;

-- Recreate indexes
CREATE INDEX idx_profiles_organization ON profiles(organization_id);
CREATE INDEX idx_coverage_requirements_org_day ON coverage_requirements(organization_id, day_of_week);
CREATE INDEX idx_schedule_assignments_employee ON schedule_assignments(employee_id);
CREATE INDEX idx_schedule_assignments_date ON schedule_assignments(date);
CREATE INDEX idx_shift_swap_requests_requester ON shift_swap_requests(requester_assignment_id);
CREATE INDEX idx_employee_availability_employee ON employee_availability(employee_id);
CREATE INDEX idx_notifications_user_unread ON notifications(user_id) WHERE NOT read;

-- Drop existing triggers if they exist
DROP TRIGGER IF EXISTS update_profiles_updated_at ON profiles;
DROP TRIGGER IF EXISTS update_coverage_requirements_updated_at ON coverage_requirements;
DROP TRIGGER IF EXISTS update_schedule_assignments_updated_at ON schedule_assignments;
DROP TRIGGER IF EXISTS update_shift_swap_requests_updated_at ON shift_swap_requests;
DROP TRIGGER IF EXISTS update_employee_availability_updated_at ON employee_availability;
DROP TRIGGER IF EXISTS update_notifications_updated_at ON notifications;
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;

-- Drop existing functions if they exist
DROP FUNCTION IF EXISTS update_updated_at_column() CASCADE;
DROP FUNCTION IF EXISTS handle_new_user() CASCADE;

-- Recreate functions and triggers
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_profiles_updated_at
    BEFORE UPDATE ON profiles
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_coverage_requirements_updated_at
    BEFORE UPDATE ON coverage_requirements
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_schedule_assignments_updated_at
    BEFORE UPDATE ON schedule_assignments
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_shift_swap_requests_updated_at
    BEFORE UPDATE ON shift_swap_requests
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_employee_availability_updated_at
    BEFORE UPDATE ON employee_availability
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_notifications_updated_at
    BEFORE UPDATE ON notifications
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- First, modify the profiles table to allow null organization_id initially
ALTER TABLE IF EXISTS profiles ALTER COLUMN organization_id DROP NOT NULL;

-- Add trigger for automatic profile creation on user signup
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
    -- Insert the new profile with proper error handling
    BEGIN
        INSERT INTO public.profiles (
            user_id,
            email,
            full_name,
            role,
            organization_id
        ) VALUES (
            NEW.id,
            COALESCE(NEW.email, 'no-email'),
            COALESCE(NEW.raw_user_meta_data->>'full_name', SPLIT_PART(NEW.email, '@', 1)),
            COALESCE(NEW.raw_user_meta_data->>'role', 'employee'),
            CASE 
                WHEN NEW.raw_user_meta_data->>'organization_id' IS NOT NULL 
                THEN (NEW.raw_user_meta_data->>'organization_id')::uuid 
                ELSE NULL 
            END
        );
    EXCEPTION WHEN OTHERS THEN
        RAISE EXCEPTION 'Failed to create profile: %. Ensure all required fields are provided.', SQLERRM;
    END;
    
    RETURN NEW;
END;
$$ language 'plpgsql' SECURITY DEFINER;

-- Trigger the function every time a user is created
CREATE TRIGGER on_auth_user_created
    AFTER INSERT ON auth.users
    FOR EACH ROW
    EXECUTE FUNCTION public.handle_new_user();

-- Drop existing policies if they exist
DROP POLICY IF EXISTS "Users can view their own profile" ON profiles;
DROP POLICY IF EXISTS "Users can update their own profile" ON profiles;
DROP POLICY IF EXISTS "Organization admins can view all profiles in their org" ON profiles;
DROP POLICY IF EXISTS "Organization admins can update profiles in their org" ON profiles;

-- Ensure RLS is enabled on the profiles table
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;

-- Recreate policies for the profiles table
CREATE POLICY "Users can view their own profile"
    ON profiles FOR SELECT
    USING (auth.uid() = user_id);

CREATE POLICY "Users can update their own profile"
    ON profiles FOR UPDATE
    USING (auth.uid() = user_id);

CREATE POLICY "Organization admins can view all profiles in their org"
    ON profiles FOR SELECT
    USING (
        EXISTS (
            SELECT 1 FROM profiles
            WHERE user_id = auth.uid()
            AND role = 'admin'
            AND organization_id IS NOT NULL
            AND organization_id = profiles.organization_id
        )
        OR profiles.organization_id IS NULL
    );

CREATE POLICY "Organization admins can update profiles in their org"
    ON profiles FOR UPDATE
    USING (
        EXISTS (
            SELECT 1 FROM profiles
            WHERE user_id = auth.uid()
            AND role = 'admin'
            AND organization_id IS NOT NULL
            AND organization_id = profiles.organization_id
        )
        OR profiles.organization_id IS NULL
    ); 