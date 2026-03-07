--SQLQuery5-ALL_IN_ONE.sql

USE master;

CREATE DATABASE PV_522_ALL_IN_ONE
ON
(
	NAME		= PV_522_ALL_IN_ONE,
	FILENAME	= 'D:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\PV_522_ALL_IN_ONE.mdf',
	SIZE		= 8MB,
	MAXSIZE		= 500MB,
	FILEGROWTH	= 8MB
)
LOG ON
(
	NAME		= PV_522_ALL_IN_ONE_LOG,
	FILENAME	= 'D:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\PV_522_ALL_IN_ONE_LOG.ldf',
	SIZE		= 8MB,
	MAXSIZE		= 500MB,
	FILEGROWTH	= 8MB
);
GO

USE PV_522_ALL_IN_ONE;


CREATE TABLE Directions
(
	direction_id	SMALLINT PRIMARY KEY,
	direction_name  NVARCHAR(150)NOT NULL
);
CREATE TABLE Groups
(
	group_id		INT			PRIMARY KEY,
	group_name		NVARCHAR(24)NOT NULL,
	start_date		DATE		NOT NULL,
	satrt_time		TIME		NOT NULL,
	learning_days	INT			NOT NULL,
	direction		SMALLINT	NOT NULL	
	CONSTRAINT		FK_Groups_Directions	FOREIGN KEY REFERENCES	Directions(direction_id)
);
CREATE TABLE Students
(
	student_id		INT			PRIMARY KEY,
	last_name		NVARCHAR(50)NOT NULL,
	first_name		NVARCHAR(50)NOT NULL,
	middle_name		NVARCHAR(50)	NULL,
	birth_date		DATE		NOT NULL,
	[group]			INT			NOT NULL
	CONSTRAINT		FK_Students_Groups	FOREIGN KEY REFERENCES	Groups(group_id)
)

CREATE TABLE Teachers
(
	teacher_id		INT			PRIMARY KEY,
	last_name		NVARCHAR(50)NOT NULL,
	first_name		NVARCHAR(50)NOT NULL,
	middle_name		NVARCHAR(50)	NULL,
	birth_date		DATE		NOT NULL,
	rate			MONEY		NOT NULL	DEFAULT 50
)
CREATE TABLE Disciplines
(
	discipline_id		SMALLINT		PRIMARY KEY,
	discipline_name		NVARCHAR(150)	NOT NULL,
	number_of_lessons	TINYINT			NOT NULL
);

CREATE TABLE TeachersDisciplinesRelation
(
	teacher		INT,
	discipline	SMALLINT,
	PRIMARY KEY	(teacher,discipline),
	CONSTRAINT	FK_TDR_Teachers		FOREIGN KEY (teacher) REFERENCES Teachers(teacher_id),
	CONSTRAINT	FK_TDR_Disciplines	FOREIGN KEY (discipline) REFERENCES Disciplines(discipline_id)
)
CREATE TABLE DisciplinesDirectionRelation
(
	discipline		SMALLINT,
	direction		SMALLINT,
	PRIMARY KEY		(discipline , direction),
	CONSTRAINT	FK_DDR_Discipline	FOREIGN KEY	(discipline)	REFERENCES	Disciplines(discipline_id),
	CONSTRAINT	FK_DDR_Direction	FOREIGN KEY	(direction)	REFERENCES	Directions(direction_id),
);
CREATE TABLE Shedule
(
	leasson_id		BIGINT			PRIMARY KEY,
	[group]			INT				NOT NULL,
	discipline		SMALLINT		NOT NULL,
	[date]			DATE			NOT NULL,
	[time]			TIME(0)			NOT NULL,
	teacher			INT				NOT NULL,
	[subject]		NVARCHAR(256)		NULL,
	spent			BIT				NOT NULL

	CONSTRAINT	FK_Schedule_Groups		FOREIGN KEY ([group])	REFERENCES Groups(group_id),
	CONSTRAINT	FK_Schedule_Disciplines	FOREIGN KEY (discipline)REFERENCES Disciplines(discipline_id),
	CONSTRAINT	FK_Schedule_Teachers	FOREIGN KEY	(teacher)	REFERENCES Teachers(teacher_id)
);
CREATE TABLE HomeWorks
(
	leasson			BIGINT			NOT NULL,
	[group]			INT				NOT NULL,
	[data]			VARBINARY(2000)		NULL,
	[description]	NVARCHAR(256)		NULL,

	PRIMARY KEY(leasson , [group]),

	CONSTRAINT	FK_HomeWorks_Shedule FOREIGN KEY (leasson) REFERENCES Shedule(leasson_id),
	CONSTRAINT	FK_HomeWorks_Groups	 FOREIGN KEY ([group]) REFERENCES Groups(group_id)
)
CREATE TABLE Grades
(
	student		INT		NOT NULL,
	leasson		BIGINT	NOT NULL,
	grade_1		TINYINT		NULL,
	grade_2		TINYINT		NULL,

	PRIMARY KEY(student , leasson),

	CONSTRAINT FK_Grades_Students	FOREIGN KEY (student) REFERENCES Students(student_id),
	CONSTRAINT FK_Grades_Shedule	FOREIGN KEY (leasson) REFERENCES Shedule(leasson_id),
)
CREATE TABLE HWResults
(
	leasson			BIGINT			NOT NULL,
	[group]			INT				NOT NULL,
	student			INT				NOT NULL,
	[description]	NVARCHAR(256)		NULL,
	[data]			VARBINARY(2000)		NULL,
	grade			TINYINT				NULL,
	comment			NVARCHAR(500)		NULL,
	completion_time DATETIME2(0)		NULL,

	PRIMARY KEY(leasson , [group] , student),

	CONSTRAINT	FK_HWResults_HomeWorks	FOREIGN KEY (leasson , [group]) REFERENCES HomeWorks(leasson , [group]),
	CONSTRAINT	FK_HWResults_Students	FOREIGN KEY (student)			REFERENCES Students(student_id),
)
CREATE TABLE Exams
(
	discipline		SMALLINT	NOT NULL,
	student			INT			NOT NULL,
	teacher			INT			NOT NULL,
	grade			TINYINT			NULL

	PRIMARY KEY(discipline , student , teacher),

	CONSTRAINT	FK_Exams_TDR		FOREIGN KEY (teacher , discipline)	REFERENCES TeachersDisciplinesRelation(teacher , discipline),
	CONSTRAINT	FK_Exams_Students	FOREIGN KEY (student)				REFERENCES Students(student_id)
);
