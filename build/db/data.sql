CREATE DATABASE IF NOT EXISTS StudentSchedule CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE StudentSchedule;

CREATE TABLE Roles (
    Id_role INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL UNIQUE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
INSERT INTO Roles (Name) VALUES ('admin');
INSERT INTO Roles (Name) VALUES ('student');
INSERT INTO Roles (Name) VALUES ('teacher');

CREATE TABLE `Groups` (
    Id_group INT AUTO_INCREMENT PRIMARY KEY,
    Group_name VARCHAR(20)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE Users (
    Id_user INT AUTO_INCREMENT PRIMARY KEY,
    Login VARCHAR(50) NOT NULL UNIQUE,
    Pas VARCHAR(255),
    CreateCode VARCHAR(16),
    Id_role INT NOT NULL,
    activated BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (Id_role) REFERENCES Roles(Id_role) ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
INSERT INTO Users (Login, Pas, Id_role)
VALUES ('admin', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', (SELECT Id_role FROM Roles WHERE Name = 'admin'));

CREATE TABLE Student (
    Id_student INT AUTO_INCREMENT PRIMARY KEY,
    Id_user INT NOT NULL,
    Name VARCHAR(50) NOT NULL,
    Surname VARCHAR(50) NOT NULL,
    Middle_name VARCHAR(50),
    Id_group INT NOT,
    FOREIGN KEY (Id_user) REFERENCES Users(Id_user) ON DELETE CASCADE,
    FOREIGN KEY (Id_group) REFERENCES `Groups`(Id_group) ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE Teacher (
    Id_teacher INT AUTO_INCREMENT PRIMARY KEY,
    Id_user INT NOT NULL UNIQUE,
    Name VARCHAR(50) NOT NULL,
    Surname VARCHAR(50) NOT NULL,
    Middle_name VARCHAR(50),
    FOREIGN KEY (Id_user) REFERENCES Users(Id_user) ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE Specializations (
    Id_specialization INT AUTO_INCREMENT PRIMARY KEY,
    Specialization_name VARCHAR(255)UNIQUE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE Schedule (
    Id_schedule INT AUTO_INCREMENT PRIMARY KEY,
    Id_group INT NOT NULL,
    day VARCHAR(20) NOT NULL,
    subj1 INT,
    subj2 INT,
    subj3 INT,
    subj4 INT,
    subj5 INT,
    FOREIGN KEY (Id_group) REFERENCES `Groups`(Id_group) ON DELETE CASCADE,
    FOREIGN KEY (subj1) REFERENCES Specializations(Id_specialization) ON DELETE CASCADE,
    FOREIGN KEY (subj2) REFERENCES Specializations(Id_specialization) ON DELETE CASCADE,
    FOREIGN KEY (subj3) REFERENCES Specializations(Id_specialization) ON DELETE CASCADE,
    FOREIGN KEY (subj4) REFERENCES Specializations(Id_specialization) ON DELETE CASCADE,
    FOREIGN KEY (subj5) REFERENCES Specializations(Id_specialization) ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE Homework (
    Id_homework INT AUTO_INCREMENT PRIMARY KEY,
    Id_schedule INT NOT NULL,
    Description TEXT NOT NULL,
    Deadline DATE NOT NULL,
    FOREIGN KEY (Id_schedule) REFERENCES Schedule(Id_schedule) ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;



CREATE TABLE TeacherSpecializations (
    Id_teacher INT,
    Id_specialization INT,
    FOREIGN KEY (Id_teacher) REFERENCES Teacher(Id_user),
    FOREIGN KEY (Id_specialization) REFERENCES Specializations(Id_specialization)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

INSERT INTO Specializations (Specialization_name) VALUES (null);
INSERT INTO Specializations (Specialization_name) VALUES ('Математика');
INSERT INTO Specializations (Specialization_name) VALUES ('Русский Язык');
INSERT INTO Specializations (Specialization_name) VALUES ('Физ-ра');
INSERT INTO Specializations (Specialization_name) VALUES ('Информатика');

CREATE TABLE Groups_Specialization_teacher (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Group_id INT,
    Specialization_id INT,
    Teacher_id INT,
    FOREIGN KEY (Group_id) REFERENCES `Groups`(Id_group),
    FOREIGN KEY (Specialization_id) REFERENCES Specializations(Id_specialization),
    FOREIGN KEY (Teacher_id) REFERENCES Teacher(Id_user)
);

SELECT User, Host FROM mysql.user WHERE User = 'admin';
DROP USER IF EXISTS 'admin';

CREATE USER 'admin' IDENTIFIED BY 'admin_228';
GRANT ALL PRIVILEGES ON StudentSchedule.* TO 'admin';
FLUSH PRIVILEGES;