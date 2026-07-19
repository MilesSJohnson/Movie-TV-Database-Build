-- ====================================================================================
-- Developer: ___Miles Johnson___
-- Date: 02/25/2026
-- Assignment: Homework #4
-- Due Date: 03/02/2026
-- ====================================================================================

-- ====================================================================================
-- this statement will change the database to YOUR database.
USE MJOHN309
-- ====================================================================================

-- ====================================================================================
-- this statement will prevent messages of "(1 row(s) affected)"
SET NOCOUNT ON
-- ====================================================================================

-- ====================================================================================
-- NOTES FOR ALL USERS:
-- Note: When you see a -- (dash-dash) the line is commented.
-- Note: When you see a block of code surrounded by /* */ all that code is commented.
-- ====================================================================================

-- ====================================================================================
-- NOTES FOR SQL SERVER MANAGEMENT STUDIO USERS ONLY:
-- Note: If you'd like to see your results in text format (not grid),
-- press CTRL+T and run your script.
-- Note: If you want to get back to the grid format, press CTRL+D
-- ====================================================================================

-- ====================================================================================
-- NOTES FOR AZURE DATA STUDIO and VISUAL STUDIO CODE USERS:
-- Note: There's not a straight forward way to see your results text mode instead of
-- grid.
-- ====================================================================================

-- ====================================================================================
-- START CreateTablesForHomeworks
-- ====================================================================================

-- ====================================================================================
-- drop foreign keys
-- ====================================================================================

IF OBJECT_ID('FK_Show_Director') IS NOT NULL
	ALTER TABLE Show DROP CONSTRAINT IF EXISTS FK_Show_Director

IF OBJECT_ID('FK_Show_Genre') IS NOT NULL
	ALTER TABLE Show DROP CONSTRAINT IF EXISTS FK_Show_Genre

IF OBJECT_ID('FK_Role_Show') IS NOT NULL
	ALTER TABLE Role DROP CONSTRAINT IF EXISTS FK_Role_Show

IF OBJECT_ID('FK_Role_Actor') IS NOT NULL
	ALTER TABLE Role DROP CONSTRAINT IF EXISTS FK_Role_Actor

IF OBJECT_ID('FK_ShowAward_Show') IS NOT NULL
	ALTER TABLE ShowAward DROP CONSTRAINT IF EXISTS FK_ShowAward_Show

IF OBJECT_ID('FK_ShowAward_Award') IS NOT NULL
	ALTER TABLE ShowAward DROP CONSTRAINT IF EXISTS FK_ShowAward_Award

IF OBJECT_ID('FK_Viewer_Viewer') IS NOT NULL
	ALTER TABLE Viewer DROP CONSTRAINT IF EXISTS FK_Viewer_Viewer

IF OBJECT_ID('FK_Viewing_Show') IS NOT NULL
	ALTER TABLE Viewing DROP CONSTRAINT IF EXISTS FK_Viewing_Show

IF OBJECT_ID('FK_Viewing_Platform') IS NOT NULL
	ALTER TABLE Viewing DROP CONSTRAINT IF EXISTS FK_Viewing_Platform

IF OBJECT_ID('FK_Viewing_Viewer') IS NOT NULL
	ALTER TABLE Viewing DROP CONSTRAINT IF EXISTS FK_Viewing_Viewer

-- ====================================================================================
-- drop tables
-- ====================================================================================
DROP TABLE IF EXISTS Role
DROP TABLE IF EXISTS Viewing
DROP TABLE IF EXISTS ShowAward
DROP TABLE IF EXISTS Actor
DROP TABLE IF EXISTS Genre
DROP TABLE IF EXISTS Director
DROP TABLE IF EXISTS Award
DROP TABLE IF EXISTS Show
DROP TABLE IF EXISTS Viewer
DROP TABLE IF EXISTS Platform


-- ====================================================================================
-- create tables
-- ====================================================================================

