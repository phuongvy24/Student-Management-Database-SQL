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

