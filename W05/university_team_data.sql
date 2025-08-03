-- Insert departments
INSERT INTO departments (department_name) VALUES 
('Computer Science'), ('Mathematics'), ('Physics'), ('Biology'), ('Business');

-- Insert courses
INSERT INTO courses (course_name, department_id) VALUES
('Introduction to Programming', 1),
('Database Systems', 1),
('Calculus I', 2),
('Linear Algebra', 2),
('Quantum Mechanics', 3),
('Classical Physics', 3),
('Genetics', 4),
('Microbiology', 4),
('Financial Accounting', 5),
('Marketing Principles', 5);

-- Insert 15 students
INSERT INTO students (student_name, department_id, gpa) VALUES
('John Smith', 1, 3.75),
('Emily Johnson', 1, 3.90),
('Michael Brown', 2, 3.60),
('Sarah Davis', 2, 3.85),
('David Wilson', 3, 3.45),
('Jessica Martinez', 3, 3.70),
('Daniel Anderson', 4, 3.80),
('Olivia Taylor', 4, 3.95),
('James Thomas', 5, 3.50),
('Sophia Lee', 5, 3.65),
('Robert White', 1, 3.20),
('Emma Harris', 2, 3.55),
('William Clark', 3, 3.75),
('Ava Lewis', 4, 3.88),
('Joseph Young', 5, 3.40);

-- Insert enrollments (each student enrolled in 2-4 courses)
INSERT INTO enrollments (student_id, course_id, enrollment_date) VALUES
(1, 1, '2023-09-01'), (1, 2, '2023-09-01'), (1, 3, '2023-09-01'),
(2, 1, '2023-09-01'), (2, 4, '2023-09-01'),
(3, 3, '2023-09-01'), (3, 5, '2023-09-01'),
(4, 4, '2023-09-01'), (4, 6, '2023-09-01'),
(5, 5, '2023-09-01'), (5, 7, '2023-09-01'),
(6, 6, '2023-09-01'), (6, 8, '2023-09-01'),
(7, 7, '2023-09-01'), (7, 9, '2023-09-01'),
(8, 8, '2023-09-01'), (8, 10, '2023-09-01'),
(9, 9, '2023-09-01'), (9, 1, '2023-09-01'),
(10, 10, '2023-09-01'), (10, 2, '2023-09-01'),
(11, 1, '2023-09-01'), (11, 3, '2023-09-01'),
(12, 2, '2023-09-01'), (12, 4, '2023-09-01'),
(13, 3, '2023-09-01'), (13, 5, '2023-09-01'),
(14, 4, '2023-09-01'), (14, 6, '2023-09-01'),
(15, 5, '2023-09-01'), (15, 7, '2023-09-01');