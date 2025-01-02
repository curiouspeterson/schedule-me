-- Index on profiles email for quick lookup
CREATE INDEX idx_profiles_email ON profiles(email);

-- Index on schedule_assignments by employee_id
CREATE INDEX idx_schedule_assignments_employee_id ON schedule_assignments(employee_id);

-- Composite index on coverage_requirements for day_of_week and shift_id
CREATE INDEX idx_coverage_requirements_day_shift ON coverage_requirements(day_of_week, shift_id);

-- Index on employee_availability by employee_id
CREATE INDEX idx_employee_availability_employee_id ON employee_availability(employee_id);

-- Index on shift_swap_requests by requester_id and receiver_id
CREATE INDEX idx_shift_swap_requests_requester_receiver ON shift_swap_requests(requester_id, receiver_id);

-- Index on notifications by user_id and read status
CREATE INDEX idx_notifications_user_read ON notifications(user_id, read); 