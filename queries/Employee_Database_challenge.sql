-- DELIVERABLE 1: The Number of Retiring Employees by Title

-- Retrieve columns from Employees table 
SELECT emp_no,first_name, last_name
FROM employees;

-- Retrieve columns from Titles table 
SELECT title, from_date, to_date
FROM titles;

-- Create table of retiring employees
SELECT DISTINCT ON (e.emp_no) e.emp_no,
       e.first_name,
	   e.last_name,
	   t.title,
	   t.from_date,
	   t.to_date
INTO retirement_titles
FROM employees AS e
INNER JOIN titles AS t
ON e.emp_no = t.emp_no
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
	rt.first_name,
	rt.last_name,
	rt.title
INTO unique_titles
FROM retirement_titles AS rt
ORDER BY rt.emp_no, rt.to_date DESC;

-- Retrieve retiring titles 
SELECT COUNT(ut.emp_no), ut.title
INTO retiring_titles
FROM unique_titles AS ut
GROUP BY ut.title
ORDER BY COUNT (ut.emp_no) DESC;

SELECT * FROM retiring_titles
DROP TABLE retirement_titles

-- DELIVERABLE 2: The Employees Eligible for the Mentorship Program

SELECT emp_no, first_name, last_name, birth_date
FROM employees;

SELECT from_date, to_date
FROM dept_employees;

SELECT title
FROM titles;

SELECT DISTINCT ON (e.emp_no) e.emp_no, 
    e.first_name, 
    e.last_name, 
    e.birth_date,
    de.from_date,
    de.to_date,
    t.title
INTO mentorship_eligibilty
FROM employees AS e
Left OUTER Join dept_employees AS de
ON e.emp_no = de.emp_no
Left OUTER Join titles AS t
ON e.emp_no = t.emp_no
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no;

SELECT * FROM mentorship_eligibilty