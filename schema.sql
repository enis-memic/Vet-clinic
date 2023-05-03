/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
   id INT GENERATED ALWAYS AS IDENTITY,
	name VARCHAR ( 50 ) UNIQUE NOT NULL,
	date_of_birth DATE ,
	escape_attempts INTEGER ,
	neutered BOOLEAN ,
    weight_kg NUMERIC(5,2),
	 species VARCHAR(50),
	  PRIMARY KEY(id),
);

-- Create new table -- 
CREATE TABLE owners (
	id SERIAL PRIMARY KEY,
	full_name VARCHAR (50) NOT NULL,
	age INT NOT NULL
);

-- Create new table -- 
CREATE TABLE species(
		id SERIAL PRIMARY KEY,
		name VARCHAR(50) NOT NULL
);

--Remove from animals table-- 
ALTER TABLE animals
  DROP COLUMN species;

-- Add column species_id with foreign key to species table-- 
ALTER TABLE animals ADD species_id INT REFERENCES species(id);

ALTER TABLE animals
ADD CONSTRAINT species_id
FOREIGN KEY (species_id)
REFERENCES species(id);

-- Add column owners_id with foreign key to owners table-- 
ALTER TABLE animals ADD owner_id INT REFERENCES owners(id);
ALTER TABLE animals
ADD CONSTRAINT owner_id
FOREIGN KEY (owner_id)
REFERENCES owners(id);

-- Create a table named vets with following columns
CREATE TABLE vets(
    id bigserial NOT NULL,
    name VARCHAR(50),
    age integer,
    date_of_graduation date NOT NULL,
    PRIMARY KEY (id)
);