CREATE TABLE Director
(
	DirectorID INT IDENTITY(1,1) NOT NULL,
	FirstName VARCHAR(25) NOT NULL,
	LastName VARCHAR(50) NOT NULL,
	Gender CHAR(1) NULL,
	CONSTRAINT PK_Director PRIMARY KEY CLUSTERED ( DirectorID ASC )
)

CREATE TABLE Genre
(
	GenreID INT IDENTITY(1,1) NOT NULL,
	GenreDescription VARCHAR(50) NOT NULL,
	CONSTRAINT PK_Genre PRIMARY KEY CLUSTERED ( GenreID ASC )
)


CREATE TABLE Award
(
	AwardID INT IDENTITY(1,1) NOT NULL,
	Name VARCHAR(50) NOT NULL,
	CONSTRAINT PK_Award PRIMARY KEY CLUSTERED ( AwardID ASC )
)


CREATE TABLE Show
(
	ShowID INT IDENTITY(1,1) NOT NULL,
	Title VARCHAR(50) NOT NULL,
	DateReleased DATE NOT NULL,
	Description VARCHAR(100) NOT NULL,
	BoxOfficeEarnings DECIMAL(15,2) NOT NULL,
	IMDBRating INT NOT NULL,
	IsMovie BIT NOT NULL,
	GenreID INT NOT NULL,
	DirectorID INT NOT NULL, 
	CONSTRAINT PK_Show PRIMARY KEY CLUSTERED ( ShowID ASC )
)


CREATE TABLE Actor
(
	ActorID INT IDENTITY(1,1) NOT NULL,
	FirstName VARCHAR(25) NOT NULL,
	LastName VARCHAR(50) NOT NULL,
	Gender CHAR(1) NULL,
	CONSTRAINT PK_Actor PRIMARY KEY CLUSTERED ( ActorID ASC )
)


CREATE TABLE Platform
(
	PlatformID INT IDENTITY(1,1) NOT NULL,
	PlatformName VARCHAR(50) NOT NULL,
	IsInternetBased BIT NOT NULL,
	CONSTRAINT PK_Platform PRIMARY KEY CLUSTERED ( PlatformID ASC )
)

CREATE TABLE Viewer
(
	ViewerID INT IDENTITY(1,1) NOT NULL,
	FirstName VARCHAR(25) NOT NULL,
	MI CHAR(1) NULL,
	LastName VARCHAR(50) NOT NULL,
	Gender CHAR(1) NULL,
	BestFriendID INT NULL,
	CONSTRAINT PK_Viewer PRIMARY KEY CLUSTERED ( ViewerID ASC )
)

CREATE TABLE Viewing
(
	ViewerID INT  NOT NULL,
	PlatformID INT NOT NULL,
	ShowID INT NOT NULL,
	WatchDateTime DATETIME NOT NULL,
	ViewerRatingStars DECIMAL(3,2) NOT NULL,
	CONSTRAINT PK_Viewing PRIMARY KEY CLUSTERED ( ViewerID ASC, PlatformID ASC, ShowID ASC )
)

CREATE TABLE ShowAward
(
	ShowID INT NOT NULL,
	AwardID INT NOT NULL,
	YearWon VARCHAR(50) NOT NULL,
	CONSTRAINT PK_ShowAward PRIMARY KEY CLUSTERED ( ShowID ASC, AwardID ASC )
)

CREATE TABLE Role
(
	ShowID INT NOT NULL,
	ActorID INT NOT NULL,
	CharacterName VARCHAR(50) NOT NULL,
	Salary INT NOT NULL,
	CONSTRAINT PK_Role PRIMARY KEY CLUSTERED ( ShowID ASC, ActorID ASC )
)
-- ====================================================================================
-- create foreign keys
-- ====================================================================================

ALTER TABLE Show
ADD CONSTRAINT FK_Show_Director
FOREIGN KEY (DirectorID)
REFERENCES Director (DirectorID)

ALTER TABLE Show
ADD CONSTRAINT FK_Show_Genre
FOREIGN KEY (GenreID)
REFERENCES Genre (GenreID)

ALTER TABLE Role
ADD CONSTRAINT FK_Role_Show
FOREIGN KEY (ShowID)
REFERENCES Show (ShowID)

