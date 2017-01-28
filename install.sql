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
  Progress8 varchar(25),
  Year varchar(4) NOT NULL
);

\copy School.Information(SchoolID, LocalAuthority, SchoolName, Street, Locality, Town, Postcode) FROM './out/school_information.csv' DELIMITER ',' CSV HEADER;
\copy School.Progress(SchoolID, Progress8, Year) FROM './out/school_progress.csv' DELIMITER ',' CSV HEADER;