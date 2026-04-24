-- The database was normalized to remove redundancy and improve data integrity.


-- In 1NF, all attributes were made atomic and repeating groups were removed.


-- In 2NF, partial dependencies were eliminated by creating a separate Course table and linking it with the Student table using a foreign key.


-- In 3NF, transitive dependencies were removed by creating separate Publisher and Author tables. A junction table Book_Author was used to manage the many-to-many relationship between books and authors.


-- Thus, the database is successfully normalized up to Third Normal Form (3NF).

MariaDB [(none)]> use library_mgmt_system;
Database changed
MariaDB [library_mgmt_system]> CREATE TABLE Course (
    ->     course_id INT PRIMARY KEY AUTO_INCREMENT,
    ->     course_name VARCHAR(100)
    -> );
Query OK, 0 rows affected (0.006 sec)

MariaDB [library_mgmt_system]> INSERT INTO Course (course_name)
    -> SELECT DISTINCT course FROM Student;
Query OK, 4 rows affected (0.027 sec)
Records: 4  Duplicates: 0  Warnings: 0

MariaDB [library_mgmt_system]> ALTER TABLE Student ADD course_id INT;
Query OK, 0 rows affected (0.006 sec)
Records: 0  Duplicates: 0  Warnings: 0

MariaDB [library_mgmt_system]> UPDATE Student S
    -> JOIN Course C ON S.course = C.course_name
    -> SET S.course_id = C.course_id;
Query OK, 10 rows affected (0.003 sec)
Rows matched: 10  Changed: 10  Warnings: 0

MariaDB [library_mgmt_system]> ALTER TABLE Student DROP COLUMN course;
Query OK, 0 rows affected (0.005 sec)
Records: 0  Duplicates: 0  Warnings: 0

MariaDB [library_mgmt_system]>
MariaDB [library_mgmt_system]> ALTER TABLE Student
    -> ADD FOREIGN KEY (course_id) REFERENCES Course(course_id);
Query OK, 10 rows affected (0.040 sec)
Records: 10  Duplicates: 0  Warnings: 0

MariaDB [library_mgmt_system]> CREATE TABLE Publisher (
    ->     publisher_id INT PRIMARY KEY AUTO_INCREMENT,
    ->     publisher_name VARCHAR(100)
    -> );
Query OK, 0 rows affected (0.009 sec)

MariaDB [library_mgmt_system]> INSERT INTO Publisher (publisher_name)
    -> SELECT DISTINCT publisher FROM Book;
Query OK, 6 rows affected (0.007 sec)
Records: 6  Duplicates: 0  Warnings: 0

MariaDB [library_mgmt_system]> ALTER TABLE Book ADD publisher_id INT;
Query OK, 0 rows affected (0.008 sec)
Records: 0  Duplicates: 0  Warnings: 0

MariaDB [library_mgmt_system]> UPDATE Book B
    -> JOIN Publisher P ON B.publisher = P.publisher_name
    -> SET B.publisher_id = P.publisher_id;
Query OK, 20 rows affected (0.003 sec)
Rows matched: 20  Changed: 20  Warnings: 0

MariaDB [library_mgmt_system]> ALTER TABLE Book DROP COLUMN publisher;
Query OK, 0 rows affected (0.007 sec)
Records: 0  Duplicates: 0  Warnings: 0

MariaDB [library_mgmt_system]>
MariaDB [library_mgmt_system]> ALTER TABLE Book
    -> ADD FOREIGN KEY (publisher_id) REFERENCES Publisher(publisher_id);
Query OK, 20 rows affected (0.038 sec)
Records: 20  Duplicates: 0  Warnings: 0

MariaDB [library_mgmt_system]> CREATE TABLE Author (
    ->     author_id INT PRIMARY KEY AUTO_INCREMENT,
    ->     author_name VARCHAR(100)
    -> );
Query OK, 0 rows affected (0.010 sec)

MariaDB [library_mgmt_system]> INSERT INTO Author (author_name)
    -> SELECT DISTINCT author FROM Book;
