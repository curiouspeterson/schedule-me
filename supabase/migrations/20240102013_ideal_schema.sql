-- Ideal Consolidated Database Schema for `schedule-me` Application

-- =========================================
-- Schema: public
-- =========================================

-- Enable necessary extensions
CREATE EXTENSION IF NOT EXISTS "pgcrypto"; -- For gen_random_uuid()

-- =========================================
-- Table: organizations
-- =========================================
CREATE TABLE IF NOT EXISTS public.organizations (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255) UNIQUE NOT NULL,
    address TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- =========================================
-- Table: roles
-- =========================================
CREATE TABLE IF NOT EXISTS public.roles (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(50) UNIQUE NOT NULL,
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- =========================================
-- Table: profiles
-- =========================================
CREATE TABLE IF NOT EXISTS public.profiles (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    full_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    avatar_url VARCHAR(255),
    role_id UUID NOT NULL,
    organization_id UUID NOT NULL,
    weekly_hours_limit INT DEFAULT 40,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (role_id) REFERENCES public.roles(id) ON DELETE CASCADE,
    FOREIGN KEY (organization_id) REFERENCES public.organizations(id) ON DELETE CASCADE
);

-- =========================================
-- Table: shifts
-- =========================================
CREATE TABLE IF NOT EXISTS public.shifts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(100) NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    is_overnight BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    
    CHECK (
        (NOT is_overnight AND start_time < end_time) OR
        (is_overnight AND start_time > end_time)
    )
);

-- =========================================
-- Table: schedules
-- =========================================
CREATE TABLE IF NOT EXISTS public.schedules (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    organization_id UUID NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    version INT DEFAULT 1,
    status VARCHAR(20) DEFAULT 'draft' CHECK (status IN ('draft', 'published')),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (organization_id) REFERENCES public.organizations(id) ON DELETE CASCADE,
    
    CHECK (start_date < end_date)
);

-- =========================================
-- Table: schedule_assignments
-- =========================================
CREATE TABLE IF NOT EXISTS public.schedule_assignments (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    schedule_id UUID NOT NULL,
    employee_id UUID NOT NULL,
    shift_id UUID NOT NULL,
    date DATE NOT NULL,
    assigned_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (schedule_id) REFERENCES public.schedules(id) ON DELETE CASCADE,
    FOREIGN KEY (employee_id) REFERENCES public.profiles(id) ON DELETE CASCADE,
    FOREIGN KEY (shift_id) REFERENCES public.shifts(id) ON DELETE CASCADE,
    
    UNIQUE (employee_id, date, shift_id)
);

-- =========================================
-- Table: shift_swap_requests
-- =========================================
CREATE TABLE IF NOT EXISTS public.shift_swap_requests (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    requester_id UUID NOT NULL,
    receiver_id UUID NOT NULL,
    original_assignment_id UUID NOT NULL,
    requested_shift_id UUID NOT NULL,
    status VARCHAR(20) DEFAULT 'pending' CHECK (status IN ('pending', 'approved', 'rejected')),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (requester_id) REFERENCES public.profiles(id) ON DELETE CASCADE,
    FOREIGN KEY (receiver_id) REFERENCES public.profiles(id) ON DELETE CASCADE,
    FOREIGN KEY (original_assignment_id) REFERENCES public.schedule_assignments(id) ON DELETE CASCADE,
    FOREIGN KEY (requested_shift_id) REFERENCES public.shifts(id) ON DELETE CASCADE
);

-- =========================================
-- Table: coverage_requirements
-- =========================================
CREATE TABLE IF NOT EXISTS public.coverage_requirements (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    organization_id UUID NOT NULL,
    day_of_week INT NOT NULL CHECK (day_of_week BETWEEN 1 AND 7),
    shift_id UUID NOT NULL,
    required_staff INT NOT NULL DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (organization_id) REFERENCES public.organizations(id) ON DELETE CASCADE,
    FOREIGN KEY (shift_id) REFERENCES public.shifts(id) ON DELETE CASCADE
);

-- =========================================
-- Table: employee_availability
-- =========================================
CREATE TABLE IF NOT EXISTS public.employee_availability (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    employee_id UUID NOT NULL,
    day_of_week INT NOT NULL CHECK (day_of_week BETWEEN 1 AND 7),
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (employee_id) REFERENCES public.profiles(id) ON DELETE CASCADE,
    
    CHECK (start_time < end_time)
);

