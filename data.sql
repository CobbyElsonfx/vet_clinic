/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES
    ('Agumon', '2020-02-03', 10.23, true, 0),
    ('Gabumon', '2018-11-15', 8, true, 2),
    ('Pikachu', '2021-01-07', 15.04, false, 1),
    ('Devimon', '2017-05-12', 11, true, 5);



-- Second day 
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts, species)
VALUES
    ('Charmander', '2020-02-08', -11, false, 0, 'Fire'),
    ('Plantmon', '2021-11-15', -5.7, true, 2, 'Grass'),
    ('Squirtle', '1993-04-02', -12.13, false, 3, 'Water'),
    ('Angemon', '2005-06-12', -45, true, 1, 'Angel'),
    ('Boarmon', '2005-06-07', 20.4, true, 7, 'Mammal'),
    ('Blossom', '1998-10-13', 17, true, 3, 'Plant'),
    ('Ditto', '2022-05-14', 22, true, 4, 'Unknown');


    --day three(3)
    -- Inserting data into the "owners" table
INSERT INTO owners (full_name, age)
VALUES
    ('Sam Smith', 34),
    ('Jennifer Orwell', 19),
    ('Bob', 45),
    ('Melody Pond', 77),
    ('Dean Winchester', 14),
    ('Jodie Whittaker', 38);

-- Update the "species_id" based on name
UPDATE animals
SET species_id = (
    CASE
        WHEN name LIKE '%mon' THEN (SELECT id FROM species WHERE name = 'Digimon')
        ELSE (SELECT id FROM species WHERE name = 'Pokemon')
    END
);


-- Update the "owner_id" based on owner information
UPDATE animals
SET owner_id = (
    CASE
        WHEN name = 'Agumon' THEN (SELECT id FROM owners WHERE full_name = 'Sam Smith')
        WHEN name IN ('Gabumon', 'Pikachu') THEN (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
        WHEN name IN ('Devimon', 'Plantmon') THEN (SELECT id FROM owners WHERE full_name = 'Bob')
        WHEN name IN ('Charmander', 'Squirtle', 'Blossom') THEN (SELECT id FROM owners WHERE full_name = 'Melody Pond')
        WHEN name IN ('Angemon', 'Boarmon') THEN (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
    END
);


-- day four (4)
--Insert data into vets table
INSERT INTO vets (name, age, date_of_graduation)
VALUES
    ('William Tatcher', 45, '2000-04-23'),
    ('Maisy Smith', 26, '2019-01-17'),
    ('Stephanie Mendez', 64, '1981-05-04'),
    ('Jack Harkness', 38, '2008-06-08');



-- Insert data for specializations
INSERT INTO specializations (vet_id, species_id)
SELECT v.id, s.id
FROM vets v
JOIN species s ON (v.name = 'William Tatcher' AND s.name = 'Pokemon')
OR (v.name = 'Stephanie Mendez' AND (s.name = 'Digimon' OR s.name = 'Pokemon'))
OR (v.name = 'Jack Harkness' AND s.name = 'Digimon');



-- Insert data for visits
INSERT INTO visits (vet_id, animal_id, visit_date)
VALUES
    ((SELECT id FROM vets WHERE name = 'William Tatcher' LIMIT 1), (SELECT id FROM animals WHERE name = 'Agumon' LIMIT 1), '2020-05-24'),
    ((SELECT id FROM vets WHERE name = 'Stephanie Mendez' LIMIT 1), (SELECT id FROM animals WHERE name = 'Agumon' LIMIT 1), '2020-07-22'),
    ((SELECT id FROM vets WHERE name = 'Jack Harkness' LIMIT 1), (SELECT id FROM animals WHERE name = 'Gabumon' LIMIT 1), '2021-02-02'),
    ((SELECT id FROM vets WHERE name = 'Maisy Smith' LIMIT 1), (SELECT id FROM animals WHERE name = 'Pikachu' LIMIT 1), '2020-01-05'),
    ((SELECT id FROM vets WHERE name = 'Maisy Smith' LIMIT 1), (SELECT id FROM animals WHERE name = 'Pikachu' LIMIT 1), '2020-03-08'),
    ((SELECT id FROM vets WHERE name = 'Maisy Smith' LIMIT 1), (SELECT id FROM animals WHERE name = 'Pikachu' LIMIT 1), '2020-05-14'),
    ((SELECT id FROM vets WHERE name = 'Stephanie Mendez' LIMIT 1), (SELECT id FROM animals WHERE name = 'Devimon' LIMIT 1), '2021-05-04'),
    ((SELECT id FROM vets WHERE name = 'Jack Harkness' LIMIT 1), (SELECT id FROM animals WHERE name = 'Charmander' LIMIT 1), '2021-02-24'),
    ((SELECT id FROM vets WHERE name = 'Maisy Smith' LIMIT 1), (SELECT id FROM animals WHERE name = 'Plantmon' LIMIT 1), '2019-12-21'),
    ((SELECT id FROM vets WHERE name = 'William Tatcher' LIMIT 1), (SELECT id FROM animals WHERE name = 'Plantmon' LIMIT 1), '2020-08-10'),
    ((SELECT id FROM vets WHERE name = 'Maisy Smith' LIMIT 1), (SELECT id FROM animals WHERE name = 'Plantmon' LIMIT 1), '2021-04-07'),
    ((SELECT id FROM vets WHERE name = 'Stephanie Mendez' LIMIT 1), (SELECT id FROM animals WHERE name = 'Squirtle' LIMIT 1), '2019-09-29'),
    ((SELECT id FROM vets WHERE name = 'Jack Harkness' LIMIT 1), (SELECT id FROM animals WHERE name = 'Angemon' LIMIT 1), '2020-10-03'),
    ((SELECT id FROM vets WHERE name = 'Jack Harkness' LIMIT 1), (SELECT id FROM animals WHERE name = 'Angemon' LIMIT 1), '2020-11-04'),
    ((SELECT id FROM vets WHERE name = 'Maisy Smith' LIMIT 1), (SELECT id FROM animals WHERE name = 'Boarmon' LIMIT 1), '2019-01-24'),
    ((SELECT id FROM vets WHERE name = 'Maisy Smith' LIMIT 1), (SELECT id FROM animals WHERE name = 'Boarmon' LIMIT 1), '2019-05-15'),
    ((SELECT id FROM vets WHERE name = 'Maisy Smith' LIMIT 1), (SELECT id FROM animals WHERE name = 'Boarmon' LIMIT 1), '2020-02-27'),
    ((SELECT id FROM vets WHERE name = 'Maisy Smith' LIMIT 1), (SELECT id FROM animals WHERE name = 'Boarmon' LIMIT 1), '2020-08-03'),
    ((SELECT id FROM vets WHERE name = 'Stephanie Mendez' LIMIT 1), (SELECT id FROM animals WHERE name = 'Blossom' LIMIT 1), '2020-05-24'),
    ((SELECT id FROM vets WHERE name = 'William Tatcher' LIMIT 1), (SELECT id FROM animals WHERE name = 'Blossom' LIMIT 1), '2021-01-11');
