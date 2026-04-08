# 📘 DBMS Project – Phase 2

## Relational Algebra & SQL Queries

### 📚 Library Management System

---

## 🗂️ Database Schema

### Tables:

* **Student(student_id, name, course, year)**
* **Book(book_id, title, author, publisher, quantity)**
* **Librarian(librarian_id, name, email, phone, shift)**
* **Issue(issue_id, student_id, book_id, librarian_id, issue_date, return_date)**
* **Fine(fine_id, issue_id, amount, days_late)**

---

# 🔷 PART 1: SQL QUERIES

## 1. Display all students


SELECT * FROM Student;


## 2. Display students from BTech course


SELECT * FROM Student
WHERE course = 'BTech';


## 3. Display all books with quantity greater than 3


SELECT * FROM Book
WHERE quantity > 3;


## 4. Display student names with issued book IDs


SELECT S.name, I.book_id
FROM Student S
JOIN Issue I ON S.student_id = I.student_id;


## 5. Display student names with book titles issued


SELECT S.name, B.title
FROM Student S
JOIN Issue I ON S.student_id = I.student_id
JOIN Book B ON I.book_id = B.book_id;


## 6. Display students who have NOT issued any book


SELECT name
FROM Student
WHERE student_id NOT IN (SELECT student_id FROM Issue);


## 7. Display all issued books with issue and return dates


SELECT B.title, I.issue_date, I.return_date
FROM Book B
JOIN Issue I ON B.book_id = I.book_id;


## 8. Display students who paid fine (days_late > 0)


SELECT DISTINCT S.name
FROM Student S
JOIN Issue I ON S.student_id = I.student_id
JOIN Fine F ON I.issue_id = F.issue_id
WHERE F.days_late > 0;


## 9. Display total fine collected


SELECT SUM(amount) AS total_fine
FROM Fine;


## 10. Display number of books issued per student


SELECT S.name, COUNT(I.issue_id) AS total_books
FROM Student S
JOIN Issue I ON S.student_id = I.student_id
GROUP BY S.name;


---

# 🔷 PART 2: RELATIONAL ALGEBRA QUERIES

## 1. Get names of all students

π(name)(Student)

## 2. Get students from BTech course

σ(course = 'BTech')(Student)

## 3. Get books with quantity > 3

σ(quantity > 3)(Book)

## 4. Get student names with issued book IDs

π(name, book_id)(Student ⨝ Issue)

## 5. Get student names with book titles

π(name, title)(Student ⨝ Issue ⨝ Book)

## 6. Get students who have not issued any book

π(student_id)(Student) − π(student_id)(Issue)

## 7. Get issued books with dates

π(title, issue_date, return_date)(Book ⨝ Issue)

## 8. Get students who paid fine

π(name)(σ(days_late > 0)(Student ⨝ Issue ⨝ Fine))

## 9. Get total fine amount

γ SUM(amount)(Fine)

## 10. Count number of issues

γ COUNT(issue_id)(Student ⨝ Issue)

---


## Most issued book

```sql
SELECT B.title, COUNT(I.book_id) AS issue_count
FROM Book B
JOIN Issue I ON B.book_id = I.book_id
GROUP BY B.title
ORDER BY issue_count DESC
LIMIT 1;
```

## Librarian handling most issues

```sql
SELECT L.name, COUNT(I.issue_id) AS total_issues
FROM Librarian L
JOIN Issue I ON L.librarian_id = I.librarian_id
GROUP BY L.name
ORDER BY total_issues DESC;
```

---
 SELECT * FROM Student;
+------------+--------------+--------+------+
| student_id | name         | course | year |
+------------+--------------+--------+------+
|          1 | Rahul Sharma | BTech  |    2 |
|          2 | Aman Verma   | BCA    |    1 |
|          3 | Sneha Gupta  | BTech  |    3 |
|          4 | Priya Singh  | BBA    |    2 |
|          5 | Rohit Kumar  | BTech  |    4 |
|          6 | Anjali Mehta | BCA    |    2 |
|          7 | Karan Patel  | BCom   |    1 |
|          8 | Neha Jain    | BBA    |    3 |
|          9 | Vikas Yadav  | BTech  |    2 |
|         10 | Pooja Kapoor | BCA    |    1 |
+------------+--------------+--------+------+
10 rows in set (0.000 sec)

MariaDB [library_mgmt_system]> SELECT * FROM Student
    -> WHERE course = 'BTech';
+------------+--------------+--------+------+
| student_id | name         | course | year |
+------------+--------------+--------+------+
|          1 | Rahul Sharma | BTech  |    2 |
|          3 | Sneha Gupta  | BTech  |    3 |
|          5 | Rohit Kumar  | BTech  |    4 |
|          9 | Vikas Yadav  | BTech  |    2 |
+------------+--------------+--------+------+
4 rows in set (0.001 sec)

MariaDB [library_mgmt_system]> SELECT * FROM Book
    -> WHERE quantity > 3;
+---------+----------------------+-----------------+--------------+----------+
| book_id | title                | author          | publisher    | quantity |
+---------+----------------------+-----------------+--------------+----------+
|       1 | DBMS Concepts        | Korth           | Pearson      |        5 |
|       2 | Operating Systems    | Galvin          | Wiley        |        4 |
|       3 | Data Structures      | Sahni           | McGraw Hill  |        6 |
|       5 | Software Engineering | Pressman        | McGraw Hill  |        5 |
|       6 | Python Programming   | Guido           | OReilly      |        7 |
|       7 | Java Basics          | Herbert Schildt | Oracle Press |        6 |
|       8 | C Programming        | Dennis Ritchie  | PHI          |        4 |
|      11 | DBMS Concepts        | Korth           | Pearson      |        5 |
|      12 | Operating Systems    | Galvin          | Wiley        |        4 |
|      13 | Data Structures      | Sahni           | McGraw Hill  |        6 |
|      15 | Software Engineering | Pressman        | McGraw Hill  |        5 |
|      16 | Python Programming   | Guido           | OReilly      |        7 |
|      17 | Java Basics          | Herbert Schildt | Oracle Press |        6 |
|      18 | C Programming        | Dennis Ritchie  | PHI          |        4 |
+---------+----------------------+-----------------+--------------+----------+
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
10 rows in set (0.001 sec)

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
Empty set (0.001 sec)

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
10 rows in set (0.001 sec)

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
1 row in set (0.001 sec)

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

MariaDB [library_mgmt_system]> SELECT L.name, COUNT(I.issue_id) AS total_issues
    -> FROM Librarian L
    -> JOIN Issue I ON L.librarian_id = I.librarian_id
    -> GROUP BY L.name
    -> ORDER BY total_issues DESC;
+------------+--------------+
| name       | total_issues |
+------------+--------------+
| Ms. Singh  |            1 |
| Mr. Sharma |            1 |
| Mr. Yadav  |            1 |
| Ms. Mehta  |            1 |
| Mr. Verma  |            1 |
| Ms. Kapoor |            1 |
| Mr. Patel  |            1 |
| Ms. Gupta  |            1 |
| Ms. Khan   |            1 |
| Mr. Jain   |            1 |
+------------+--------------+
10 rows in set (0.000 sec)

MariaDB [library_mgmt_system]> SELECT B.title, COUNT(I.book_id) AS issue_count
    -> FROM Book B
    -> JOIN Issue I ON B.book_id = I.book_id
    -> GROUP BY B.title
    -> ORDER BY issue_count DESC
    -> LIMIT 1;
+---------------+-------------+
| title         | issue_count |
+---------------+-------------+
| C Programming |           1 |
+---------------+-------------+
1 row in set (0.001 sec)
