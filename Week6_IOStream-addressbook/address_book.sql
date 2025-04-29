/*UC1 -> Ability to create a
Address Book Service
DB*/

mysql> create database address_book_service;
Query OK, 1 row affected (0.05 sec)

mysql> show databases;
+----------------------+
| Database             |
+----------------------+
| address_book_service |
| information_schema   |
| mysql                |
| payroll_service      |
| performance_schema   |
| sys                  |
+----------------------+
6 rows in set (0.02 sec)
c c 
mysql> use address_book_service;
Database changed

/*UC2 -> Ability to create a Address
Book Table with first and
last names, address, city,
state, zip, phone number
and email as its attributes*/

mysql> create table address_book(
    -> ID INT PRIMARY KEY AUTO_INCREMENT,
    -> FirstName VARCHAR(50),
    -> LastName VARCHAR(50),
    -> Address VARCHAR(100),
    -> City VARCHAR(50),
    -> State CHAR(2),
    -> ZipCode VARCHAR(10),
    -> PhoneNumber VARCHAR(20),
    -> Email VARCHAR(100)
    -> );
Query OK, 0 rows affected (0.08 sec)

mysql> show tables;
+--------------------------------+
| Tables_in_address_book_service |
+--------------------------------+
| address_book                   |
+--------------------------------+
1 row in set (0.02 sec)

/*UC3 -> Ability to insert new
Contacts to Address
Book*/

mysql> INSERT INTO address_book(FirstName,LastName,Address,City,State,ZipCode,PhoneNumber,Email)
    -> VALUES('Ashu','Singh','735 sanoli road','Panipat','HR','132103','8708684910','abc.singh@gmail.com');
Query OK, 1 row affected (0.03 sec)

mysql> select * from address_book;
+----+-----------+----------+-----------------+---------+-------+---------+-------------+---------------------+
| ID | FirstName | LastName | Address         | City    | State | ZipCode | PhoneNumber | Email               |
+----+-----------+----------+-----------------+---------+-------+---------+-------------+---------------------+
|  1 | Ashu      | Singh    | 735 sanoli road | Panipat | HR    | 132103  | 8708684910  | abc.singh@gmail.com |
+----+-----------+----------+-----------------+---------+-------+---------+-------------+---------------------+
1 row in set (0.00 sec)

/*UC4 -> Ability to edit
existing contact
person using their
name*/

mysql> UPDATE address_book
    -> Set Address = 'Paraspur',
    -> City = 'Gonda',
    -> State = 'UP',
    -> ZipCode ='271001',
    -> PhoneNumber = '1234567890',
    -> Email = 'abc.t@gmail.com'
    -> WHERE FirstName = 'Ashu' AND LastName = 'Singh';
