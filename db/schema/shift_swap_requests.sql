CREATE TABLE shift_swap_requests (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    requester_id UUID NOT NULL,
    receiver_id UUID NOT NULL,
    original_assignment_id UUID NOT NULL,
    requested_shift_id UUID NOT NULL,
    status VARCHAR(20) DEFAULT 'pending' CHECK (status IN ('pending', 'approved', 'rejected')),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (requester_id) REFERENCES profiles(id) ON DELETE CASCADE,
    FOREIGN KEY (receiver_id) REFERENCES profiles(id) ON DELETE CASCADE,
    FOREIGN KEY (original_assignment_id) REFERENCES schedule_assignments(id) ON DELETE CASCADE,
    FOREIGN KEY (requested_shift_id) REFERENCES shifts(id) ON DELETE CASCADE
); 