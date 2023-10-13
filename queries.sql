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


-- day three (3) queries
-- What animals belong to Melody Pond?

SELECT a.name
FROM animals AS a
JOIN owners AS o ON a.owner_id = o.id
WHERE o.full_name = 'Melody Pond';


-- List of all animals that are Pokemon (their type is Pokemon).

SELECT a.name
FROM animals AS a
JOIN species AS s ON a.species_id = s.id
WHERE s.name = 'Pokemon';


-- List all owners and their animals, including those who dont own any animals.

SELECT o.full_name, COALESCE(array_agg(a.name), '{}') AS owned_animals
FROM owners AS o
LEFT JOIN animals AS a ON o.id = a.owner_id
GROUP BY o.full_name;


-- How many animals are there per species?

SELECT s.name AS species_name, COUNT(a.id) AS animal_count
FROM species AS s
LEFT JOIN animals AS a ON s.id = a.species_id
GROUP BY s.name;


-- List all Digimon owned by Jennifer Orwell.

SELECT a.name
FROM animals AS a
JOIN species AS s ON a.species_id = s.id
JOIN owners AS o ON a.owner_id = o.id
WHERE s.name = 'Digimon' AND o.full_name = 'Jennifer Orwell';


-- List all animals owned by Dean Winchester that havent tried to escape.

SELECT a.name
FROM animals AS a
JOIN owners AS o ON a.owner_id = o.id
WHERE o.full_name = 'Dean Winchester' AND a.escape_attempts = 0;

-- Who owns the most animals?

SELECT o.full_name, COUNT(a.id) AS animal_count
FROM owners AS o
LEFT JOIN animals AS a ON o.id = a.owner_id
GROUP BY o.full_name
ORDER BY animal_count DESC
LIMIT 1;