Query OK, 10 rows affected (0.005 sec)
Records: 10  Duplicates: 0  Warnings: 0

MariaDB [library_mgmt_system]> CREATE TABLE Book_Author (
    ->     book_id INT,
    ->     author_id INT,
    ->     FOREIGN KEY (book_id) REFERENCES Book(book_id),
    ->     FOREIGN KEY (author_id) REFERENCES Author(author_id)
    -> );
Query OK, 0 rows affected (0.019 sec)

MariaDB [library_mgmt_system]> INSERT INTO Book_Author (book_id, author_id)
    -> SELECT B.book_id, A.author_id
    -> FROM Book B
    -> JOIN Author A ON B.author = A.author_name;
Query OK, 20 rows affected (0.006 sec)
Records: 20  Duplicates: 0  Warnings: 0

MariaDB [library_mgmt_system]> ALTER TABLE Book DROP COLUMN author;
Query OK, 0 rows affected (0.008 sec)
Records: 0  Duplicates: 0  Warnings: 0

MariaDB [library_mgmt_system]> DESC Student;
+------------+--------------+------+-----+---------+----------------+
| Field      | Type         | Null | Key | Default | Extra          |
+------------+--------------+------+-----+---------+----------------+
| student_id | int(11)      | NO   | PRI | NULL    | auto_increment |
| name       | varchar(100) | NO   |     | NULL    |                |
| year       | int(11)      | YES  |     | NULL    |                |
| course_id  | int(11)      | YES  | MUL | NULL    |                |
+------------+--------------+------+-----+---------+----------------+
4 rows in set (0.013 sec)

MariaDB [library_mgmt_system]> DESC Book;
+--------------+--------------+------+-----+---------+----------------+
| Field        | Type         | Null | Key | Default | Extra          |
+--------------+--------------+------+-----+---------+----------------+
| book_id      | int(11)      | NO   | PRI | NULL    | auto_increment |
| title        | varchar(200) | NO   |     | NULL    |                |
| quantity     | int(11)      | YES  |     | 1       |                |
| publisher_id | int(11)      | YES  | MUL | NULL    |                |
+--------------+--------------+------+-----+---------+----------------+
4 rows in set (0.004 sec)

MariaDB [library_mgmt_system]> DESC Course;
+-------------+--------------+------+-----+---------+----------------+
| Field       | Type         | Null | Key | Default | Extra          |
+-------------+--------------+------+-----+---------+----------------+
| course_id   | int(11)      | NO   | PRI | NULL    | auto_increment |
| course_name | varchar(100) | YES  |     | NULL    |                |
+-------------+--------------+------+-----+---------+----------------+
2 rows in set (0.005 sec)

MariaDB [library_mgmt_system]> DESC Author;
+-------------+--------------+------+-----+---------+----------------+
| Field       | Type         | Null | Key | Default | Extra          |
+-------------+--------------+------+-----+---------+----------------+
| author_id   | int(11)      | NO   | PRI | NULL    | auto_increment |
| author_name | varchar(100) | YES  |     | NULL    |                |
+-------------+--------------+------+-----+---------+----------------+
2 rows in set (0.013 sec)

MariaDB [library_mgmt_system]> DESC Book_Author;
+-----------+---------+------+-----+---------+-------+
| Field     | Type    | Null | Key | Default | Extra |
+-----------+---------+------+-----+---------+-------+
| book_id   | int(11) | YES  | MUL | NULL    |       |
| author_id | int(11) | YES  | MUL | NULL    |       |
+-----------+---------+------+-----+---------+-------+
2 rows in set (0.015 sec)

MariaDB [library_mgmt_system]> DESC Book_Author;
+-----------+---------+------+-----+---------+-------+
| Field     | Type    | Null | Key | Default | Extra |
+-----------+---------+------+-----+---------+-------+
| book_id   | int(11) | YES  | MUL | NULL    |       |
| author_id | int(11) | YES  | MUL | NULL    |       |
+-----------+---------+------+-----+---------+-------+
2 rows in set (0.012 sec)

