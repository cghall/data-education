DROP SCHEMA IF EXISTS School CASCADE;

CREATE SCHEMA School;

CREATE TABLE School.Information(
  SchoolID INT NOT NULL,
  SchoolName varchar(150) NOT NULL
);

CREATE TABLE School.Progress(
  SchoolID INT NOT NULL,
  Progress8 varchar(25),
  Year varchar(4) NOT NULL
);

\copy School.Information(SchoolID, SchoolName) FROM './out/school_information.csv' DELIMITER ',' CSV HEADER;
\copy School.Progress(SchoolID, Progress8, Year) FROM './out/school_progress.csv' DELIMITER ',' CSV HEADER;