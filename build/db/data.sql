CREATE DATABASE IF NOT EXISTS StudentSchedule;
USE StudentSchedule;

CREATE TABLE Roles (
    Id_role INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL UNIQUE
);
INSERT INTO Roles (Name) VALUES ('admin');
INSERT INTO Roles (Name) VALUES ('student');
INSERT INTO Roles (Name) VALUES ('teacher');

CREATE TABLE `Groups` (
    Id_group INT AUTO_INCREMENT PRIMARY KEY,
    Group_name VARCHAR(20)
);

CREATE TABLE Users (
    Id_user INT AUTO_INCREMENT PRIMARY KEY,
    Login VARCHAR(50) NOT NULL UNIQUE,
    Pas VARCHAR(255),
    CreateCode VARCHAR(16),
    Id_role INT NOT NULL,
    FOREIGN KEY (Id_role) REFERENCES Roles(Id_role) ON DELETE CASCADE
);
INSERT INTO Users (Login, Pas, Id_role)
VALUES ('admin', 'admin_228', (SELECT Id_role FROM Roles WHERE Name = 'admin'));

CREATE TABLE Student (
    Id_student INT AUTO_INCREMENT PRIMARY KEY,
    Id_user INT NOT NULL,
    Name VARCHAR(50) NOT NULL,
    Surname VARCHAR(50) NOT NULL,
    Middle_name VARCHAR(50),
    Id_group INT NOT NULL,
    FOREIGN KEY (Id_user) REFERENCES Users(Id_user) ON DELETE CASCADE,
    FOREIGN KEY (Id_group) REFERENCES `Groups`(Id_group) ON DELETE CASCADE
);

CREATE TABLE Teacher (
    Id_user INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Surname VARCHAR(50) NOT NULL,
    Middle_name VARCHAR(50),
    FOREIGN KEY (Id_user) REFERENCES Users(Id_user) ON DELETE CASCADE
);

CREATE TABLE Schedule (
    Id_schedule INT AUTO_INCREMENT PRIMARY KEY,
    Id_group INT NOT NULL,
    Date DATE NOT NULL,
    Start_time TIME NOT NULL,
    End_time TIME NOT NULL,
    Subject VARCHAR(100) NOT NULL,
    Teacher_id INT NOT NULL,
    FOREIGN KEY (Id_group) REFERENCES `Groups`(Id_group) ON DELETE CASCADE,
    FOREIGN KEY (Teacher_id) REFERENCES Teacher(Id_user) ON DELETE CASCADE
);

CREATE TABLE Homework (
    Id_homework INT AUTO_INCREMENT PRIMARY KEY,
    Id_schedule INT NOT NULL,
    Description TEXT NOT NULL,
    Deadline DATE NOT NULL,
    FOREIGN KEY (Id_schedule) REFERENCES Schedule(Id_schedule) ON DELETE CASCADE
);

SELECT User, Host FROM mysql.user WHERE User = 'admin';
DROP USER IF EXISTS 'admin';

CREATE USER 'admin' IDENTIFIED BY 'admin_228';
GRANT ALL PRIVILEGES ON StudentSchedule.* TO 'admin';
FLUSH PRIVILEGES;