ALTER TABLE Role
ADD CONSTRAINT FK_Role_Actor
FOREIGN KEY (ActorID)
REFERENCES Actor (ActorID)

ALTER TABLE ShowAward
ADD CONSTRAINT FK_ShowAward_Show
FOREIGN KEY (ShowID)
REFERENCES Show (ShowID)

ALTER TABLE ShowAward
ADD CONSTRAINT FK_ShowAward_Award
FOREIGN KEY (AwardID)
REFERENCES Award (AwardID)

ALTER TABLE Viewer
ADD CONSTRAINT FK_Viewer_Viewer
FOREIGN KEY (BestFriendID)
REFERENCES Viewer (ViewerID)

ALTER TABLE Viewing
ADD CONSTRAINT FK_Viewing_Viewer
FOREIGN KEY (ViewerID)
REFERENCES Viewer (ViewerID)


ALTER TABLE Viewing
ADD CONSTRAINT FK_Viewing_Platform
FOREIGN KEY (PlatformID)
REFERENCES Platform (PlatformID)

ALTER TABLE Viewing
ADD CONSTRAINT FK_Viewing_Show
FOREIGN KEY (ShowID)
REFERENCES Show (ShowID)


-- ====================================================================================
-- insert data
-- ====================================================================================
INSERT INTO Genre (GenreDescription) VALUES ('Action')
INSERT INTO Genre (GenreDescription) VALUES ('Comedy')
INSERT INTO Genre (GenreDescription) VALUES ('Drama')
INSERT INTO Genre (GenreDescription) VALUES ('Family')
INSERT INTO Genre (GenreDescription) VALUES ('Mystery')
INSERT INTO Genre (GenreDescription) VALUES ('Horror')

INSERT INTO Director (FirstName, LastName, Gender) VALUES ('Tim', 'Burton', 'M')
INSERT INTO Director (FirstName, LastName, Gender) VALUES ('Spike', 'Lee', 'M')
INSERT INTO Director (FirstName, LastName, Gender) VALUES ('Ridley', 'Scott', NULL)
INSERT INTO Director (FirstName, LastName, Gender) VALUES ('Christopher', 'Nolan', 'M')
INSERT INTO Director (FirstName, LastName, Gender) VALUES ('Steven', 'Spielberg', NULL)
INSERT INTO Director (FirstName, LastName, Gender) VALUES ('Ryan', 'Coogler', 'M')

INSERT INTO Award (Name) VALUES ('Best Movie')
INSERT INTO Award (Name) VALUES ('Leading Actor')
INSERT INTO Award (Name) VALUES ('Leading Actress')
INSERT INTO Award (Name) VALUES ('Original Screenplay')
INSERT INTO Award (Name) VALUES ('Costume Design')
INSERT INTO Award (Name) VALUES ('Documentary')

INSERT INTO Actor (FirstName, LastName, Gender) VALUES ('Jack', 'Black', NULL)
INSERT INTO Actor (FirstName, LastName, Gender) VALUES ('Paul', 'Rudd', NULL)
INSERT INTO Actor (FirstName, LastName, Gender) VALUES ('Denzel', 'Washington', 'M')
INSERT INTO Actor (FirstName, LastName, Gender) VALUES ('Emma', 'Stone', 'W')
INSERT INTO Actor (FirstName, LastName, Gender) VALUES ('Chase', 'Infiniti', 'W')
INSERT INTO Actor (FirstName, LastName, Gender) VALUES ('Kate', 'Hudson', NULL)

INSERT INTO Platform (PlatformName, IsInternetBased) VALUES ('Netflix', 1)
INSERT INTO Platform (PlatformName, IsInternetBased) VALUES ('Hulu', 1)
INSERT INTO Platform (PlatformName, IsInternetBased) VALUES ('HBOMAX', 0)
INSERT INTO Platform (PlatformName, IsInternetBased) VALUES ('Paramount', 0)
INSERT INTO Platform (PlatformName, IsInternetBased) VALUES ('Tubi', 1)
INSERT INTO Platform (PlatformName, IsInternetBased) VALUES ('Peacock', 0)


