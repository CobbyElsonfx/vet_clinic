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