MariaDB [library_mgmt_system]> ALTER TABLE Book_Author
    -> ADD PRIMARY KEY (book_id, author_id);
Query OK, 0 rows affected (0.035 sec)
Records: 0  Duplicates: 0  Warnings: 0

MariaDB [library_mgmt_system]> DESC Student;
+------------+--------------+------+-----+---------+----------------+
| Field      | Type         | Null | Key | Default | Extra          |
+------------+--------------+------+-----+---------+----------------+
| student_id | int(11)      | NO   | PRI | NULL    | auto_increment |
| name       | varchar(100) | NO   |     | NULL    |                |
| year       | int(11)      | YES  |     | NULL    |                |
| course_id  | int(11)      | YES  | MUL | NULL    |                |
+------------+--------------+------+-----+---------+----------------+
4 rows in set (0.013 sec)

MariaDB [library_mgmt_system]> DESC Course;
+-------------+--------------+------+-----+---------+----------------+
| Field       | Type         | Null | Key | Default | Extra          |
+-------------+--------------+------+-----+---------+----------------+
| course_id   | int(11)      | NO   | PRI | NULL    | auto_increment |
| course_name | varchar(100) | YES  |     | NULL    |                |
+-------------+--------------+------+-----+---------+----------------+
2 rows in set (0.004 sec)

MariaDB [library_mgmt_system]> DESC Book;
+--------------+--------------+------+-----+---------+----------------+
| Field        | Type         | Null | Key | Default | Extra          |
+--------------+--------------+------+-----+---------+----------------+
| book_id      | int(11)      | NO   | PRI | NULL    | auto_increment |
| title        | varchar(200) | NO   |     | NULL    |                |
| quantity     | int(11)      | YES  |     | 1       |                |
| publisher_id | int(11)      | YES  | MUL | NULL    |                |
+--------------+--------------+------+-----+---------+----------------+
4 rows in set (0.004 sec)

MariaDB [library_mgmt_system]> DESC Author;
+-------------+--------------+------+-----+---------+----------------+
| Field       | Type         | Null | Key | Default | Extra          |
+-------------+--------------+------+-----+---------+----------------+
| author_id   | int(11)      | NO   | PRI | NULL    | auto_increment |
| author_name | varchar(100) | YES  |     | NULL    |                |
+-------------+--------------+------+-----+---------+----------------+
2 rows in set (0.004 sec)

MariaDB [library_mgmt_system]> DESC Book_Author;
+-----------+---------+------+-----+---------+-------+
| Field     | Type    | Null | Key | Default | Extra |
+-----------+---------+------+-----+---------+-------+
| book_id   | int(11) | NO   | PRI | NULL    |       |
| author_id | int(11) | NO   | PRI | NULL    |       |
+-----------+---------+------+-----+---------+-------+
2 rows in set (0.004 sec)

MariaDB [library_mgmt_system]> DESC Publisher;
+----------------+--------------+------+-----+---------+----------------+
| Field          | Type         | Null | Key | Default | Extra          |
+----------------+--------------+------+-----+---------+----------------+
| publisher_id   | int(11)      | NO   | PRI | NULL    | auto_increment |
| publisher_name | varchar(100) | YES  |     | NULL    |                |
+----------------+--------------+------+-----+---------+----------------+
2 rows in set (0.004 sec)

MariaDB [library_mgmt_system]> DESC Issue;
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
6 rows in set (0.005 sec)

MariaDB [library_mgmt_system]> DESC Fine;
+-----------+--------------+------+-----+---------+----------------+
| Field     | Type         | Null | Key | Default | Extra          |
+-----------+--------------+------+-----+---------+----------------+
| fine_id   | int(11)      | NO   | PRI | NULL    | auto_increment |
| issue_id  | int(11)      | YES  | MUL | NULL    |                |
| amount    | decimal(8,2) | YES  |     | NULL    |                |
| days_late | int(11)      | YES  |     | NULL    |                |
+-----------+--------------+------+-----+---------+----------------+
4 rows in set (0.017 sec)

