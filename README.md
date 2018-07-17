# Bulletin-Board-System-Webpage
This project is establishing webpage supporting the board system with JSP, Tomcat server, and MySQL.

## MySQL

first, download MySQL Community from official website (https://dev.mysql.com/downloads/mysql/). After installing with click the downloaded file, type the listed commands on CLI terminal to access the MySQL terminal.

"cd /usr/local/mysql/bin" "./mysql -u root -p"

Then, the MySQL server runs.

Let's Test fundamental functions :

"CREATE DATABASE _______" -> Create the database named _______. "USE _______" -> Declare using ________ database. "CREATE TABLE USER(userID VARCHAR(20),userPassword VARCHAR(30),userName VARCHAR(20),userGender VARCHAR(20),userEmail VARCHAR(50),PRIMARY KEY(userID));" -> make table in the MySQL server with the elements. "show tables" -> shows tables made in current database. "desc ____" -> shows the properties of ____ table. "INSERT INTO USER VALUES('Junghwan','123456','Junghwan Yim','male','dlagudah@gmail.com');" -> ADD VALUE into table USER. "select * from USER;" -> shows the all elements in table USER. "commit;" -> save all changes.
