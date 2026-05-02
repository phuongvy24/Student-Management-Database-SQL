# University Student Management Database

Relational database design project for a university student management system using Microsoft SQL Server.

## Features
- Student & lecturer management
- Course registration system
- Grade management
- Academic reporting queries
- ERD and relational schema design

## Concepts
- Database normalization
- PK/FK constraints
- JOIN queries
- Aggregate functions
- Nested queries

## Entity Relationship Diagram
<img width="896" height="794" alt="Database_Diagram" src="https://github.com/user-attachments/assets/bc69cbef-811f-4de8-8cc0-a7cab772d851" />

## Key SQL Queries

The following SQL queries were developed to support academic reporting, student management, course registration analysis, lecturer statistics, and GPA calculation within the university student management system.

### 1. Statistics of Students by Major
**Purpose:** Count the number of students in each major.  
**Displayed Information:** Major ID, Major Name, Number of Students.

#### SQL Query
```sql
SELECT n.MaN, n.TenN, COUNT(s.MaSV) AS SoLuongSV
FROM NganhHoc n
JOIN ChuyenNganh c ON n.MaN = c.MaN
JOIN SinhVien s ON s.MaCN = c.MaCN
GROUP BY n.MaN, n.TenN;
```

---

### 2. Students Who Did Not Register Courses in Semester 2 (2023-2024)
**Purpose:** Identify students who did not register for any courses in Semester 2 of the academic year 2023–2024.  
**Displayed Information:** Student ID, Student Name.

#### SQL Query
```sql
SELECT MaSV, Ho, Ten
FROM SinhVien sv
WHERE sv.MaSV NOT IN (
    SELECT dk.MaSV
    FROM DKHP dk
    JOIN LopHocPhan lhp ON lhp.MaHP = dk.MaHP
    WHERE NamHoc = '2023-2024'
      AND TenHocKy = 'HK2'
);
```

---

### 3. Lecturer Teaching Statistics
**Purpose:** Count the number of courses taught by each lecturer.  
**Displayed Information:** Lecturer ID, Lecturer Name, Number of Courses.

#### SQL Query
```sql
SELECT gv.MaGV, Ho, Ten, COUNT(*) AS SLMonHoc
FROM GiangDay gd
JOIN GiangVien gv ON gv.MaGV = gd.MaGV
GROUP BY gv.MaGV, Ho, Ten;
```

---