MariaDB [library_mgmt_system]> SELECT * FROM Book_Author;
+---------+-----------+
| book_id | author_id |
+---------+-----------+
|       1 |         1 |
|       2 |         2 |
|       3 |         3 |
|       4 |         4 |
|       5 |         5 |
|       6 |         6 |
|       7 |         7 |
|       8 |         8 |
|       9 |         9 |
|      10 |        10 |
|      11 |         1 |
|      12 |         2 |
|      13 |         3 |
|      14 |         4 |
|      15 |         5 |
|      16 |         6 |
|      17 |         7 |
|      18 |         8 |
|      19 |         9 |
|      20 |        10 |
+---------+-----------+
20 rows in set (0.000 sec)

MariaDB [library_mgmt_system]> SELECT * FROM Course;
+-----------+-------------+
| course_id | course_name |
+-----------+-------------+
|         1 | BTech       |
|         2 | BCA         |
|         3 | BBA         |
|         4 | BCom        |
+-----------+-------------+
4 rows in set (0.003 sec)

MariaDB [library_mgmt_system]> SELECT * FROM Publisher;
+--------------+----------------+
| publisher_id | publisher_name |
+--------------+----------------+
|            1 | Pearson        |
|            2 | Wiley          |
|            3 | McGraw Hill    |
|            4 | OReilly        |
|            5 | Oracle Press   |
|            6 | PHI            |
+--------------+----------------+
6 rows in set (0.000 sec)

MariaDB [library_mgmt_system]> ALTER TABLE Student MODIFY course_id INT NOT NULL;
Query OK, 0 rows affected (0.028 sec)
Records: 0  Duplicates: 0  Warnings: 0

MariaDB [library_mgmt_system]> ALTER TABLE Book MODIFY publisher_id INT NOT NULL;
Query OK, 0 rows affected (0.030 sec)
Records: 0  Duplicates: 0  Warnings: 0

MariaDB [library_mgmt_system]> DESC Student;
+------------+--------------+------+-----+---------+----------------+
| Field      | Type         | Null | Key | Default | Extra          |
+------------+--------------+------+-----+---------+----------------+
| student_id | int(11)      | NO   | PRI | NULL    | auto_increment |
| name       | varchar(100) | NO   |     | NULL    |                |
| year       | int(11)      | YES  |     | NULL    |                |
| course_id  | int(11)      | NO   | MUL | NULL    |                |
+------------+--------------+------+-----+---------+----------------+
4 rows in set (0.011 sec)

MariaDB [library_mgmt_system]> DESC Course;
+-------------+--------------+------+-----+---------+----------------+
| Field       | Type         | Null | Key | Default | Extra          |
+-------------+--------------+------+-----+---------+----------------+
| course_id   | int(11)      | NO   | PRI | NULL    | auto_increment |
| course_name | varchar(100) | YES  |     | NULL    |                |
+-------------+--------------+------+-----+---------+----------------+
2 rows in set (0.003 sec)

MariaDB [library_mgmt_system]> DESC Book;
+--------------+--------------+------+-----+---------+----------------+
| Field        | Type         | Null | Key | Default | Extra          |
+--------------+--------------+------+-----+---------+----------------+
| book_id      | int(11)      | NO   | PRI | NULL    | auto_increment |
| title        | varchar(200) | NO   |     | NULL    |                |
| quantity     | int(11)      | YES  |     | 1       |                |
| publisher_id | int(11)      | NO   | MUL | NULL    |                |
+--------------+--------------+------+-----+---------+----------------+
4 rows in set (0.003 sec)

MariaDB [library_mgmt_system]> DESC Author;
+-------------+--------------+------+-----+---------+----------------+
| Field       | Type         | Null | Key | Default | Extra          |
+-------------+--------------+------+-----+---------+----------------+
| author_id   | int(11)      | NO   | PRI | NULL    | auto_increment |
| author_name | varchar(100) | YES  |     | NULL    |                |
+-------------+--------------+------+-----+---------+----------------+
2 rows in set (0.004 sec)

