/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals WHERE name = 'Luna';

-- Find all animals whose name ends in "mon".
SELECT * FROM animals
WHERE name LIKE '%mon';


-- List the name of all animals born between 2016 and 2019.
SELECT name
FROM animals
WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

-- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT name
FROM animals
WHERE neutered = true AND escape_attempts < 3;

-- List the date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth
FROM animals
WHERE name IN ('Agumon', 'Pikachu');


-- List name and escape attempts of animals that weigh more than 10.5kg
SELECT name, escape_attempts
FROM animals
WHERE weight_kg > 10.5;

-- Find all animals that are neutered.
SELECT *
FROM animals
WHERE neutered = true;


-- Find all animals not named Gabumon.
SELECT *
FROM animals
WHERE name <> 'Gabumon';


-- Find all animals with a weight between 10.4kg and 17.3kg
--  (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT *
FROM animals
WHERE weight_kg BETWEEN 10.4 AND 17.3;



-- ---day 2 -------
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts, species)
VALUES
    ('Charmander', '2020-02-08', -11, false, 0, 'Fire'),
    ('Plantmon', '2021-11-15', -5.7, true, 2, 'Grass'),
    ('Squirtle', '1993-04-02', -12.13, false, 3, 'Water'),
    ('Angemon', '2005-06-12', -45, true, 1, 'Angel'),
    ('Boarmon', '2005-06-07', 20.4, true, 7, 'Mammal'),
    ('Blossom', '1998-10-13', 17, true, 3, 'Plant'),
    ('Ditto', '2022-05-14', 22, true, 4, 'Unknown');



-- Inside a transaction update the animals 
-- table by setting the species column 
-- to unspecified. Verify that change was made. 
-- Then roll back the change and verify that the 
-- species columns went back to the state before the transaction.

BEGIN;

UPDATE animals
SET species = 'unspecified';

SELECT * FROM animals;
ROLLBACK;

SELECT * FROM animals;


-- Second transaction
BEGIN;
UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';

UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;

SELECT * FROM animals;
COMMIT;

SELECT * FROM animals;




-- Third transaction for deleting  all recodrds in animals table
BEGIN;

DELETE FROM animals;

ROLLBACK;




-- Fourth transaction
BEGIN;

DELETE FROM animals
WHERE date_of_birth > '2022-01-01';

SAVEPOINT update_weights;

UPDATE animals
SET weight_kg = weight_kg * -1;

ROLLBACK TO update_weights;

UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;

COMMIT;



-- Queries for questions 
-- 1. How many animals are ther E

SELECT COUNT(*) FROM animals;


-- How many animals have never tried to escape?
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;



-- What is the average weight of animals?

SELECT AVG(weight_kg) FROM animals;


-- Who escapes the most, neutered or not neutered animals?
SELECT neutered, MAX(escape_attempts) AS max_escape_attempts
FROM animals
GROUP BY neutered;


-- What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight
FROM animals
GROUP BY species;


-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) AS avg_escape_attempts
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;