INSERT INTO Viewer (FirstName, MI, LastName, Gender, BestFriendID) VALUES ('Peter', NULL, 'Johnson', 'M', NULL)
INSERT INTO Viewer (FirstName, MI, LastName, Gender, BestFriendID) VALUES ('June', 'K', 'Smith', 'F', NULL)
INSERT INTO Viewer (FirstName, MI, LastName, Gender, BestFriendID) VALUES ('Cameron', NULL, 'Payne', NULL, NULL)
INSERT INTO Viewer (FirstName, MI, LastName, Gender, BestFriendID) VALUES ('Tracy', 'V', 'McGrady', 'F', NULL)
INSERT INTO Viewer (FirstName, MI, LastName, Gender, BestFriendID) VALUES ('Shaun', 'W', 'Brown', NULL, NULL)
INSERT INTO Viewer (FirstName, MI, LastName, Gender, BestFriendID) VALUES ('Devin', NULL, 'Booker', 'M', NULL)

UPDATE Viewer SET BestFriendID = 3 WHERE ViewerID = 1
UPDATE Viewer SET BestFriendID = 4 WHERE ViewerID = 2
UPDATE Viewer SET BestFriendID = 3 WHERE ViewerID = 3
UPDATE Viewer SET BestFriendID = 2 WHERE ViewerID = 4

INSERT INTO Show (Title, DateReleased, Description, BoxOfficeEarnings, IMDBRating,IsMovie, GenreID, DirectorID) VALUES ('Sinners', '04/18/2025', 'Twin brotheres face supernatural and human evil', 369445812, 8, 1, 1, 6)
INSERT INTO Show (Title, DateReleased, Description, BoxOfficeEarnings, IMDBRating,IsMovie, GenreID, DirectorID) VALUES ('Anchorman', '03/31/2003', 'Loved anchorman has to compete with a new fierce female anchorman', 111223765, 7, 1, 2, 3)
INSERT INTO Show (Title, DateReleased, Description, BoxOfficeEarnings, IMDBRating,IsMovie, GenreID, DirectorID) VALUES ('One Battle After Another', '09/02/2025', 'Revolutionary daughter has to flee from the government', 345981232, 7, 1, 3, 4)
INSERT INTO Show (Title, DateReleased, Description, BoxOfficeEarnings, IMDBRating,IsMovie, GenreID, DirectorID) VALUES ('Creed', '11/24/2015', 'Boxer rises to the top with fathers old ways', 109767581, 8, 1, 1, 6)
INSERT INTO Show (Title, DateReleased, Description, BoxOfficeEarnings, IMDBRating,IsMovie, GenreID, DirectorID) VALUES ('Edward Scissorhands', '06/13/1990', 'Artificail man with scissors hands is taken to the suburbs', 100456789, 8, 1, 4, 1)
INSERT INTO Show (Title, DateReleased, Description, BoxOfficeEarnings, IMDBRating,IsMovie, GenreID, DirectorID) VALUES ('Do the Right Thing', '05/19/1989', 'Tensions heat up on a hot summer day in New York', 175676128, 8, 1, 3, 4)
INSERT INTO Show (Title, DateReleased, Description, BoxOfficeEarnings, IMDBRating,IsMovie, GenreID, DirectorID) VALUES ('Office Space', '10/01/1999', '9-5 worker breaks out of the system', 80123328, 6, 1, 2, 3)
INSERT INTO Show (Title, DateReleased, Description, BoxOfficeEarnings, IMDBRating,IsMovie, GenreID, DirectorID) VALUES ('The Adventures of Tintin', '03/26/2011', 'Tintin and Captain Haddock set off on a treasure hunt for a sunken ship', 238783457, 6, 1, 4, 5)

