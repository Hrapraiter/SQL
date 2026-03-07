--SQLQuery4-CREATE Schadule branch.sql
USE PV_522_DDL;

CREATE TABLE Shedule
(
	leasson_id		BIGINT			PRIMARY KEY IDENTITY(1,1),--IDENTITY - Autoincrement
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
)
CREATE TABLE HomeWorks
(
	PRIMARY KEY(leasson , [group]),
	leasson			BIGINT			NOT NULL,
	[group]			INT				NOT NULL,
	[data]			VARBINARY(2000)		NULL,
	[description]	NVARCHAR(256)		NULL,

	CONSTRAINT CK_HW_Payload	CHECK ([description] IS NOT NULL OR [data] IS NOT NULL),

	CONSTRAINT	FK_HomeWorks_Shedule FOREIGN KEY (leasson) REFERENCES Shedule(leasson_id),
	CONSTRAINT	FK_HomeWorks_Groups	 FOREIGN KEY ([group]) REFERENCES Groups(group_id)
)
CREATE TABLE Grades
(
	student		INT		NOT NULL,
	leasson		BIGINT	NOT NULL,
	grade_1		TINYINT		CONSTRAINT CK_Grade_1 CHECK (grade_1 > 0 AND grade_1 <=12),
	grade_2		TINYINT		NULL,

	PRIMARY KEY(student , leasson),

	CONSTRAINT CK_Grade_2 CHECK (grade_2 > 0 AND grade_2 <=12),

	CONSTRAINT FK_Grades_Students	FOREIGN KEY (student) REFERENCES Students(student_id),
	CONSTRAINT FK_Grades_Shedule	FOREIGN KEY (leasson) REFERENCES Shedule(leasson_id),
)
CREATE TABLE HWResults
(
	student			INT				NOT NULL,
	[group]			INT				NOT NULL,
	leasson			BIGINT			NOT NULL,
	[description]	NVARCHAR(256)		NULL,
	[data]			VARBINARY(2000)		NULL,
	upload			DATETIME2(0)		NULL,
	grade			TINYINT				NULL,
	comment			NVARCHAR(500)		NULL,
	completion_time DATETIME2(0)		NULL,

	PRIMARY KEY (student , [group] , leasson),

	CONSTRAINT CK_HWR_Payload	CHECK([description] IS NOT NULL OR [data] IS NOT NULL),
	CONSTRAINT CK_HWR_Grade	CHECK (grade > 0 AND grade <= 12),

	CONSTRAINT	FK_HWResults_HomeWorks	FOREIGN KEY (leasson , [group]) REFERENCES HomeWorks(leasson , [group]),
	CONSTRAINT	FK_HWResults_Students	FOREIGN KEY (student)			REFERENCES Students(student_id),
)
CREATE TABLE Exams
(
	discipline		SMALLINT	NOT NULL,
	student			INT			NOT NULL,
	teacher			INT			NOT NULL,
	grade			TINYINT			NULL,
	completed		DATETIME2(0)	NULL,

	PRIMARY KEY(discipline , student , teacher),

	CONSTRAINT CK_Exams_Grade	CHECK ( grade > 0 AND grade <= 12 ),

	CONSTRAINT	FK_Exams_Teachers		FOREIGN KEY (teacher)	REFERENCES Teachers(teacher_id),
	CONSTRAINT	FK_Exams_Disciplines	FOREIGN KEY (discipline)REFERENCES Disciplines(discipline_id),
	CONSTRAINT	FK_Exams_Students		FOREIGN KEY (student)	REFERENCES Students(student_id)
);