Query OK, 1 row affected (0.02 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> select * from address_book;
+----+-----------+----------+----------+-------+-------+---------+-------------+-----------------+
| ID | FirstName | LastName | Address  | City  | State | ZipCode | PhoneNumber | Email           |
+----+-----------+----------+----------+-------+-------+---------+-------------+-----------------+
|  1 | Ashu      | Singh    | Paraspur | Gonda | UP    | 271001  | 1234567890  | abc.t@gmail.com |
+----+-----------+----------+----------+-------+-------+---------+-------------+-----------------+
1 row in set (0.00 sec)

/*UC5 -> Ability to delete a
person using person's
name*/


mysql> select * from address_book;
+----+-----------+----------+-----------------+---------+-------+---------+-------------+---------------------+
| ID | FirstName | LastName | Address         | City    | State | ZipCode | PhoneNumber | Email               |
+----+-----------+----------+-----------------+---------+-------+---------+-------------+---------------------+
|  1 | Ashu      | Singh    | Paraspur        | Gonda   | UP    | 271001  | 1234567890  | abc.t@gmail.com     |
|  2 | Neha      | Singh    | 735 sanoli road | Panipat | HR    | 132103  | 8708684910  | abc.singh@gmail.com |
+----+-----------+----------+-----------------+---------+-------+---------+-------------+---------------------+
2 rows in set (0.00 sec)

mysql> delete from address_book where FirstName='Neha' AND LastName = 'Singh';
Query OK, 1 row affected (0.01 sec)

mysql> select * from address_book;
+----+-----------+----------+----------+-------+-------+---------+-------------+-----------------+
| ID | FirstName | LastName | Address  | City  | State | ZipCode | PhoneNumber | Email           |
+----+-----------+----------+----------+-------+-------+---------+-------------+-----------------+
|  1 | Ashu      | Singh    | Paraspur | Gonda | UP    | 271001  | 1234567890  | abc.t@gmail.com |
+----+-----------+----------+----------+-------+-------+---------+-------------+-----------------+
1 row in set (0.00 sec)

/*UC6 -> Ability to Retrieve
Person belonging to
a City or State from
the Address Book*/

mysql> select * from address_book where City = 'Gonda';
+----+-----------+----------+----------+-------+-------+---------+-------------+-----------------+
| ID | FirstName | LastName | Address  | City  | State | ZipCode | PhoneNumber | Email           |
+----+-----------+----------+----------+-------+-------+---------+-------------+-----------------+
|  1 | Ashu      | Singh    | Paraspur | Gonda | UP    | 271001  | 1234567890  | abc.t@gmail.com |
+----+-----------+----------+----------+-------+-------+---------+-------------+-----------------+
1 row in set (0.00 sec)

/*UC7 -> Ability to understand
the size of address
book by City and State*/
mysql> SELECT City, COUNT(*) AS TotalContacts
    -> FROM address_book
    -> GROUP BY City;
+-------------+---------------+
| City        | TotalContacts |
+-------------+---------------+
| Gonda       |             1 |
| Chicago     |             2 |
| Springfield |             1 |
| Madison     |             1 |
+-------------+---------------+
4 rows in set (0.01 sec)

mysql> SELECT State, COUNT(*) AS TotalContacts
    -> from address_book
    -> group by State;
+-------+---------------+
| State | TotalContacts |
+-------+---------------+
| UP    |             1 |
| IL    |             3 |
| WI    |             1 |
+-------+---------------+
3 rows in set (0.01 sec)

/*UC8 -> Ability to retrieve entries
sorted alphabetically by
Person’s name for a
given city*/

mysql> SELECT *
    -> FROM address_book
    -> WHERE City = 'Chicago'
    -> ORDER BY FirstName ASC, LastName ASC;
+----+-----------+----------+-------------+---------+-------+---------+--------------+------------------------+
| ID | FirstName | LastName | Address     | City    | State | ZipCode | PhoneNumber  | Email                  |
+----+-----------+----------+-------------+---------+-------+---------+--------------+------------------------+
|  4 | Jane      | Smith    | 456 Oak Ave | Chicago | IL    | 60601   | 555-333-4444 | jane.smith@example.com |
|  3 | John      | Doe      | 123 Elm St  | Chicago | IL    | 60601   | 555-111-2222 | john.doe@example.com   |
+----+-----------+----------+-------------+---------+-------+---------+--------------+------------------------+
2 rows in set (0.01 sec)

/*UC9 -> Ability to identify each
Address Book with name and
Type. - Here the type could Family, Friends,
Profession, etc
- Alter Address Book to add name and
type*/

mysql> ALTER TABLE address_book
    -> ADD COLUMN BookName VARCHAR(100) AFTER Email,
    -> ADD COLUMN BookType ENUM('Family', 'Friends', 'Profession', 'Other') AFTER BookName;
Query OK, 0 rows affected (0.03 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> DROP TABLE AddressBooks;
Query OK, 0 rows affected (0.03 sec)

mysql> select * from address_book;
+----+-----------+----------+--------------+-------------+-------+---------+--------------+-------------------------+----------+----------+
| ID | FirstName | LastName | Address      | City        | State | ZipCode | PhoneNumber  | Email                   | BookName | BookType |
+----+-----------+----------+--------------+-------------+-------+---------+--------------+-------------------------+----------+----------+
|  1 | Ashu      | Singh    | Paraspur     | Gonda       | UP    | 271001  | 1234567890   | abc.t@gmail.com         | NULL     | NULL     |
|  3 | John      | Doe      | 123 Elm St   | Chicago     | IL    | 60601   | 555-111-2222 | john.doe@example.com    | NULL     | NULL     |
|  4 | Jane      | Smith    | 456 Oak Ave  | Chicago     | IL    | 60601   | 555-333-4444 | jane.smith@example.com  | NULL     | NULL     |
|  5 | Alice     | Brown    | 789 Pine St  | Springfield | IL    | 62704   | 555-555-6666 | alice.brown@example.com | NULL     | NULL     |
|  6 | Bob       | Taylor   | 101 Maple Rd | Madison     | WI    | 53703   | 555-777-8888 | bob.taylor@example.com  | NULL     | NULL     |
+----+-----------+----------+--------------+-------------+-------+---------+--------------+-------------------------+----------+----------+
5 rows in set (0.00 sec)

mysql> UPDATE address_book
    -> SET BookName = 'Singh Family', BookType = 'Family'
    -> WHERE FirstName = 'Ashu' AND LastName = 'Singh';
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql>
mysql> UPDATE address_book
    -> SET BookName = 'College Friends', BookType = 'Friends'
    -> WHERE FirstName = 'John' AND LastName = 'Doe';
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql>
mysql> UPDATE address_book
    -> SET BookName = 'Work Contacts', BookType = 'Profession'
    -> WHERE FirstName = 'Jane' AND LastName = 'Smith';
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql>
mysql> UPDATE address_book
    -> SET BookName = 'Brown Family', BookType = 'Family'
    -> WHERE FirstName = 'Alice' AND LastName = 'Brown';
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql>
mysql> UPDATE address_book
    -> SET BookName = 'High School Friends', BookType = 'Friends'
    -> WHERE FirstName = 'Bob' AND LastName = 'Taylor';
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> SELECT * FROM address_book
    -> WHERE BookType = 'Family';
+----+-----------+----------+-------------+-------------+-------+---------+--------------+-------------------------+--------------+----------+
| ID | FirstName | LastName | Address     | City        | State | ZipCode | PhoneNumber  | Email                   | BookName     | BookType |
+----+-----------+----------+-------------+-------------+-------+---------+--------------+-------------------------+--------------+----------+
|  1 | Ashu      | Singh    | Paraspur    | Gonda       | UP    | 271001  | 1234567890   | abc.t@gmail.com         | Singh Family | Family   |
|  5 | Alice     | Brown    | 789 Pine St | Springfield | IL    | 62704   | 555-555-6666 | alice.brown@example.com | Brown Family | Family   |
+----+-----------+----------+-------------+-------------+-------+---------+--------------+-------------------------+--------------+----------+
2 rows in set (0.00 sec)

/*UC10 -> Ability to get number
of contact persons
i.e. count by type*/

mysql> SELECT BookType, COUNT(*) AS TotalContacts
    -> FROM address_book
    -> GROUP BY BookType;
+------------+---------------+
| BookType   | TotalContacts |
+------------+---------------+
| Family     |             2 |
| Friends    |             2 |
| Profession |             1 |
+------------+---------------+
3 rows in set (0.00 sec)

/*UC11 -> Ability to add person
to both Friend and
Family*/
mysql> CREATE TABLE BookTypes (
    ->     TypeID INT AUTO_INCREMENT PRIMARY KEY,
    ->     TypeName ENUM('Family', 'Friends', 'Profession', 'Other') NOT NULL
    -> );
Query OK, 0 rows affected (0.02 sec)

mysql> CREATE TABLE ContactTypes (
    ->     ContactID INT,
    ->     TypeID INT,
    ->     FOREIGN KEY (ContactID) REFERENCES address_book(ID),
    ->     FOREIGN KEY (TypeID) REFERENCES BookTypes(TypeID),
    ->     PRIMARY KEY (ContactID, TypeID)
    -> );
Query OK, 0 rows affected (0.04 sec)

mysql> INSERT INTO BookTypes (TypeName) VALUES
    -> ('Family'),
    -> ('Friends'),
    -> ('Profession'),
    -> ('Other');
Query OK, 4 rows affected (0.01 sec)
Records: 4  Duplicates: 0  Warnings: 0

mysql> INSERT INTO ContactTypes (ContactID, TypeID) VALUES
    -> (1, 1),
    -> (1, 2);
Query OK, 2 rows affected (0.00 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql> SELECT * FROM ContactTypes;
+-----------+--------+
| ContactID | TypeID |
+-----------+--------+
|         1 |      1 |
|         1 |      2 |
+-----------+--------+
2 rows in set (0.00 sec)

mysql> SELECT a.FirstName, a.LastName, b.TypeName
    -> FROM address_book a
    -> JOIN ContactTypes ct ON a.ID = ct.ContactID
    -> JOIN BookTypes b ON ct.TypeID = b.TypeID;
+-----------+----------+----------+
| FirstName | LastName | TypeName |
+-----------+----------+----------+
| Ashu      | Singh    | Family   |
| Ashu      | Singh    | Friends  |
+-----------+----------+----------+
2 rows in set (0.00 sec)

/*UC13 -> Ensure all retrieve
queries done especially
in UC 6, UC 7, UC 8 and
UC 10 are working with
new table structure*/

mysql> SELECT *
    -> From address_book
    -> where City = 'Gonda' OR State = 'Madison';
+----+-----------+----------+----------+-------+-------+---------+-------------+-----------------+--------------+----------+
| ID | FirstName | LastName | Address  | City  | State | ZipCode | PhoneNumber | Email           | BookName     | BookType |
+----+-----------+----------+----------+-------+-------+---------+-------------+-----------------+--------------+----------+
|  1 | Ashu      | Singh    | Paraspur | Gonda | UP    | 271001  | 1234567890  | abc.t@gmail.com | Singh Family | Family   |
+----+-----------+----------+----------+-------+-------+---------+-------------+-----------------+--------------+----------+
1 row in set (0.00 sec)

mysql> SELECT City, State, COUNT(*) AS TotalContacts
    -> FROM address_book
    -> GROUP BY City, State;
+-------------+-------+---------------+
| City        | State | TotalContacts |
+-------------+-------+---------------+
| Gonda       | UP    |             1 |
| Chicago     | IL    |             2 |
| Springfield | IL    |             1 |
| Madison     | WI    |             1 |
+-------------+-------+---------------+
4 rows in set (0.00 sec)


mysql> Select * from address_book where City = 'Chicago' Order By FirstName ASC , LastName ASC;
+----+-----------+----------+-------------+---------+-------+---------+--------------+------------------------+-----------------+------------+
| ID | FirstName | LastName | Address     | City    | State | ZipCode | PhoneNumber  | Email                  | BookName        | BookType   |
+----+-----------+----------+-------------+---------+-------+---------+--------------+------------------------+-----------------+------------+
|  4 | Jane      | Smith    | 456 Oak Ave | Chicago | IL    | 60601   | 555-333-4444 | jane.smith@example.com | Work Contacts   | Profession |
|  3 | John      | Doe      | 123 Elm St  | Chicago | IL    | 60601   | 555-111-2222 | john.doe@example.com   | College Friends | Friends    |
+----+-----------+----------+-------------+---------+-------+---------+--------------+------------------------+-----------------+------------+
2 rows in set (0.00 sec)

mysql> SELECT b.TypeName AS BookType, COUNT(ct.ContactID) AS TotalContacts
    -> FROM ContactTypes ct
    -> JOIN BookTypes b ON ct.TypeID = b.TypeID
    -> GROUP BY b.TypeName;
+----------+---------------+
| BookType | TotalContacts |
+----------+---------------+
| Family   |             1 |
| Friends  |             1 |
+----------+---------------+
2 rows in set (0.01 sec)