INSERT INTO Role (ShowID, ActorID, CharacterName, Salary) VALUES (2, 2, 'Brian Fantana', 400000)
INSERT INTO Role (ShowID, ActorID, CharacterName, Salary) VALUES (1, 1, 'Mr. Beige', 700000)
INSERT INTO Role (ShowID, ActorID, CharacterName, Salary) VALUES (8, 4, 'Julia', 900000)
INSERT INTO Role (ShowID, ActorID, CharacterName, Salary) VALUES (6, 5, 'Alyssa Brancia', 800000)
INSERT INTO Role (ShowID, ActorID, CharacterName, Salary) VALUES (3, 3, 'Gregory Vick', 1000000)
INSERT INTO Role (ShowID, ActorID, CharacterName, Salary) VALUES (1, 3, 'Stomp', 1000000)
INSERT INTO Role (ShowID, ActorID, CharacterName, Salary) VALUES (5, 6, 'Store Employee', 300000)
INSERT INTO Role (ShowID, ActorID, CharacterName, Salary) VALUES (7, 2, 'Mr. Ott', 700000)
INSERT INTO Role (ShowID, ActorID, CharacterName, Salary) VALUES (4, 4, 'Ring Annoucer', 800000)

INSERT INTO ShowAward (ShowID, AwardID, YearWon) VALUES (3, 5, 2025)
INSERT INTO ShowAward (ShowID, AwardID, YearWon) VALUES (2, 6, 2008)
INSERT INTO ShowAward (ShowID, AwardID, YearWon) VALUES (1, 5, 2024)
INSERT INTO ShowAward (ShowID, AwardID, YearWon) VALUES (7, 3, 1999)
INSERT INTO ShowAward (ShowID, AwardID, YearWon) VALUES (4, 4, 2004)
INSERT INTO ShowAward (ShowID, AwardID, YearWon) VALUES (1, 3, 2008)
INSERT INTO ShowAward (ShowID, AwardID, YearWon) VALUES (5, 1, 2012)
INSERT INTO ShowAward (ShowID, AwardID, YearWon) VALUES (8, 2, 2010)
INSERT INTO ShowAward (ShowID, AwardID, YearWon) VALUES (7, 1, 1999)

INSERT INTO Viewing (ViewerID, PlatformID, ShowID, WatchDateTime, ViewerRatingStars) VALUES (1, 2, 3, '02/23/2025 12:34:23', 7)
INSERT INTO Viewing (ViewerID, PlatformID, ShowID, WatchDateTime, ViewerRatingStars) VALUES (5, 3, 4, '01/30/2026 04:34:18', 8)
INSERT INTO Viewing (ViewerID, PlatformID, ShowID, WatchDateTime, ViewerRatingStars) VALUES (3, 1, 4, '12/25/2025 08:08:55', 4)
INSERT INTO Viewing (ViewerID, PlatformID, ShowID, WatchDateTime, ViewerRatingStars) VALUES (4, 5, 6, '11/05/2025 05:32:38', 5)
INSERT INTO Viewing (ViewerID, PlatformID, ShowID, WatchDateTime, ViewerRatingStars) VALUES (2, 6, 7, '01/04/2026 06:23:12', 7)
INSERT INTO Viewing (ViewerID, PlatformID, ShowID, WatchDateTime, ViewerRatingStars) VALUES (1, 6, 8, '11/16/2025 18:34:00', 9)
INSERT INTO Viewing (ViewerID, PlatformID, ShowID, WatchDateTime, ViewerRatingStars) VALUES (6, 3, 1, '12/31/2025 21:21:12', 8)
INSERT INTO Viewing (ViewerID, PlatformID, ShowID, WatchDateTime, ViewerRatingStars) VALUES (5, 2, 2, '03/02/2026 04:01:13', 5)


-- ====================================================================================
-- Select all the data from all the tables, being sure to use an alias that 
-- makes sense for each statement
-- ====================================================================================
SELECT *
FROM Genre g

SELECT *
FROM Award aw

SELECT *
FROM Director d

SELECT *
FROM Viewer v

SELECT *
FROM Platform p

SELECT *
FROM Actor ac

SELECT *
FROM Show s

SELECT *
FROM ShowAward saw

SELECT *
FROM Role r

SELECT *
FROM Viewing vw



-- ====================================================================================
-- END CreateTablesForHomeworks
-- ====================================================