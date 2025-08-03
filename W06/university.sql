-- Forward Engineering Code for University Database
-- This creates the database structure

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema university
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `university` ;
CREATE SCHEMA IF NOT EXISTS `university` DEFAULT CHARACTER SET utf8 ;
USE `university` ;

-- -----------------------------------------------------
-- Table `university`.`College`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`College` (
  `college_id` INT NOT NULL AUTO_INCREMENT,
  `college_name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`college_id`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `university`.`Department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`Department` (
  `department_id` INT NOT NULL AUTO_INCREMENT,
  `department_code` VARCHAR(10) NOT NULL,
  `department_name` VARCHAR(100) NOT NULL,
  `college_id` INT NOT NULL,
  PRIMARY KEY (`department_id`),
  INDEX `fk_Department_College_idx` (`college_id` ASC) VISIBLE,
  CONSTRAINT `fk_Department_College`
    FOREIGN KEY (`college_id`)
    REFERENCES `university`.`College` (`college_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `university`.`Course`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`Course` (
  `course_id` INT NOT NULL AUTO_INCREMENT,
  `course_num` INT NOT NULL,
  `course_name` VARCHAR(100) NOT NULL,
  `credits` INT NOT NULL,
  `department_id` INT NOT NULL,
  PRIMARY KEY (`course_id`),
  INDEX `fk_Course_Department1_idx` (`department_id` ASC) VISIBLE,
  CONSTRAINT `fk_Course_Department1`
    FOREIGN KEY (`department_id`)
    REFERENCES `university`.`Department` (`department_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `university`.`Term`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`Term` (
  `term_id` INT NOT NULL AUTO_INCREMENT,
  `term_name` VARCHAR(10) NOT NULL,
  `year` YEAR NOT NULL,
  PRIMARY KEY (`term_id`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `university`.`Faculty`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`Faculty` (
  `faculty_id` INT NOT NULL AUTO_INCREMENT,
  `fname` VARCHAR(50) NOT NULL,
  `lname` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`faculty_id`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `university`.`Student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`Student` (
  `student_id` INT NOT NULL AUTO_INCREMENT,
  `fname` VARCHAR(50) NOT NULL,
  `lname` VARCHAR(50) NOT NULL,
  `birthdate` DATE NOT NULL,
  PRIMARY KEY (`student_id`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `university`.`Section`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`Section` (
  `section_id` INT NOT NULL AUTO_INCREMENT,
  `capacity` INT NOT NULL,
  `course_id` INT NOT NULL,
  `term_id` INT NOT NULL,
  `faculty_id` INT NOT NULL,
  PRIMARY KEY (`section_id`),
  INDEX `fk_Section_Course1_idx` (`course_id` ASC) VISIBLE,
  INDEX `fk_Section_Term1_idx` (`term_id` ASC) VISIBLE,
  INDEX `fk_Section_Faculty1_idx` (`faculty_id` ASC) VISIBLE,
  CONSTRAINT `fk_Section_Course1`
    FOREIGN KEY (`course_id`)
    REFERENCES `university`.`Course` (`course_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Section_Term1`
    FOREIGN KEY (`term_id`)
    REFERENCES `university`.`Term` (`term_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Section_Faculty1`
    FOREIGN KEY (`faculty_id`)
    REFERENCES `university`.`Faculty` (`faculty_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `university`.`Enrollment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`Enrollment` (
  `enrollment_id` INT NOT NULL AUTO_INCREMENT,
  `student_id` INT NOT NULL,
  `section_id` INT NOT NULL,
  PRIMARY KEY (`enrollment_id`),
  INDEX `fk_Enrollment_Student1_idx` (`student_id` ASC) VISIBLE,
  INDEX `fk_Enrollment_Section1_idx` (`section_id` ASC) VISIBLE,
  CONSTRAINT `fk_Enrollment_Student1`
    FOREIGN KEY (`student_id`)
    REFERENCES `university`.`Student` (`student_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Enrollment_Section1`
    FOREIGN KEY (`section_id`)
    REFERENCES `university`.`Section` (`section_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- Insert Statements for University Database

-- Insert Colleges
INSERT INTO College (college_name) VALUES 
('College of Physical Science and Engineering'),
('College of Business and Communication'),
('College of Language and Letters');

-- Insert Departments
INSERT INTO Department (department_code, department_name, college_id) VALUES 
('CIT', 'Computer Information Technology', 1),
('ECON', 'Economics', 2),
('HUM', 'Humanities and Philosophy', 3);

-- Insert Courses
INSERT INTO Course (course_num, course_name, credits, department_id) VALUES 
(111, 'Intro to Databases', 3, 1),
(150, 'Micro Economics', 3, 2),
(376, 'Classical Heritage', 2, 3),
(388, 'Econometrics', 4, 2);

-- Insert Terms
INSERT INTO Term (term_name, year) VALUES 
('Fall', 2019),
('Winter', 2018);

-- Insert Faculty
INSERT INTO Faculty (fname, lname) VALUES 
('Marty', 'Morning'),
('Nate', 'Norris'),
('Bill', 'Barney'),
('John', 'Jensen');

-- Insert Students
INSERT INTO Student (fname, lname, birthdate) VALUES 
('Paul', 'Miller', '1996-02-22'),
('Katie', 'Smith', '1995-07-22'),
('Kelly', 'Jones', '1998-06-22'),
('Susan', 'Sorensen', '1998-08-15'),
('Devon', 'Merrill', '2000-07-20'),
('Mandy', 'Murdock', '1997-11-22'),
('Alece', 'Adams', '1997-05-22'),
('Bryce', 'Carlson', '1997-11-22'),
('Preston', 'Larsen', '1996-09-22'),
('Julia', 'Madsen', '1998-09-22');

-- Insert Sections
INSERT INTO Section (capacity, course_id, term_id, faculty_id) VALUES 
(30, 1, 2, 1),  -- Winter 2018, CIT 111, Marty Morning
(30, 2, 2, 4),  -- Winter 2018, ECON 150, John Jensen
(35, 3, 2, 2),  -- Winter 2018, HUM 376, Nate Norris
(100, 4, 2, 3), -- Winter 2018, ECON 388, Bill Barney
(30, 1, 1, 4),  -- Fall 2019, CIT 111, John Jensen
(30, 2, 1, 1),  -- Fall 2019, ECON 150, Marty Morning
(35, 3, 1, 2),  -- Fall 2019, HUM 376, Nate Norris
(100, 4, 1, 3); -- Fall 2019, ECON 388, Bill Barney

-- Insert Enrollments
INSERT INTO Enrollment (student_id, section_id) VALUES 
(1, 1), (1, 2), (1, 3),  -- Paul Miller in 3 Winter 2018 courses
(2, 5), (2, 8),           -- Katie Smith in 2 Fall 2019 courses
(3, 5), (3, 6),           -- Kelly Jones in 2 Fall 2019 courses
(4, 7),                   -- Susan Sorensen in 1 Fall 2019 course
(5, 2),                   -- Devon Merrill in 1 Winter 2018 course
(6, 5), (6, 6), (6, 8),   -- Mandy Murdock in 3 Fall 2019 courses
(7, 6),                   -- Alece Adams in 1 Fall 2019 course
(8, 1), (8, 2), (8, 3),   -- Bryce Carlson in 3 Winter 2018 courses
(9, 4),                   -- Preston Larsen in 1 Winter 2018 course
(10, 7);                  -- Julia Madsen in 1 Fall 2019 course

-- Queries for University Database

-- Query 1: Students, and their birthdays, of students born in September. 
-- Format the date to look like it is shown in the result set. Sort by the student's last name.
SELECT 
    CONCAT(fname, ' ', lname) AS 'Student Name',
    DATE_FORMAT(birthdate, '%M %d, %Y') AS 'Sept Birthdays'
FROM 
    Student
WHERE 
    MONTH(birthdate) = 9
ORDER BY 
    lname;

-- Query 2: Student's age in years and days as of Jan. 5, 2017. 
-- Sorted from oldest to youngest. (You can assume a 365 day year and ignore leap day.)
SELECT 
    lname,
    fname,
    FLOOR(DATEDIFF('2017-01-05', birthdate) / 365) AS 'Years',
    MOD(DATEDIFF('2017-01-05', birthdate), 365) AS 'Days',
    CONCAT(FLOOR(DATEDIFF('2017-01-05', birthdate) / 365), ' - Yrs, ', 
           MOD(DATEDIFF('2017-01-05', birthdate), 365), ' - Days') AS 'Years and Days'
FROM 
    Student
ORDER BY 
    Years DESC, Days DESC;

-- Query 3: Students taught by John Jensen. Sorted by student's last name
SELECT 
    s.fname, s.lname
FROM 
    Student s
JOIN 
    Enrollment e ON s.student_id = e.student_id
JOIN 
    Section sec ON e.section_id = sec.section_id
JOIN 
    Faculty f ON sec.faculty_id = f.faculty_id
WHERE 
    f.fname = 'John' AND f.lname = 'Jensen'
ORDER BY 
    s.lname;

-- Query 4: Instructors Bryce will have in Winter 2018. Sort by the faculty's last name.
SELECT 
    f.fname, f.lname
FROM 
    Faculty f
JOIN 
    Section sec ON f.faculty_id = sec.faculty_id
JOIN 
    Term t ON sec.term_id = t.term_id
JOIN 
    Enrollment e ON sec.section_id = e.section_id
JOIN 
    Student s ON e.student_id = s.student_id
WHERE 
    s.fname = 'Bryce' AND s.lname = 'Carlson'
    AND t.term_name = 'Winter' AND t.year = 2018
ORDER BY 
    f.lname;

-- Query 5: Students that take Econometrics in Fall 2019. Sort by student last name.
SELECT 
    s.fname, s.lname
FROM 
    Student s
JOIN 
    Enrollment e ON s.student_id = e.student_id
JOIN 
    Section sec ON e.section_id = sec.section_id
JOIN 
    Course c ON sec.course_id = c.course_id
JOIN 
    Term t ON sec.term_id = t.term_id
WHERE 
    c.course_name = 'Econometrics'
    AND t.term_name = 'Fall' AND t.year = 2019
ORDER BY 
    s.lname;

-- Query 6: Report showing all of Bryce Carlson's courses for Winter 2018. Sort by the name of the course.
SELECT 
    d.department_code, c.course_num, c.course_name
FROM 
    Student s
JOIN 
    Enrollment e ON s.student_id = e.student_id
JOIN 
    Section sec ON e.section_id = sec.section_id
JOIN 
    Course c ON sec.course_id = c.course_id
JOIN 
    Department d ON c.department_id = d.department_id
JOIN 
    Term t ON sec.term_id = t.term_id
WHERE 
    s.fname = 'Bryce' AND s.lname = 'Carlson'
    AND t.term_name = 'Winter' AND t.year = 2018
ORDER BY 
    c.course_name;

-- Query 7: The number of students enrolled for Fall 2019
SELECT 
    t.term_name, t.year, COUNT(DISTINCT e.student_id) AS 'Enrollment'
FROM 
    Term t
JOIN 
    Section sec ON t.term_id = sec.term_id
JOIN 
    Enrollment e ON sec.section_id = e.section_id
WHERE 
    t.term_name = 'Fall' AND t.year = 2019;

-- Query 8: The number of courses in each college. Sort by college name.
SELECT 
    col.college_name AS 'Colleges', COUNT(c.course_id) AS 'Courses'
FROM 
    College col
JOIN 
    Department d ON col.college_id = d.college_id
JOIN 
    Course c ON d.department_id = c.department_id
GROUP BY 
    col.college_name
ORDER BY 
    col.college_name;

-- Query 9: The total number of students each professor can teach in Winter 2018. 
-- Sort by that total number of students (teaching capacity).
SELECT 
    f.fname, f.lname, SUM(sec.capacity) AS 'TeachingCapacity'
FROM 
    Faculty f
JOIN 
    Section sec ON f.faculty_id = sec.faculty_id
JOIN 
    Term t ON sec.term_id = t.term_id
WHERE 
    t.term_name = 'Winter' AND t.year = 2018
GROUP BY 
    f.faculty_id
ORDER BY 
    TeachingCapacity;

-- Query 10: Each student's total credit load for Fall 2019, but only students with a credit load greater than three. 
-- Sort by credit load in descending order.
SELECT 
    s.lname, s.fname, SUM(c.credits) AS 'Credits'
FROM 
    Student s
JOIN 
    Enrollment e ON s.student_id = e.student_id
JOIN 
    Section sec ON e.section_id = sec.section_id
JOIN 
    Course c ON sec.course_id = c.course_id
JOIN 
    Term t ON sec.term_id = t.term_id
WHERE 
    t.term_name = 'Fall' AND t.year = 2019
GROUP BY 
    s.student_id
HAVING 
    SUM(c.credits) > 3
ORDER BY 
    Credits DESC;