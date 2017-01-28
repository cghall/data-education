DROP SCHEMA IF EXISTS School CASCADE;
DROP SCHEMA IF EXISTS LocalAuthority CASCADE;

CREATE SCHEMA LocalAuthority;

CREATE TABLE LocalAuthority.Information(
  LocalAuthorityID INT PRIMARY KEY,
  LocalAuthorityName varchar(40) NOT NULL,
  Region varchar(50) NOT NULL
);

\copy LocalAuthority.Information(LocalAuthorityID, LocalAuthorityName, Region) FROM './out/la.csv' DELIMITER ',' CSV HEADER;

CREATE SCHEMA School;

CREATE TABLE School.Information(
  SchoolID INT PRIMARY KEY,
  LocalAuthority INT NOT NUll REFERENCES LocalAuthority.Information (LocalAuthorityID),
  SchoolName varchar(150) NOT NULL,
  Street varchar(100),
  Locality varchar(100),
  Town varchar(50),
  Postcode varchar(10)
);

CREATE TABLE School.Progress(
  SchoolID INT NOT NULL REFERENCES School.Information,
  Progress8 REAL,
  Year varchar(4) NOT NULL,
  RankAsc INT,
  RankDesc INT, 
  PercentileAsc REAL,
  PercentileDesc REAL
);

\copy School.Information(SchoolID, LocalAuthority, SchoolName, Street, Locality, Town, Postcode) FROM './out/school_information.csv' DELIMITER ',' CSV HEADER;
\copy School.Progress(SchoolID, Progress8, Year, RankAsc, RankDesc, PercentileAsc, PercentileDesc) FROM './out/school_progress.csv' DELIMITER ',' CSV HEADER;

CREATE VIEW Progress8Results AS
  SELECT SchoolName, Progress8, RankAsc, PercentileAsc, Year
  FROM School.Information, School.Progress
  WHERE School.Progress.SchoolID = School.Information.SchoolID;