MariaDB [library_mgmt_system]> DESC Book_Author;
+-----------+---------+------+-----+---------+-------+
| Field     | Type    | Null | Key | Default | Extra |
+-----------+---------+------+-----+---------+-------+
| book_id   | int(11) | NO   | PRI | NULL    |       |
| author_id | int(11) | NO   | PRI | NULL    |       |
+-----------+---------+------+-----+---------+-------+
2 rows in set (0.004 sec)

MariaDB [library_mgmt_system]> DESC Publisher;
+----------------+--------------+------+-----+---------+----------------+
| Field          | Type         | Null | Key | Default | Extra          |
+----------------+--------------+------+-----+---------+----------------+
| publisher_id   | int(11)      | NO   | PRI | NULL    | auto_increment |
| publisher_name | varchar(100) | YES  |     | NULL    |                |
+----------------+--------------+------+-----+---------+----------------+
2 rows in set (0.003 sec)

MariaDB [library_mgmt_system]> DESC Issue;
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
6 rows in set (0.003 sec)

MariaDB [library_mgmt_system]> DESC Fine;
+-----------+--------------+------+-----+---------+----------------+
| Field     | Type         | Null | Key | Default | Extra          |
+-----------+--------------+------+-----+---------+----------------+
| fine_id   | int(11)      | NO   | PRI | NULL    | auto_increment |
| issue_id  | int(11)      | YES  | MUL | NULL    |                |
| amount    | decimal(8,2) | YES  |     | NULL    |                |
| days_late | int(11)      | YES  |     | NULL    |                |
+-----------+--------------+------+-----+---------+----------------+
4 rows in set (0.014 sec)

MariaDB [library_mgmt_system]> SELECT * FROM Book_Author;
+---------+-----------+
| book_id | author_id |
+---------+-----------+
|       1 |         1 |
|       2 |         2 |
|       3 |         3 |
|       4 |         4 |
|       5 |         5 |
|       6 |         6 |
|       7 |         7 |
|       8 |         8 |
|       9 |         9 |
|      10 |        10 |
|      11 |         1 |
|      12 |         2 |
|      13 |         3 |
|      14 |         4 |
|      15 |         5 |
|      16 |         6 |
|      17 |         7 |
|      18 |         8 |
|      19 |         9 |
|      20 |        10 |
+---------+-----------+
20 rows in set (0.000 sec)

MariaDB [library_mgmt_system]> SELECT * FROM Course;
+-----------+-------------+
| course_id | course_name |
+-----------+-------------+
|         1 | BTech       |
|         2 | BCA         |
|         3 | BBA         |
|         4 | BCom        |
+-----------+-------------+
4 rows in set (0.000 sec)

MariaDB [library_mgmt_system]> SELECT * FROM Publisher;
+--------------+----------------+
| publisher_id | publisher_name |
+--------------+----------------+
|            1 | Pearson        |
|            2 | Wiley          |
|            3 | McGraw Hill    |
|            4 | OReilly        |
|            5 | Oracle Press   |
|            6 | PHI            |
+--------------+----------------+
6 rows in set (0.000 sec)

MariaDB [library_mgmt_system]> SELECT * FROM Student;
+------------+--------------+------+-----------+
| student_id | name         | year | course_id |
+------------+--------------+------+-----------+
|          1 | Rahul Sharma |    2 |         1 |
|          2 | Aman Verma   |    1 |         2 |
|          3 | Sneha Gupta  |    3 |         1 |
|          4 | Priya Singh  |    2 |         3 |
|          5 | Rohit Kumar  |    4 |         1 |
|          6 | Anjali Mehta |    2 |         2 |
|          7 | Karan Patel  |    1 |         4 |
|          8 | Neha Jain    |    3 |         3 |
|          9 | Vikas Yadav  |    2 |         1 |
|         10 | Pooja Kapoor |    1 |         2 |
+------------+--------------+------+-----------+
10 rows in set (0.001 sec)

MariaDB [library_mgmt_system]> SELECT S.*
    -> FROM Student S
    -> JOIN Course C ON S.course_id = C.course_id
    -> WHERE C.course_name = 'BTech';
