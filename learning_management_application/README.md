
# Task : Learning Management Application

## Overview

This is a simple Learning Management Application built using Ruby on Rails to practice ActiveRecord associations.

The application demonstrates different types of relationships between models such as `belongs_to`, `has_one`, `has_many`, `has_many :through`, and `has_and_belongs_to_many`.

---

## Associations Used

### 1. belongs_to (Course → Instructor)

* Each Course belongs to one Instructor.
* The `courses` table contains `instructor_id` as a foreign key.

```
Course belongs_to :instructor
Instructor has_many :courses
```

---

### 2. has_one (Course → FinalExam)

* Each Course has exactly one FinalExam.
* The `final_exams` table contains `course_id`.

```
Course has_one :final_exam
FinalExam belongs_to :course
```

---

### 3. has_many (Instructor → Courses)

* One Instructor can teach multiple Courses.
* The foreign key `instructor_id` is stored in the `courses` table.

```
Instructor has_many :courses
Course belongs_to :instructor
```

---

### 4. has_many :through (Student → Courses via Enrollments)

* A Student can enroll in many Courses.
* A Course can have many Students.
* The relationship is managed through the `enrollments` table.
* The `enrollments` table contains `student_id` and `course_id`.

```
Student has_many :enrollments
Student has_many :courses, through: :enrollments

Course has_many :enrollments
Course has_many :students, through: :enrollments

Enrollment belongs_to :student
Enrollment belongs_to :course
```

---

### 5. has_and_belongs_to_many (Course ↔ Tags)

* A Course can have many Tags.
* A Tag can belong to many Courses.
* This uses a simple join table `courses_tags`.
* No separate model is created for the join table.

```
Course has_and_belongs_to_many :tags
Tag has_and_belongs_to_many :courses
```

---

## Database Tables

* instructors
* courses
* final_exams
* students
* enrollments
* tags
* courses_tags

---

