# Homework 4

#
# Task 1. Создать VIEW на основе запросов, которые вы сделали в ДЗ к уроку 3.
#

USE `employees`;
CREATE
    OR REPLACE ALGORITHM = UNDEFINED
    DEFINER = `root`@`localhost`
    SQL SECURITY DEFINER
    VIEW `employees_in_departments` AS
SELECT
    `departments`.`dept_name` AS `department`,
    COUNT(`employees`.`emp_no`) AS `total_emp`
FROM
    ((`employees`
        JOIN `dept_emp` ON ((`employees`.`emp_no` = `dept_emp`.`emp_no`)))
        JOIN `departments` ON ((`dept_emp`.`dept_no` = `departments`.`dept_no`)))
GROUP BY `departments`.`dept_name`
ORDER BY `total_emp` DESC;

# Using VIEW in SELECT

SELECT * FROM employees.employees_in_departments;


#
# Task 2. Создать функцию, которая найдет менеджера по имени и фамилии.
#

USE `employees`;
DROP function IF EXISTS `find_employee`;

DELIMITER $$
USE `employees`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `find_employee`( emp_firstname varchar(30), emp_lastname varchar(30) ) RETURNS varchar(100) CHARSET utf8mb4
    READS SQL DATA
BEGIN
    DECLARE emp_id int(10);
    SET emp_id = (
        SELECT
            emp_no
        FROM
            employees
        WHERE
                first_name = emp_firstname
          AND
                last_name = emp_lastname
        LIMIT 1
    );
    RETURN (
        SELECT
            emp_no
        FROM
            employees
        WHERE
                first_name = emp_firstname
          AND
                last_name = emp_lastname
    );
END$$

DELIMITER ;

# Lets find ID of someone by using created FUNCTION in SELECT

SELECT find_employee('Mayuko', 'Warwick');

# Result

10020


#
# Task 3. Создать триггер, который при добавлении нового сотрудника будет выплачивать ему вступительный бонус,
# занося запись об этом в таблицу salary.
#

DROP TRIGGER IF EXISTS `employees`.`employees_AFTER_INSERT`;

DELIMITER $$
USE `employees`$$
CREATE DEFINER = CURRENT_USER TRIGGER `employees`.`employees_AFTER_INSERT` AFTER INSERT ON `employees` FOR EACH ROW
BEGIN
    INSERT INTO `salaries` (`emp_no`, `salary`, `from_date`, `to_date`) VALUES (NEW.emp_no, '555559', '2020-07-01', '2020-12-31');
END$$
DELIMITER ;

# Lets INSERT new employee

INSERT INTO `employees` (`emp_no`, `birth_date`, `first_name`, `last_name`, `gender`, `hire_date`) VALUES (900055, '1953-01-13', 'Kristine', 'Velardi', 'M', '1990-08-27');

# Looking for result

SELECT
    *
FROM
    employees.salaries
WHERE
        salary = 555559;

# Result

emp_no | salary | from_date  | to_date    |
900055 | 555559 | 2020-07-01 | 2020-12-31 |