+------------+--------------+------+-----------+
| student_id | name         | year | course_id |
+------------+--------------+------+-----------+
|          1 | Rahul Sharma |    2 |         1 |
|          3 | Sneha Gupta  |    3 |         1 |
|          5 | Rohit Kumar  |    4 |         1 |
|          9 | Vikas Yadav  |    2 |         1 |
+------------+--------------+------+-----------+
4 rows in set (0.001 sec)

MariaDB [library_mgmt_system]> SELECT * FROM Book
    -> WHERE quantity > 3;
+---------+----------------------+----------+--------------+
| book_id | title                | quantity | publisher_id |
+---------+----------------------+----------+--------------+
|       1 | DBMS Concepts        |        5 |            1 |
|       2 | Operating Systems    |        4 |            2 |
|       3 | Data Structures      |        6 |            3 |
|       5 | Software Engineering |        5 |            3 |
|       6 | Python Programming   |        7 |            4 |
|       7 | Java Basics          |        6 |            5 |
|       8 | C Programming        |        4 |            6 |
|      11 | DBMS Concepts        |        5 |            1 |
|      12 | Operating Systems    |        4 |            2 |
|      13 | Data Structures      |        6 |            3 |
|      15 | Software Engineering |        5 |            3 |
|      16 | Python Programming   |        7 |            4 |
|      17 | Java Basics          |        6 |            5 |
|      18 | C Programming        |        4 |            6 |
+---------+----------------------+----------+--------------+
14 rows in set (0.000 sec)

MariaDB [library_mgmt_system]> SELECT S.name, I.book_id
    -> FROM Student S
    -> JOIN Issue I ON S.student_id = I.student_id;
+--------------+---------+
| name         | book_id |
+--------------+---------+
| Rahul Sharma |       1 |
| Aman Verma   |       2 |
| Sneha Gupta  |       3 |
| Priya Singh  |       4 |
| Rohit Kumar  |       5 |
| Anjali Mehta |       6 |
| Karan Patel  |       7 |
| Neha Jain    |       8 |
| Vikas Yadav  |       9 |
| Pooja Kapoor |      10 |
+--------------+---------+
10 rows in set (0.000 sec)

MariaDB [library_mgmt_system]> SELECT S.name, B.title
    -> FROM Student S
    -> JOIN Issue I ON S.student_id = I.student_id
    -> JOIN Book B ON I.book_id = B.book_id;
+--------------+----------------------+
| name         | title                |
+--------------+----------------------+
| Rahul Sharma | DBMS Concepts        |
| Aman Verma   | Operating Systems    |
| Sneha Gupta  | Data Structures      |
| Priya Singh  | Computer Networks    |
| Rohit Kumar  | Software Engineering |
| Anjali Mehta | Python Programming   |
| Karan Patel  | Java Basics          |
| Neha Jain    | C Programming        |
| Vikas Yadav  | AI Basics            |
| Pooja Kapoor | Machine Learning     |
+--------------+----------------------+
10 rows in set (0.001 sec)

MariaDB [library_mgmt_system]> SELECT name
    -> FROM Student
    -> WHERE student_id NOT IN (SELECT student_id FROM Issue);
Empty set (0.003 sec)

MariaDB [library_mgmt_system]> SELECT B.title, I.issue_date, I.return_date
    -> FROM Book B
    -> JOIN Issue I ON B.book_id = I.book_id;
+----------------------+------------+-------------+
| title                | issue_date | return_date |
+----------------------+------------+-------------+
| DBMS Concepts        | 2026-03-01 | 2026-03-10  |
| Operating Systems    | 2026-03-02 | 2026-03-12  |
| Data Structures      | 2026-03-03 | 2026-03-13  |
| Computer Networks    | 2026-03-04 | 2026-03-14  |
| Software Engineering | 2026-03-05 | 2026-03-15  |
| Python Programming   | 2026-03-06 | 2026-03-16  |
| Java Basics          | 2026-03-07 | 2026-03-17  |
| C Programming        | 2026-03-08 | 2026-03-18  |
| AI Basics            | 2026-03-09 | 2026-03-19  |
| Machine Learning     | 2026-03-10 | 2026-03-20  |
+----------------------+------------+-------------+
10 rows in set (0.000 sec)

