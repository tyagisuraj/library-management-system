"""🔷 PART 1: Relational Algebra Queries (10)
1. Get names of all students
π(name)(Student)
2. Get students of a specific course (e.g., BTech)
σ(course = 'BTech')(Student)
3. Get books written by a specific author
σ(author = 'XYZ')(Book)
4. Get all issued books with student details
Student ⨝ Issue
5. Get student names and book titles issued
π(name, title)(Student ⨝ Issue ⨝ Book)
6. Get students who have not issued any book
π(student_id)(Student) − π(student_id)(Issue)
7. Get books that are currently issued
π(book_id)(Issue)
8. Get fines with issue details
Issue ⨝ Fine
9. Get students who returned books late (days_late > 0)
π(student_id)(σ(days_late > 0)(Fine ⨝ Issue))
10. Get total fine amount (aggregation)
γ SUM(amount)(Fine)"""
"""🔷 PART 2: SQL Queries (10)"""
1. Get all students
SELECT * FROM Student;
2. Get students of a specific course
SELECT * FROM Student
WHERE course = 'BTech';
3. Get all books by a specific author
SELECT * FROM Book
WHERE author = 'XYZ';
4. Get issued books with student details
SELECT S.name, I.issue_date, I.return_date
FROM Student S
JOIN Issue I ON S.student_id = I.student_id;
5. Get student names and book titles issued
SELECT S.name, B.title
FROM Student S
JOIN Issue I ON S.student_id = I.student_id
JOIN Book B ON I.book_id = B.book_id;
6. Get students who have not issued any book
SELECT student_id, name
FROM Student
WHERE student_id NOT IN (SELECT student_id FROM Issue);
7. Get currently issued books
SELECT DISTINCT book_id
FROM Issue;
8. Get fine details with issue info
SELECT F.amount, F.days_late, I.issue_date
FROM Fine F
JOIN Issue I ON F.issue_id = I.issue_id;
9. Get students who returned books late
SELECT DISTINCT S.name
FROM Student S
JOIN Issue I ON S.student_id = I.student_id
JOIN Fine F ON I.issue_id = F.issue_id
WHERE F.days_late > 0;
10. Get total fine collected
SELECT SUM(amount) AS Total_Fine
FROM Fine;
11. Most issued book
SELECT book_id, COUNT(*) AS issue_count
FROM Issue
GROUP BY book_id
ORDER BY issue_count DESC
LIMIT 1;
12. Students with highest fines
SELECT S.name, SUM(F.amount) AS total_fine
FROM Student S
JOIN Issue I ON S.student_id = I.student_id
JOIN Fine F ON I.issue_id = F.issue_id
GROUP BY S.name
ORDER BY total_fine DESC;
