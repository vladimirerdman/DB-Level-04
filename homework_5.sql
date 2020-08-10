# 1

SELECT
    *
FROM
    employees.employees
        JOIN
    (employees.departments, employees.dept_emp) ON dept_emp.emp_no = employees.emp_no
WHERE
        first_name LIKE '%ar%';

# Result: 321309

# 2

SELECT
    *
FROM
    employees.employees
        JOIN
    (employees.departments, employees.dept_emp) ON dept_emp.emp_no = employees.emp_no
WHERE
        first_name LIKE '%ar%' AND gender = 'F';

# Result: 129150

# 3

SELECT
    *
FROM
    employees.employees
        JOIN
    (employees.departments, employees.dept_emp) ON dept_emp.emp_no = employees.emp_no
WHERE
        first_name LIKE '%ar%' AND gender = 'F' AND dept_emp.dept_no = 'd003';

# Result: 6651

# 4

SELECT
    *
FROM
    employees.employees
        JOIN
    (employees.departments, employees.dept_emp) ON dept_emp.emp_no = employees.emp_no
WHERE
        first_name LIKE 'Mart' AND gender = 'F' AND dept_emp.dept_no = 'd003';

# Result: 45

# To count lines, use:
# COUNT(*) AS firstname_er