-- =========================================
-- Table: notifications
-- =========================================
CREATE TABLE IF NOT EXISTS public.notifications (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL,
    title VARCHAR(255) NOT NULL,
    message TEXT NOT NULL,
    type VARCHAR(50),
    read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (user_id) REFERENCES public.profiles(id) ON DELETE CASCADE
);

-- =========================================
-- Indexes for Optimization
-- =========================================

-- Index on profiles email for quick lookup
CREATE INDEX IF NOT EXISTS idx_profiles_email ON public.profiles(email);

-- Index on schedule_assignments by employee_id
CREATE INDEX IF NOT EXISTS idx_schedule_assignments_employee_id ON public.schedule_assignments(employee_id);

-- Composite index on coverage_requirements for day_of_week and shift_id
CREATE INDEX IF NOT EXISTS idx_coverage_requirements_day_shift ON public.coverage_requirements(day_of_week, shift_id);

-- Index on employee_availability by employee_id
CREATE INDEX IF NOT EXISTS idx_employee_availability_employee_id ON public.employee_availability(employee_id);

-- Index on shift_swap_requests by requester_id and receiver_id
CREATE INDEX IF NOT EXISTS idx_shift_swap_requests_requester_receiver ON public.shift_swap_requests(requester_id, receiver_id);

-- Index on notifications by user_id and read status
CREATE INDEX IF NOT EXISTS idx_notifications_user_read ON public.notifications(user_id, read);

-- =========================================
-- Row-Level Security (RLS) Policies
-- =========================================

-- Enable RLS on all tables
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.organizations ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.roles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.shifts ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.schedules ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.schedule_assignments ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.coverage_requirements ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.employee_availability ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.notifications ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.shift_swap_requests ENABLE ROW LEVEL SECURITY;

-- -----------------------------------------
-- Policies for profiles
-- -----------------------------------------

-- Allow users to read their own profile
CREATE POLICY "Allow users to read their own profile"
    ON public.profiles
    FOR SELECT
    TO authenticated
    USING (id = auth.uid());

-- Allow users to update their own profile
CREATE POLICY "Allow users to update their own profile"
    ON public.profiles
    FOR UPDATE
    TO authenticated
    USING (id = auth.uid())
    WITH CHECK (id = auth.uid());

-- Allow users to insert their own profile during signup
CREATE POLICY "Allow users to insert their own profile"
    ON public.profiles
    FOR INSERT
    TO authenticated
    WITH CHECK (id = auth.uid());

-- Allow users to view profiles in the same organization
CREATE POLICY "Allow users to view profiles in their organization"
    ON public.profiles
    FOR SELECT
    TO authenticated
    USING (
        organization_id = (
            SELECT organization_id 
            FROM public.profiles 
            WHERE id = auth.uid()
        )
    );

-- -----------------------------------------
-- Policies for organizations
-- -----------------------------------------

-- Allow authenticated users to read organizations
CREATE POLICY "Allow authenticated users to read organizations"
    ON public.organizations
    FOR SELECT
    TO authenticated
    USING (true);

-- -----------------------------------------
-- Policies for roles
-- -----------------------------------------

-- Allow users with 'admin' role to view all roles
CREATE POLICY "Allow admins to view all roles"
    ON public.roles
    FOR SELECT
    TO authenticated
    USING (
        EXISTS (
            SELECT 1 
            FROM public.profiles p 
            JOIN public.roles r ON p.role_id = r.id 
            WHERE p.id = auth.uid() AND r.name = 'admin'
        )
    );

-- -----------------------------------------
-- Policies for shifts
-- -----------------------------------------

-- Allow authenticated users to read shifts
CREATE POLICY "Allow authenticated users to read shifts"
    ON public.shifts
    FOR SELECT
    TO authenticated
    USING (true);

-- -----------------------------------------
-- Policies for schedules
-- -----------------------------------------

-- Allow users to read schedules within their organization
CREATE POLICY "Allow users to read their organization's schedules"
    ON public.schedules
    FOR SELECT
    TO authenticated
    USING (
        organization_id = (
            SELECT organization_id 
            FROM public.profiles 
            WHERE id = auth.uid()
        )
    );

