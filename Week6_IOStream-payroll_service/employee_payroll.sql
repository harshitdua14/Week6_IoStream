mysql> tee C:/Users/DELL/Desktop/IOStream/src/employee_payroll.sql;

/*UC1 -> To create a payroll service database */

mysql> create database payroll_service;
Query OK, 1 row affected (0.02 sec)

mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| payroll_service    |
| performance_schema |
| sys                |
+--------------------+
5 rows in set (0.00 sec)

mysql> use payroll_service;
Database changed

/*UC2 -> to create a employee payroll table
in the payroll service database to
manage employee payrolls*/

mysql> show tables;
+---------------------------+
| Tables_in_payroll_service |
+---------------------------+
| employee_payroll          |
+---------------------------+
1 row in set (0.00 sec)

/*UC3 -> to create employee
payroll data in the payroll
service database as part of
CURD Operation*/

mysql> INSERT INTO employee_payroll(id, name, salary, start_date)
    -> VALUES (1, 'Ashu', 20000.00, '2024-04-11');
Query OK, 1 row affected (0.01 sec)

/*UC4 -> to retrieve all the
employee payroll data that is
added to payroll service
database*/

mysql> select * from employee_payroll;
+----+------+----------+------------+
| id | name | salary   | start_date |
+----+------+----------+------------+
|  1 | Ashu | 20000.00 | 2024-04-11 |
+----+------+----------+------------+
1 row in set (0.01 sec)

mysql> INSERT INTO employee_payroll(id, name, salary, start_date)
    -> VALUES(2,'Ayush',10000.00,'2024-01-24');
Query OK, 1 row affected (0.02 sec)

mysql> select * from employee_payroll;
+----+-------+----------+------------+
| id | name  | salary   | start_date |
+----+-------+----------+------------+
|  1 | Ashu  | 20000.00 | 2024-04-11 |
|  2 | Ayush | 10000.00 | 2024-01-24 |
+----+-------+----------+------------+
2 rows in set (0.00 sec)

/*UC5 -> to retrieve salary data for a particular
employee as well as all employees who have
joined in a particular data range from the
payroll service database*/

mysql> Select salary FROM employee_payroll where name = 'Ashu';
+----------+
| salary   |
+----------+
| 20000.00 |
+----------+
1 row in set (0.01 sec)

mysql> Select salary FROM employee_payroll where start_date BETWEEN CAST('2024-03-8' As Date) AND DATE(now());
+----------+
| salary   |
+----------+
| 20000.00 |
+----------+
1 row in set (0.01 sec)

mysql> Select name,salary FROM employee_payroll where start_date BETWEEN CAST('2024-03-8' As Date) AND DATE(now());
+------+----------+
| name | salary   |
+------+----------+
| Ashu | 20000.00 |
+------+----------+
1 row in set (0.00 sec)

mysql> ALTER table employee_payroll ADD Gender VARCHAR(10) After name;
Query OK, 0 rows affected (0.06 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> select * from employee_payroll;
+----+-------+--------+----------+------------+
| id | name  | Gender | salary   | start_date |
+----+-------+--------+----------+------------+
|  1 | Ashu  | NULL   | 20000.00 | 2024-04-11 |
|  2 | Ayush | NULL   | 10000.00 | 2024-01-24 |
+----+-------+--------+----------+------------+
2 rows in set (0.00 sec)


/*UC6 -> to add Gender to Employee
Payroll Table and Update the Rows to
reflect the correct Employee Gender*/

mysql> update employee_payroll set Gender = 'M' where name = 'Ashu' Or name = 'Ayush';
Query OK, 2 rows affected (0.01 sec)
Rows matched: 2  Changed: 2  Warnings: 0

mysql> select * from employee_payroll;
+----+-------+--------+----------+------------+
| id | name  | Gender | salary   | start_date |
+----+-------+--------+----------+------------+
|  1 | Ashu  | M      | 20000.00 | 2024-04-11 |
|  2 | Ayush | M      | 10000.00 | 2024-01-24 |
+----+-------+--------+----------+------------+
2 rows in set (0.00 sec)

mysql> INSERT INTO employee_payroll(id, name,Gender, salary, start_date)
    -> VALUES(3,'ananya','F',10000.00,'2024-01-24');
Query OK, 1 row affected (0.01 sec)

mysql> select * from employee_payroll;
+----+--------+--------+----------+------------+
| id | name   | Gender | salary   | start_date |
+----+--------+--------+----------+------------+
|  1 | Ashu   | M      | 20000.00 | 2024-04-11 |
|  2 | Ayush  | M      | 10000.00 | 2024-01-24 |
|  3 | ananya | F      | 10000.00 | 2024-01-24 |
+----+--------+--------+----------+------------+
3 rows in set (0.00 sec)

/*UC7 -> to find sum, average, min, max
and number of male and female
employees*/

mysql> SELECT SUM(salary) FROM employee_payroll
    -> WHERE Gender = 'F' GROUP BY gender;
+-------------+
| SUM(salary) |
+-------------+
|    10000.00 |
+-------------+
1 row in set (0.01 sec)

mysql> SELECT MAX(salary) FROM employee_payroll;
+-------------+
| MAX(salary) |
+-------------+
|    20000.00 |
+-------------+
1 row in set (0.00 sec)

mysql> SELECT MIN(salary) FROM employee_payroll;
+-------------+
| MIN(salary) |
+-------------+
|    10000.00 |
+-------------+
1 row in set (0.00 sec)

mysql> SELECT AVG(salary) FROM employee_payroll;
+--------------+
| AVG(salary)  |
+--------------+
| 13333.333333 |
+--------------+
1 row in set (0.01 sec)

mysql> SELECT count(name) FROM employee_payroll;
+-------------+
| count(name) |
+-------------+
|           3 |
+-------------+
1 row in set (0.03 sec)
mysql> Terminal close -- exit!
