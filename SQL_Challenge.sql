--Create tables
Create Table departments (dept_no VARCHAR, dept_name VARCHAR);
Create Table dept_emp (emp_no VARCHAR, dept_no VARCHAR);
Create Table dept_manager (dept_no VARCHAR, emp_no VARCHAR);
Create Table employees (emp_no VARCHAR, emp_title_id VARCHAR, birth_date VARCHAR, first_name VARCHAR, last_name VARCHAR,
						sex VARCHAR, hire_date VARCHAR);
Create Table salaries (emp_no VARCHAR, salary VARCHAR);
Create Table titles (title_id VARCHAR, title VARCHAR);

--1.List the following details of each employee: employee number, last name, first name, sex, and salary.
Select e.emp_no, e.last_name, e.first_name, e.sex, s.salary
From employees e
Join salaries s
On (e.emp_no = s.emp_no);

--Change Data 'date' and 'int' Types to match ERD 
ALTER TABLE employees
ALTER COLUMN hire_date type date using hire_date::date
ALTER COLUMN birth_date type date using birth_date::date
ALTER COLUMN emp_no type integer using emp_no::integer;

ALTER TABLE salaries
ALTER COLUMN emp_no type integer using emp_no::integer;
ALTER COLUMN salary type integer using salary::integer;

ALTER TABLE dept_emp
ALTER COLUMN emp_no type integer using emp_no::integer;


-- 2. List first name, last name, and hire date for employees who were hired in 1986.Select e.emp_no, e.last_name, e.first_name, e.sex, s.salarySelect e.first_name, e.last_name, e.hire_date
Select e.first_name, e.last_name, e.hire_date
From employees e
Where hire_date between '1/1/1986' and '12/31/1986';

-- 3. List the manager of each department with the following information: department number, department name,
-- the manager's employee number, last name, first name.
Select f.dept_no, d.dept_name, f.emp_no, e.last_name, e.first_name
From dept_manager f
Join employees e
On (e.emp_no = f.emp_no)
Join departments d
On (f.dept_no = d.dept_no);

-- 4. List the department of each employee with the following information: employee number, last name, first name, and department name.
Select e.emp_no, e.last_name, e.first_name, f.dept_name
From employees e
Join dept_emp d
On (e.emp_no = d.emp_no)
Join departments f
On (d.dept_no = f.dept_no);

-- 5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
Select e.first_name, e.last_name, e.sex
From employees e
Where first_name = 'Hercules' AND last_name LIKE 'B%';

-- 6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
Select d.emp_no, e.last_name, e.first_name, f.dept_name
From employees e
Join dept_emp d
On (e.emp_no = d.emp_no)
Join departments f
On (d.dept_no = f.dept_no)
Where dept_name = 'Sales';

-- 7. List all employees in the Sales and Development departments, including their employee number, last name,
--first name, and department name.
Select d.emp_no, e.last_name, e.first_name, f.dept_name
From employees e
Join dept_emp d
On (e.emp_no = d.emp_no)
Join departments f
On (d.dept_no = f.dept_no)
Where dept_name = 'Sales' OR dept_name = 'Development';

-- 8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
Select last_name, COUNT(last_name) AS "Count of Distinct Name"
From employees
Group By last_name
Order By "Count of Distinct Name" DESC;
