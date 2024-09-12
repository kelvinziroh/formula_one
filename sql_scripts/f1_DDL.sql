-- CREATE & SELECT THE DATABASE/SCHEMA IN SQL EDITOR
CREATE DATABASE formula_one;
USE formula_one;

-- MAIN ENTITTIES
-- Create the circuits entity
CREATE TABLE circuits(
	circuitId INTEGER,
	circuitRef VARCHAR(20),
	name VARCHAR(50),
	location VARCHAR(30),
	country VARCHAR(20),
	lat DECIMAL(10,5),
	lng DECIMAL(10,5),
	alt INTEGER,
	url TEXT,
	PRIMARY KEY (circuitId)
);

-- Create the drivers entity
CREATE TABLE drivers(
	driverId INTEGER,
	driverRef VARCHAR(20),
	number INTEGER,
	code VARCHAR(5),
	forename VARCHAR(20),
	surname VARCHAR(30),
	dob DATE,
	nationality VARCHAR(20),
	url TEXT,
	PRIMARY KEY (driverId)
);

-- Create the constructors entity
CREATE TABLE constructors(
	constructorId INTEGER,
	constructorRef VARCHAR(30),
	name VARCHAR(30),
	nationality VARCHAR(20),
	url TEXT,
	PRIMARY KEY (constructorId)
);

-- Create the seasons entity
CREATE TABLE seasons(
	"year" INTEGER,
	url TEXT,
	PRIMARY KEY ("year")
);

-- Create the status entity
CREATE TABLE status(
	statusId INTEGER,
	status VARCHAR(30),
	PRIMARY KEY (statusId)
);

-- BRIDGE ENTITIES
-- Create races entity
CREATE TABLE races(
	raceId INTEGER,
	"year" INTEGER,
	"round" INTEGER,
	circuitId INTEGER,
	name VARCHAR(30),
	"date" DATE,
	"time" TIME,
	url TEXT,
	fp1_date DATE,
	fp1_time TIME,
	fp2_date DATE,
	fp2_time TIME,
	fp3_date DATE,
	fp3_time TIME,
	quali_date DATE,
	quali_time TIME,
	sprint_date DATE,
	sprint_time TIME,
	PRIMARY KEY (raceId)
);

-- Create qualifying entity
CREATE TABLE qualifying(
	qualifyId INTEGER,
	raceId INTEGER,
	driverId INTEGER,
	constructorId INTEGER,
	number INTEGER,
	position INTEGER,
	q1 VARCHAR(20),
	q2 VARCHAR(20),
	q3 VARCHAR(20),
	PRIMARY KEY (qualifyId)
);

-- Create the lap_times entity
CREATE TABLE lap_times(
	raceId INTEGER,
	driverId INTEGER,
	lap INTEGER,
	position INTEGER,
	`time` VARCHAR(20),
	milliseconds INTEGER,
	PRIMARY KEY (raceId, driverId, lap)
);

-- Create the pit_stops entity
CREATE TABLE pit_stops(
	raceId INTEGER,
	driverId INTEGER,
	stop INTEGER,
	lap INTEGER,
	`time` VARCHAR(20),
	duration VARCHAR(20),
	milliseconds INTEGER,
	PRIMARY KEY (raceId, driverId, stop)
);

-- Create the sprint_results entity
CREATE TABLE sprint_results(
	resultId INTEGER,
	raceId INTEGER,
	driverId INTEGER,
	constructorId INTEGER,
	number INTEGER,
	grid INTEGER,
	position INTEGER,
	positionOrder INTEGER,
	points INTEGER,
	laps INTEGER,
	`time` VARCHAR(20),
	milliseconds INTEGER,
	fastestLap INTEGER,
	fastestLapTime VARCHAR(20),
	statusId INTEGER,
	PRIMARY KEY (resultId)
);

-- Create results entity
CREATE TABLE results(
	resultId INTEGER,
	raceId INTEGER,
	driverId INTEGER,
	constructorId INTEGER,
	number INTEGER,
	grid INTEGER,
	position INTEGER,
	positionOrder INTEGER,
	points INTEGER,
	laps INTEGER,
	`time` VARCHAR(20),
	milliseconds INTEGER,
	fastestLap INTEGER,
	rank INTEGER,
	fastestLapTime VARCHAR(20),
	fastestLapSpeed DECIMAL(10,5),
	statusId INTEGER,
	PRIMARY KEY (resultId)
);

-- Create the driver_standings entity
CREATE TABLE driver_standings(
	driverStandingsId INTEGER,
	raceId INTEGER,
	driverId INTEGER,
	points INTEGER,
	position INTEGER,
	wins INTEGER,
	PRIMARY KEY (driverStandingsId)
);

-- Create constructor_results entity
CREATE TABLE constructor_results(
	constructorResultsId INTEGER,
	raceId INTEGER,
	constructorId INTEGER,
	points INTEGER,
	status VARCHAR(30),
	PRIMARY KEY (constructorResultsId)
);

-- Create constructor_standings entity
CREATE TABLE constructor_standings(
	constructorStandingsId INTEGER,
	raceId INTEGER,
	constructorId INTEGER,
	points INTEGER,
	position INTEGER,
	wins INTEGER,
	PRIMARY KEY (constructorStandingsId)
);

-- ADD FOREIGN KEYS
-- On races entity
ALTER TABLE races
ADD FOREIGN KEY (year) REFERENCES seasons(year),
ADD FOREIGN KEY (circuitId) REFERENCES circuits(circuitId);

-- On qualifying entity
ALTER TABLE qualifying
ADD FOREIGN KEY (raceId) REFERENCES races(raceId),
ADD FOREIGN KEY (driverId) REFERENCES drivers(driverId),
ADD FOREIGN KEY (constructorId) REFERENCES constructors(constructorId);

-- On lap_times entity
ALTER TABLE lap_times
ADD FOREIGN KEY (raceId) REFERENCES races(raceId),
ADD FOREIGN KEY (driverId) REFERENCES drivers(driverId);

-- On pit_stops entity
ALTER TABLE pit_stops
ADD FOREIGN KEY (raceId) REFERENCES races(raceId),
ADD FOREIGN KEY (driverId) REFERENCES drivers(driverId);

-- On sprint_results entity
ALTER TABLE sprint_results
ADD FOREIGN KEY (raceId) REFERENCES races(raceId),
ADD FOREIGN KEY (driverId) REFERENCES drivers(driverId),
ADD FOREIGN KEY (constructorId) REFERENCES constructors(constructorId),
ADD FOREIGN KEY (statusId) REFERENCES status(statusId);

-- On results entity
ALTER TABLE results
ADD FOREIGN KEY (raceId) REFERENCES races(raceId),
ADD FOREIGN KEY (driverId) REFERENCES drivers(driverId),
ADD FOREIGN KEY (constructorId) REFERENCES constructors(constructorId),
ADD FOREIGN KEY (statusId) REFERENCES status(statusId);

-- On driver_standings
ALTER TABLE driver_standings
ADD FOREIGN KEY (raceId) REFERENCES races(raceId),
ADD FOREIGN KEY (driverId) REFERENCES drivers(driverId);

-- On constructor_results
ALTER TABLE constructor_results
ADD FOREIGN KEY (raceId) REFERENCES races(raceId),
ADD FOREIGN KEY (constructorId) REFERENCES constructors(constructorId);

-- On constructor_standings
ALTER TABLE constructor_standings
ADD FOREIGN KEY (raceId) REFERENCES races(raceId),
ADD FOREIGN KEY (constructorId) REFERENCES constructors(constructorId);

