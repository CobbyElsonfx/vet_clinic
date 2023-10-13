/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id serial PRIMARY KEY,
    name text,
    date_of_birth date,
    escape_attempts integer,
    neutered boolean,
    weight_kg decimal
);


-- Day 2
ALTER TABLE animals
ADD COLUMN species text;


-- Day 3
CREATE TABLE owners (
    id serial PRIMARY KEY,
    full_name text,
    age integer
);

CREATE TABLE species (
    id serial PRIMARY KEY,
    name text
)

-- Remove the "species" column from the "animals" table
ALTER TABLE animals
DROP COLUMN species;

-- Add the "species_id" column as a foreign key referencing the "species" table
ALTER TABLE animals
ADD COLUMN species_id integer REFERENCES species(id);

-- Add the "owner_id" column as a foreign key referencing the "owners" table
ALTER TABLE animals
ADD COLUMN owner_id integer REFERENCES owners(id);



