DROP DATABASE ada;
CREATE DATABASE ada;
USE ada;
CREATE TABLE Volunteer(
Name varchar(20),
Aadhaar_ID varchar(12) PRIMARY KEY,
DOB date NOT NULL,
Password varchar(10) NOT NULL,
Sex varchar(1) NOT NULL,
Address varchar(100) NOT NULL,
Blood_group varchar(3) NOT NULL,
Age int NOT NULL,
AIDS boolean,
HepC boolean,
Diabetes boolean,
Other boolean,
Eligible varchar(15)
);
CREATE TABLE Nurse (
Nurse_Name varchar(20),
Nurse_ID int PRIMARY KEY
);
CREATE TABLE Appointment(
Aadhaar_ID varchar(12),
Nurse_ID int,
AppDate Datetime,
Reason varchar(10),
Completion bool,
FOREIGN KEY (Aadhaar_ID) REFERENCES Volunteer(Aadhaar_ID),
FOREIGN KEY (Nurse_ID) REFERENCES Nurse(Nurse_ID)
);
CREATE TABLE Stockroom(
Equipment_ID int PRIMARY KEY,
Equipment_name varchar(20),
Equipment_stock int
);
CREATE TABLE Blood(
ID varchar(10) NOT NULL PRIMARY KEY,
Aadhaar_ID varchar(12) NOT NULL,
Nurse_ID int NOT NULL,
Amount float NOT NULL,
Blood_group varchar(3) NOT NULL,
Expiry date NOT NULL,
FOREIGN KEY (Aadhaar_ID) REFERENCES Volunteer(Aadhaar_ID),
FOREIGN KEY (Nurse_ID) REFERENCES Nurse(Nurse_ID)
);
CREATE TRIGGER Editstat AFTER INSERT ON Appointment FOR EACH ROW
UPDATE Volunteer SET Eligible=(SELECT IF (NEW.Reason="CheckUp","CheckUp",Eligible)) WHERE Volunteer.Aadhaar_ID=NEW.Aadhaar_ID;
CREATE TRIGGER Donorup AFTER INSERT ON Blood FOR EACH ROW
UPDATE Volunteer SET Eligible='Donor' WHERE  NEW.Aadhaar_ID=Volunteer.Aadhaar_ID;
CREATE EVENT Appointpass ON SCHEDULE  EVERY 1 HOUR
DO
UPDATE Appointment SET Completion=True WHERE AppDate<CURRENT_TIMESTAMP();