MariaDB [library_mgmt_system]> SELECT DISTINCT S.name
    -> FROM Student S
    -> JOIN Issue I ON S.student_id = I.student_id
    -> JOIN Fine F ON I.issue_id = F.issue_id
    -> WHERE F.days_late > 0;
+--------------+
| name         |
+--------------+
| Rahul Sharma |
| Sneha Gupta  |
| Rohit Kumar  |
| Anjali Mehta |
| Neha Jain    |
| Pooja Kapoor |
+--------------+
6 rows in set (0.001 sec)

MariaDB [library_mgmt_system]> SELECT SUM(amount) AS total_fine
    -> FROM Fine;
+------------+
| total_fine |
+------------+
|     300.00 |
+------------+
1 row in set (0.000 sec)

MariaDB [library_mgmt_system]> SELECT S.name, COUNT(I.issue_id) AS total_books
    -> FROM Student S
    -> JOIN Issue I ON S.student_id = I.student_id
    -> GROUP BY S.name;
+--------------+-------------+
| name         | total_books |
+--------------+-------------+
| Aman Verma   |           1 |
| Anjali Mehta |           1 |
| Karan Patel  |           1 |
| Neha Jain    |           1 |
| Pooja Kapoor |           1 |
| Priya Singh  |           1 |
| Rahul Sharma |           1 |
| Rohit Kumar  |           1 |
| Sneha Gupta  |           1 |
| Vikas Yadav  |           1 |
+--------------+-------------+
10 rows in set (0.000 sec)

MariaDB [library_mgmt_system]> SELECT B.title, A.author_name
    -> FROM Book B
    -> JOIN Book_Author BA ON B.book_id = BA.book_id
    -> JOIN Author A ON BA.author_id = A.author_id;
+----------------------+-----------------+
| title                | author_name     |
+----------------------+-----------------+
| DBMS Concepts        | Korth           |
| DBMS Concepts        | Korth           |
| Operating Systems    | Galvin          |
| Operating Systems    | Galvin          |
| Data Structures      | Sahni           |
| Data Structures      | Sahni           |
| Computer Networks    | Tanenbaum       |
| Computer Networks    | Tanenbaum       |
| Software Engineering | Pressman        |
| Software Engineering | Pressman        |
| Python Programming   | Guido           |
| Python Programming   | Guido           |
| Java Basics          | Herbert Schildt |
| Java Basics          | Herbert Schildt |
| C Programming        | Dennis Ritchie  |
| C Programming        | Dennis Ritchie  |
| AI Basics            | Stuart Russell  |
| AI Basics            | Stuart Russell  |
| Machine Learning     | Tom Mitchell    |
| Machine Learning     | Tom Mitchell    |
+----------------------+-----------------+
20 rows in set (0.001 sec)

MariaDB [library_mgmt_system]> SELECT B.title, P.publisher_name
    -> FROM Book B
    -> JOIN Publisher P ON B.publisher_id = P.publisher_id;
+----------------------+----------------+
| title                | publisher_name |
+----------------------+----------------+
| DBMS Concepts        | Pearson        |
| Computer Networks    | Pearson        |
| AI Basics            | Pearson        |
| DBMS Concepts        | Pearson        |
| Computer Networks    | Pearson        |
| AI Basics            | Pearson        |
| Operating Systems    | Wiley          |
| Operating Systems    | Wiley          |
| Data Structures      | McGraw Hill    |
| Software Engineering | McGraw Hill    |
| Machine Learning     | McGraw Hill    |
| Data Structures      | McGraw Hill    |
| Software Engineering | McGraw Hill    |
| Machine Learning     | McGraw Hill    |
| Python Programming   | OReilly        |
| Python Programming   | OReilly        |
| Java Basics          | Oracle Press   |
| Java Basics          | Oracle Press   |
| C Programming        | PHI            |
| C Programming        | PHI            |
+----------------------+----------------+
20 rows in set (0.001 sec)