-- -----------------------------------------
-- Policies for schedule_assignments
-- -----------------------------------------

-- Allow users to read their own assignments or assignments within their organization
CREATE POLICY "Allow users to read their own assignments or organization's assignments"
    ON public.schedule_assignments
    FOR SELECT
    TO authenticated
    USING (
        employee_id = auth.uid() OR
        schedule_id IN (
            SELECT id 
            FROM public.schedules 
            WHERE organization_id = (
                SELECT organization_id 
                FROM public.profiles 
                WHERE id = auth.uid()
            )
        )
    );

-- -----------------------------------------
-- Policies for coverage_requirements
-- -----------------------------------------

-- Allow users to read coverage requirements within their organization
CREATE POLICY "Allow users to read coverage requirements in their organization"
    ON public.coverage_requirements
    FOR SELECT
    TO authenticated
    USING (
        organization_id = (
            SELECT organization_id 
            FROM public.profiles 
            WHERE id = auth.uid()
        )
    );

-- -----------------------------------------
-- Policies for employee_availability
-- -----------------------------------------

-- Allow users to manage their own availability
CREATE POLICY "Users can manage their availability"
    ON public.employee_availability
    FOR ALL
    TO authenticated
    USING (employee_id = auth.uid())
    WITH CHECK (employee_id = auth.uid());

-- -----------------------------------------
-- Policies for notifications
-- -----------------------------------------

-- Allow users to manage their notifications
CREATE POLICY "Users can manage their notifications"
    ON public.notifications
    FOR ALL
    TO authenticated
    USING (user_id = auth.uid())
    WITH CHECK (user_id = auth.uid());

-- -----------------------------------------
-- Policies for shift_swap_requests
-- -----------------------------------------

-- Allow users to view and manage their own swap requests
CREATE POLICY "Users can view and manage swap requests"
    ON public.shift_swap_requests
    FOR ALL
    TO authenticated
    USING (requester_id = auth.uid() OR receiver_id = auth.uid())
    WITH CHECK (requester_id = auth.uid());

-- =========================================
-- Grant Permissions
-- =========================================

-- Grant usage on schema to authenticated and anon users
GRANT USAGE ON SCHEMA public TO authenticated;
GRANT USAGE ON SCHEMA public TO anon;

-- Grant select, insert, update, delete based on policies
GRANT SELECT, INSERT, UPDATE, DELETE ON public.profiles TO authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.organizations TO authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.roles TO authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.shifts TO authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.schedules TO authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.schedule_assignments TO authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.coverage_requirements TO authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.employee_availability TO authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.notifications TO authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.shift_swap_requests TO authenticated;

-- Grant necessary permissions to anon users (e.g., for signup)
GRANT INSERT ON public.profiles TO anon;

-- =========================================
-- Seed Data (Optional)
-- =========================================

-- Uncomment the following section if you want to include seed data within this schema.

-- /*
-- -- Insert default roles
-- INSERT INTO public.roles (id, name, description, created_at) VALUES
--     ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'admin', 'Administrator with full access', NOW()),
--     ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'manager', 'Schedule manager', NOW()),
--     ('cccccccc-cccc-cccc-cccc-cccccccccccc', 'user', 'Regular employee', NOW())
-- ON CONFLICT (name) DO NOTHING;

-- -- Insert default organization
-- INSERT INTO public.organizations (id, name, address, created_at) VALUES
--     ('11111111-1111-1111-1111-111111111111', 'Acme Corp', '123 Main St, San Francisco, CA 94105', NOW())
-- ON CONFLICT (name) DO NOTHING;

-- -- Insert default shifts
-- INSERT INTO public.shifts (id, name, start_time, end_time, is_overnight, created_at) VALUES
--     ('dddddddd-dddd-dddd-dddd-dddddddddddd', 'Morning', '08:00:00', '16:00:00', FALSE, NOW()),
--     ('eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee', 'Afternoon', '16:00:00', '23:59:00', FALSE, NOW()),
--     ('ffffffff-ffff-ffff-ffff-ffffffffffff', 'Night', '22:00:00', '06:00:00', TRUE, NOW())
-- ON CONFLICT (name) DO NOTHING;
-- */

-- =========================================
-- End of Ideal Consolidated Schema
-- =========================================