/*UC8 -> Ability to extend
employee_payroll data to
store employee information
like employee phone, address
and department - Ensure employee department is non
nullable fields.
- Add Default Value for address field.*/

mysql> show databases
    -> ;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| payroll_service    |
| performance_schema |
| sys                |
+--------------------+
5 rows in set (0.10 sec)

mysql> use payroll_service;
Database changed
mysql> Alter table employee_payroll ADD COLUMN phone VARCHAR(15),
    -> ADD COLUMN address VARCHAR(255) Default '135,xyz street',
    -> Add Column department VARCHAR(100) NOT NULL;
Query OK, 0 rows affected (0.07 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> select * from employee_payroll;
+----+--------+--------+----------+------------+-------+----------------+------------+
| id | name   | Gender | salary   | start_date | phone | address        | department |
+----+--------+--------+----------+------------+-------+----------------+------------+
|  1 | Ashu   | M      | 20000.00 | 2024-04-11 | NULL  | 135,xyz street |            |
|  2 | Ayush  | M      | 10000.00 | 2024-01-24 | NULL  | 135,xyz street |            |
|  3 | ananya | F      | 10000.00 | 2024-01-24 | NULL  | 135,xyz street |            |
+----+--------+--------+----------+------------+-------+----------------+------------+
3 rows in set (0.01 sec)

/*UC9 -> Ability to extend
employee_payroll table
to have Basic Pay,
Deductions, Taxable Pay,
Income Tax, Net Pay*/

mysql> ALTER TABLE employee_payroll
    -> ADD COLUMN basic_pay DECIMAL(10, 2),
    -> ADD COLUMN deductions DECIMAL(10, 2),
    -> ADD COLUMN taxable_pay DECIMAL(10, 2),
    -> ADD COLUMN income_tax DECIMAL(10, 2),
    -> ADD COLUMN net_pay DECIMAL(10, 2);
Query OK, 0 rows affected (0.01 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> select * from employee_payroll;
+----+--------+--------+----------+------------+-------+----------------+------------+-----------+------------+-------------+------------+---------+
| id | name   | Gender | salary   | start_date | phone | address        | department | basic_pay | deductions | taxable_pay | income_tax | net_pay |
+----+--------+--------+----------+------------+-------+----------------+------------+-----------+------------+-------------+------------+---------+
|  1 | Ashu   | M      | 20000.00 | 2024-04-11 | NULL  | 135,xyz street |            |      NULL |       NULL |        NULL |       NULL |    NULL |
|  2 | Ayush  | M      | 10000.00 | 2024-01-24 | NULL  | 135,xyz street |            |      NULL |       NULL |        NULL |       NULL |    NULL |
|  3 | ananya | F      | 10000.00 | 2024-01-24 | NULL  | 135,xyz street |            |      NULL |       NULL |        NULL |       NULL |    NULL |
+----+--------+--------+----------+------------+-------+----------------+------------+-----------+------------+-------------+------------+---------+
3 rows in set (0.00 sec)
/*UC10 ->Ability to make Terissa as part of
Sales and Marketing Department
- Note: The Complete employee payroll
roll need to be Inserted
- If a Salary is now going to be updated
multiple rows has to be updated
creating unnecessary redundancy
- Further There is 2 Employee ID so
according to Database there is two
different Terissa*/
mysql> INSERT INTO employee_payroll (
    ->     id, name, Gender, salary, start_date, phone, address, department,
    ->     basic_pay, deductions, taxable_pay, income_tax, net_pay
    -> )
    -> VALUES 
    -> -- Terissa #1
    -> (4, 'Terissa', 'F', 50000.00, '2024-04-10', '9876543210', '21 Rosewood Lane', 'Sales and Marketing',
    ->  40000.00, 5000.00, 35000.00, 7000.00, 28000.00),
    -> 
    -> -- Terissa #2
    -> (5, 'Terissa', 'F', 55000.00, '2024-04-10', '9876543211', '22 Maple Avenue', 'Sales and Marketing',
    ->  45000.00, 6000.00, 39000.00, 8000.00, 31000.00);
Query OK, 2 rows affected (0.02 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql> select * from employee_payroll;
+----+---------+--------+----------+------------+------------+------------------+---------------------+-----------+------------+-------------+------------+----------+
| id | name    | Gender | salary   | start_date | phone      | address          | department          | basic_pay | deductions | taxable_pay | income_tax | net_pay  |
+----+---------+--------+----------+------------+------------+------------------+---------------------+-----------+------------+-------------+------------+----------+
|  1 | Ashu    | M      | 20000.00 | 2024-04-11 | NULL       | 135,xyz street   |                     |      NULL |       NULL |        NULL |       NULL |     NULL |
|  2 | Ayush   | M      | 10000.00 | 2024-01-24 | NULL       | 135,xyz street   |                     |      NULL |       NULL |        NULL |       NULL |     NULL |
|  3 | ananya  | F      | 10000.00 | 2024-01-24 | NULL       | 135,xyz street   |                     |      NULL |       NULL |        NULL |       NULL |     NULL |
|  4 | Terissa | F      | 50000.00 | 2024-04-10 | 9876543210 | 21 Rosewood Lane | Sales and Marketing |  40000.00 |    5000.00 |    35000.00 |    7000.00 | 28000.00 |
|  5 | Terissa | F      | 55000.00 | 2024-04-10 | 9876543211 | 22 Maple Avenue  | Sales and Marketing |  45000.00 |    6000.00 |    39000.00 |    8000.00 | 31000.00 |
+----+---------+--------+----------+------------+------------+------------------+---------------------+-----------+------------+-------------+------------+----------+
5 rows in set (0.00 sec)

/*UC11 ->Implement the ER Diagram
into Payroll Service DB
- Create the corresponding tables as
identified in the ER Diagram along
with attributes
- For Many to Many relationship,
create new Table called Employee
Department having Employee Id and
Department ID and redo the UC 7*/

mysql> CREATE TABLE employee (
    ->     employee_id INT PRIMARY KEY,
    ->     name VARCHAR(100),
    ->     gender CHAR(1),
    ->     start_date DATE,
    ->     phone VARCHAR(15),
    ->     address VARCHAR(255) DEFAULT 'Not Provided'
    -> );
Query OK, 0 rows affected (0.04 sec)

mysql> CREATE TABLE department (
    ->     department_id INT PRIMARY KEY AUTO_INCREMENT,
    ->     name VARCHAR(100) NOT NULL UNIQUE
    -> );
Query OK, 0 rows affected (0.03 sec)

mysql> CREATE TABLE employee_department (
    ->     employee_id INT,
    ->     department_id INT,
    ->     PRIMARY KEY (employee_id, department_id),
    ->     FOREIGN KEY (employee_id) REFERENCES employee(employee_id),
    ->     FOREIGN KEY (department_id) REFERENCES department(department_id)
    -> );
Query OK, 0 rows affected (0.05 sec)

mysql> CREATE TABLE payroll (
    ->     payroll_id INT PRIMARY KEY AUTO_INCREMENT,
    ->     employee_id INT,
    ->     basic_pay DECIMAL(10,2),
    ->     deductions DECIMAL(10,2),
    ->     taxable_pay DECIMAL(10,2),
    ->     income_tax DECIMAL(10,2),
    ->     net_pay DECIMAL(10,2),
    ->     FOREIGN KEY (employee_id) REFERENCES employee(employee_id)
    -> );
Query OK, 0 rows affected (0.04 sec)

mysql> INSERT INTO employee (employee_id, name, gender, start_date, phone, address)
    -> VALUES (4, 'Terissa', 'F', '2024-04-10', '9876543210', '21 Rosewood Lane');
Query OK, 1 row affected (0.01 sec)


mysql> INSERT INTO department (name)
    -> VALUES ('Sales and Marketing');
Query OK, 1 row affected (0.01 sec)

mysql> INSERT INTO employee_department (employee_id, department_id)
    -> VALUES (4, 1);
Query OK, 1 row affected (0.01 sec)


mysql> select * from employee_payroll;
+----+---------+--------+----------+------------+------------+------------------+---------------------+-----------+------------+-------------+------------+----------+
| id | name    | Gender | salary   | start_date | phone      | address          | department          | basic_pay | deductions | taxable_pay | income_tax | net_pay  |
+----+---------+--------+----------+------------+------------+------------------+---------------------+-----------+------------+-------------+------------+----------+
|  1 | Ashu    | M      | 20000.00 | 2024-04-11 | NULL       | 135,xyz street   |                     |      NULL |       NULL |        NULL |       NULL |     NULL |
|  2 | Ayush   | M      | 10000.00 | 2024-01-24 | NULL       | 135,xyz street   |                     |      NULL |       NULL |        NULL |       NULL |     NULL |
|  3 | ananya  | F      | 10000.00 | 2024-01-24 | NULL       | 135,xyz street   |                     |      NULL |       NULL |        NULL |       NULL |     NULL |
|  4 | Terissa | F      | 50000.00 | 2024-04-10 | 9876543210 | 21 Rosewood Lane | Sales and Marketing |  40000.00 |    5000.00 |    35000.00 |    7000.00 | 28000.00 |
|  5 | Terissa | F      | 55000.00 | 2024-04-10 | 9876543211 | 22 Maple Avenue  | Sales and Marketing |  45000.00 |    6000.00 |    39000.00 |    8000.00 | 31000.00 |
+----+---------+--------+----------+------------+------------+------------------+---------------------+-----------+------------+-------------+------------+----------+
5 rows in set (0.03 sec)

mysql> select * from employee_department;
+-------------+---------------+
| employee_id | department_id |
+-------------+---------------+
|           4 |             1 |
+-------------+---------------+
1 row in set (0.01 sec)

mysql> select * from employee;
+-------------+---------+--------+------------+------------+------------------+
| employee_id | name    | gender | start_date | phone      | address          |
+-------------+---------+--------+------------+------------+------------------+
|           4 | Terissa | F      | 2024-04-10 | 9876543210 | 21 Rosewood Lane |
+-------------+---------+--------+------------+------------+------------------+
1 row in set (0.00 sec)

mysql> select* from department
    -> ;
+---------------+---------------------+
| department_id | name                |
+---------------+---------------------+
|             1 | Sales and Marketing |
+---------------+---------------------+
1 row in set (0.01 sec)

mysql> show tables;
+---------------------------+
| Tables_in_payroll_service |
+---------------------------+
| department                |
| employee                  |
| employee_department       |
| employee_payroll          |
| payroll                   |
+---------------------------+
5 rows in set (0.05 sec)

mysql> select * from employee_department;
+-------------+---------------+
| employee_id | department_id |
+-------------+---------------+
|           4 |             1 |
+-------------+---------------+
1 row in set (0.00 sec)

mysql> select * from payroll;
Empty set (0.02 sec)

mysql> select * from employee;
+-------------+---------+--------+------------+------------+------------------+
| employee_id | name    | gender | start_date | phone      | address          |
+-------------+---------+--------+------------+------------+------------------+
|           4 | Terissa | F      | 2024-04-10 | 9876543210 | 21 Rosewood Lane |
+-------------+---------+--------+------------+------------+------------------+
1 row in set (0.00 sec)

mysql> select * from employee_payroll;
+----+---------+--------+----------+------------+------------+------------------+---------------------+-----------+------------+-------------+------------+----------+
| id | name    | Gender | salary   | start_date | phone      | address          | department          | basic_pay | deductions | taxable_pay | income_tax | net_pay  |
+----+---------+--------+----------+------------+------------+------------------+---------------------+-----------+------------+-------------+------------+----------+
|  1 | Ashu    | M      | 20000.00 | 2024-04-11 | NULL       | 135,xyz street   |                     |      NULL |       NULL |        NULL |       NULL |     NULL |
|  2 | Ayush   | M      | 10000.00 | 2024-01-24 | NULL       | 135,xyz street   |                     |      NULL |       NULL |        NULL |       NULL |     NULL |
|  3 | ananya  | F      | 10000.00 | 2024-01-24 | NULL       | 135,xyz street   |                     |      NULL |       NULL |        NULL |       NULL |     NULL |
|  4 | Terissa | F      | 50000.00 | 2024-04-10 | 9876543210 | 21 Rosewood Lane | Sales and Marketing |  40000.00 |    5000.00 |    35000.00 |    7000.00 | 28000.00 |
|  5 | Terissa | F      | 55000.00 | 2024-04-10 | 9876543211 | 22 Maple Avenue  | Sales and Marketing |  45000.00 |    6000.00 |    39000.00 |    8000.00 | 31000.00 |
+----+---------+--------+----------+------------+------------+------------------+---------------------+-----------+------------+-------------+------------+----------+
5 rows in set (0.00 sec)

mysql> SELECT * FROM department WHERE name = 'Sales and Marketing';
+---------------+---------------------+
| department_id | name                |
+---------------+---------------------+
|             1 | Sales and Marketing |
+---------------+---------------------+
1 row in set (0.01 sec)

mysql> INSERT INTO payroll (employee_id, basic_pay, deductions, taxable_pay, income_tax, net_pay)
    -> VALUES (4, 50000.00, 5000.00, 45000.00, 9000.00, 36000.00);
Query OK, 1 row affected (0.01 sec)

/*UC12 -> Ensure all retrieve

queries done especially

in UC 4, UC 5 and UC 7

are working with new
table structure*/

mysql> select * from payroll;
+------------+-------------+-----------+------------+-------------+------------+----------+
| payroll_id | employee_id | basic_pay | deductions | taxable_pay | income_tax | net_pay  |
+------------+-------------+-----------+------------+-------------+------------+----------+
|          1 |           4 |  50000.00 |    5000.00 |    45000.00 |    9000.00 | 36000.00 |
+------------+-------------+-----------+------------+-------------+------------+----------+
1 row in set (0.00 sec)

mysql> SELECT 
    ->     e.employee_id,
    ->     e.name,
    ->     e.gender,
    ->     e.start_date,
    ->     e.phone,
    ->     e.address,
    ->     d.name AS department,
    ->     p.basic_pay,
    ->     p.deductions,
    ->     p.taxable_pay,
    ->     p.income_tax,
    ->     p.net_pay
    -> FROM employee e
    -> LEFT JOIN employee_department ed ON e.employee_id = ed.employee_id
    -> LEFT JOIN department d ON ed.department_id = d.department_id
    -> LEFT JOIN payroll p ON e.employee_id = p.employee_id;
+-------------+---------+--------+------------+------------+------------------+---------------------+-----------+------------+-------------+------------+----------+
| employee_id | name    | gender | start_date | phone      | address          | department          | basic_pay | deductions | taxable_pay | income_tax | net_pay  |
+-------------+---------+--------+------------+------------+------------------+---------------------+-----------+------------+-------------+------------+----------+
|           4 | Terissa | F      | 2024-04-10 | 9876543210 | 21 Rosewood Lane | Sales and Marketing |  50000.00 |    5000.00 |    45000.00 |    9000.00 | 36000.00 |
+-------------+---------+--------+------------+------------+------------------+---------------------+-----------+------------+-------------+------------+----------+
1 row in set (0.00 sec)

mysql> SELECT 
    ->     e.employee_id,
    ->     e.name,
    ->     e.start_date
    -> FROM employee e
    -> WHERE e.start_date > '2024-01-01';
+-------------+---------+------------+
| employee_id | name    | start_date |
+-------------+---------+------------+
|           4 | Terissa | 2024-04-10 |
+-------------+---------+------------+
1 row in set (0.01 sec)

mysql> SELECT 
    ->     e.employee_id,
    ->     e.name,
    ->     d.name AS department
    -> FROM employee e
    -> JOIN employee_department ed ON e.employee_id = ed.employee_id
    -> JOIN department d ON ed.department_id = d.department_id
    -> WHERE e.name = 'Terissa';
+-------------+---------+---------------------+
| employee_id | name    | department          |
+-------------+---------+---------------------+
|           4 | Terissa | Sales and Marketing |
+-------------+---------+---------------------+
1 row in set (0.00 sec)

mysql> Terminal close
