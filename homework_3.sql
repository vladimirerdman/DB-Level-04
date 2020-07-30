# Homework 3:

# Task 1. База данных «Страны и города мира»
#
# Part 1. Сделать запрос, в котором мы выберем все данные о городе – регион, страна.

SELECT
    _countries.title AS 'country',
    _regions.title AS 'region',
    _cities.title AS 'city'
FROM
    _countries,
    _regions,
    _cities
WHERE
      _regions.country_id = _countries.id
  AND
      _cities.region_id = _regions.id
ORDER BY country ASC;

# OR

SELECT
    _countries.title AS 'country',
    _regions.title AS 'region',
    _cities.title AS 'city'
FROM _cities
    JOIN _countries ON _cities.country_id = _countries.id
    JOIN _regions ON _cities.region_id
ORDER BY country ASC;

# Part 2. Выбрать все города из Московской области.

SELECT
       _cities.title AS 'moscow_region'
FROM _cities
    JOIN _regions ON region_id = _regions.id
WHERE _regions.id = 1053480
ORDER BY moscow_region;

# OR

SELECT
       _cities.title AS 'moscow_region'
FROM _cities
    JOIN _regions ON region_id = _regions.id
WHERE _regions.title = 'Московская область'
ORDER BY moscow_region;

# !!! Or we can do it without INNER JOIN as in the Part 1 of this task.

# Task 2. База данных «Сотрудники»
#
# Part 1. Выбрать среднюю зарплату по отделам.

SELECT
       departments.dept_name, AVG(salary) AS avg_salary
FROM salaries
    JOIN dept_emp ON salaries.emp_no = dept_emp.emp_no
    JOIN departments ON dept_emp.dept_no = departments.dept_no
GROUP BY dept_name
ORDER BY avg_salary DESC;

# Part 2. Выбрать максимальную зарплату у сотрудника.

SELECT
       ANY_VALUE(first_name) AS first_name,
       ANY_VALUE(last_name) AS last_name,
       max(salaries.salary) AS max_salary
FROM employees
    JOIN salaries ON employees.emp_no = salaries.emp_no
ORDER BY max_salary;

# ANY_VALUE() helps you to resolve an error:
# Expression #1 of SELECT list is not in GROUP BY clause and contains nonaggregated column which is not functionally dependent on columns in GROUP BY clause; this is incompatible with sql_mode=only_full_group_by

# Part 3. Удалить одного сотрудника, у которого максимальная зарплата.

DELETE FROM employees
WHERE (emp_no =
    (
        SELECT salaries.emp_no
        FROM salaries
        ORDER BY salary
        DESC
        LIMIT 1
    )
);

# Part 4. Посчитать количество сотрудников во всех отделах.

SELECT
       departments.dept_name AS department,
       COUNT(employees.emp_no) AS total_emp
FROM employees
    JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
    JOIN departments ON dept_emp.dept_no = departments.dept_no
GROUP BY dept_name
ORDER BY total_emp DESC;

# Part 5. Найти количество сотрудников в отделах и посмотреть, сколько всего денег получает отдел.

SELECT
    departments.dept_name AS department,
    SUM(salaries.salary) AS sum
FROM employees
    JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
    JOIN departments ON dept_emp.dept_no = departments.dept_no
    JOIN salaries ON employees.emp_no = salaries.emp_no
GROUP BY department
ORDER BY sum DESC;


# !!! Just for information (JFI): JOIN == INNER JOIN