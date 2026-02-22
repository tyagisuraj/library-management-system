-- creating a database 
create database library_mgmt_system;
-- using the database
 use library_mgmt_system;
-- creating table student to keep the record of students 
 CREATE TABLE Student (
    ->     student_id INT PRIMARY KEY AUTO_INCREMENT,
    ->     name VARCHAR(100) NOT NULL,
    ->     course VARCHAR(100),
    ->     year INT
    -> );
-- creating table to keep the record of books in the library
 CREATE TABLE Book (
    ->     book_id INT PRIMARY KEY AUTO_INCREMENT,
    ->     title VARCHAR(200) NOT NULL,
    ->     author VARCHAR(100),
    ->     publisher VARCHAR(100),
    ->     quantity INT DEFAULT 1
    -> );
-- creating table to keep the record of librarians
 CREATE TABLE Librarian (
    ->     librarian_id INT PRIMARY KEY AUTO_INCREMENT,
    ->     name VARCHAR(100) NOT NULL,
    ->     email VARCHAR(100),
    ->     phone VARCHAR(15),
    ->     shift VARCHAR(50)
    -> );
-- creating table to track record of books issued
 CREATE TABLE Issue (
    ->     issue_id INT PRIMARY KEY AUTO_INCREMENT,
    ->     student_id INT,
    ->     book_id INT,
    ->     librarian_id INT,
    ->     issue_date DATE,
    ->     return_date DATE,
    ->
    ->     FOREIGN KEY (student_id) REFERENCES Student(student_id),
    ->     FOREIGN KEY (book_id) REFERENCES Book(book_id),
    ->     FOREIGN KEY (librarian_id) REFERENCES Librarian(librarian_id)
    -> );
-- creating table to keep record to impose fine
 CREATE TABLE Fine (
    ->     fine_id INT PRIMARY KEY AUTO_INCREMENT,
    ->     issue_id INT,
    ->     amount DECIMAL(8,2),
    ->     days_late INT,
    ->
    ->     FOREIGN KEY (issue_id) REFERENCES Issue(issue_id)
    -> );
-- structure of tables fine,student,book,librarian and issue
 desc fine;
+-----------+--------------+------+-----+---------+----------------+
| Field     | Type         | Null | Key | Default | Extra          |
+-----------+--------------+------+-----+---------+----------------+
| fine_id   | int(11)      | NO   | PRI | NULL    | auto_increment |
| issue_id  | int(11)      | YES  | MUL | NULL    |                |
| amount    | decimal(8,2) | YES  |     | NULL    |                |
| days_late | int(11)      | YES  |     | NULL    |                |
+-----------+--------------+------+-----+---------+----------------+
 desc student;
+------------+--------------+------+-----+---------+----------------+
| Field      | Type         | Null | Key | Default | Extra          |
+------------+--------------+------+-----+---------+----------------+
| student_id | int(11)      | NO   | PRI | NULL    | auto_increment |
| name       | varchar(100) | NO   |     | NULL    |                |
| course     | varchar(100) | YES  |     | NULL    |                |
| year       | int(11)      | YES  |     | NULL    |                |
+------------+--------------+------+-----+---------+----------------+
 desc book;
+-----------+--------------+------+-----+---------+----------------+
| Field     | Type         | Null | Key | Default | Extra          |
+-----------+--------------+------+-----+---------+----------------+
| book_id   | int(11)      | NO   | PRI | NULL    | auto_increment |
| title     | varchar(200) | NO   |     | NULL    |                |
| author    | varchar(100) | YES  |     | NULL    |                |
| publisher | varchar(100) | YES  |     | NULL    |                |
| quantity  | int(11)      | YES  |     | 1       |                |
+-----------+--------------+------+-----+---------+----------------+
 desc librarian;
+--------------+--------------+------+-----+---------+----------------+
| Field        | Type         | Null | Key | Default | Extra          |
+--------------+--------------+------+-----+---------+----------------+
| librarian_id | int(11)      | NO   | PRI | NULL    | auto_increment |
| name         | varchar(100) | NO   |     | NULL    |                |
| email        | varchar(100) | YES  |     | NULL    |                |
| phone        | varchar(15)  | YES  |     | NULL    |                |
| shift        | varchar(50)  | YES  |     | NULL    |                |
+--------------+--------------+------+-----+---------+----------------+
desc issue;
+--------------+---------+------+-----+---------+----------------+
| Field        | Type    | Null | Key | Default | Extra          |
+--------------+---------+------+-----+---------+----------------+
| issue_id     | int(11) | NO   | PRI | NULL    | auto_increment |
| student_id   | int(11) | YES  | MUL | NULL    |                |
| book_id      | int(11) | YES  | MUL | NULL    |                |
| librarian_id | int(11) | YES  | MUL | NULL    |                |
| issue_date   | date    | YES  |     | NULL    |                |
| return_date  | date    | YES  |     | NULL    |                |
+--------------+---------+------+-----+---------+----------------+
