CREATE DATABASE baseDos;

USE baseDos;

CREATE TABLE DEMO_STUDENT
 (SID VARCHAR(5) NOT NULL,
 NAME VARCHAR(50) NOT NULL,
 MAJOR VARCHAR(30),
 YEAR INTEGER,
 GPA DECIMAL(5,2),
CONSTRAINT STU_PK PRIMARY KEY (SID));

CREATE TABLE DEMO_INSTRUCTOR
 (IID VARCHAR(5) NOT NULL,
 NAME VARCHAR(50) NOT NULL,
 DEPT VARCHAR(30),
CONSTRAINT INST_PK PRIMARY KEY (IID));

CREATE TABLE DEMO_CLASSROOM
 (CRID VARCHAR(10) NOT NULL,
 DESCR VARCHAR(50) NOT NULL,
 CAP INTEGER,
CONSTRAINT CLSR_PK PRIMARY KEY (CRID));

CREATE TABLE DEMO_COURSE
 (CID VARCHAR(5) NOT NULL,
 TITLE VARCHAR(50),
 IID VARCHAR(5) NOT NULL,
 HOUR INTEGER,
 CRID VARCHAR(30),
CONSTRAINT COURSE_PK PRIMARY KEY (CID),
CONSTRAINT COUR_FKDISP1 FOREIGN KEY (IID) REFERENCES DEMO_INSTRUCTOR(IID),
CONSTRAINT COUR_FK2 FOREIGN KEY (CRID) REFERENCES DEMO_CLASSROOM(CRID));

CREATE TABLE DEMO_REGISTRATION
 (RID VARCHAR(5) NOT NULL,
 SID VARCHAR(5) NOT NULL,
 CID VARCHAR(5) NOT NULL,
CONSTRAINT REG_PK PRIMARY KEY (RID),
CONSTRAINT REG_FK1 FOREIGN KEY (SID) REFERENCES DEMO_STUDENT(SID),
CONSTRAINT REG_FK2 FOREIGN KEY (CID) REFERENCES DEMO_COURSE(CID));

--1.-
SELECT CID, CRID, TITLE, IID FROM DEMO_COURSE
WHERE IID = 'I06';

--9.
SELECT r.SID, r.CID, s.MAJOR 
FROM DEMO_REGISTRATION r
JOIN DEMO_STUDENT s ON r.SID = s.SID
WHERE s.MAJOR = 'Computer';

--8.
SELECT * FROM DEMO_STUDENT
WHERE ((YEAR = 1) AND (GPA < 2));

--4.


