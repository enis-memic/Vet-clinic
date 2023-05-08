/* Populate database with sample data. */
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Agumon', '2020-02-03' , 0, TRUE, 10.23 );
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Gabumon', '2018-11-15' , 2, TRUE, 8 );
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Pikachu', '2021-01-7', 1, FALSE, 15.04);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Devimon', '2017-05-12', 5, TRUE, 11);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Charmander', '2020-2-8', 0, false, -11.0); 
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Plantmon', '2021-11-15', 2, true, -5.7);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Squirtle', '1993-04-02', 3, false, -12.13);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Angemon', '2005-06-12', 1, true, -45.0);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Boarmon', '2005-06-07', 7, true, 20.4);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Blossom', '1998-10-13', 3, true, 17);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Ditto', '2022-05-14', 4, true, 22);

-- Insert data in owners table --
INSERT INTO owners (full_name, age) VALUES ('Sam Smith', '34'),('Jennifer Orwell', '19'),
	('Bob', '45'),
	('Melody Pond', '77'),
	('Dean Winchester', '14'),
	('Jodie Whittaker', '38');

-- Insert data into species table -- 
INSERT INTO species (name)
VALUES ('Pokemon'),
('Digimon');



--Modify animals species_id--

BEGIN; 
UPDATE animals SET species_id = 2 WHERE name LIKE '%mon';
UPDATE animals SET species_id = 1 WHERE name NOT LIKE '%mon';


-- Modify animals owner_id--
BEGIN; 
UPDATE animals SET owner_id = 1 WHERE name = 'Agumon';
UPDATE animals SET owner_id = 2 WHERE name IN ('Gabumon', 'Pikachu');
UPDATE animals SET owner_id = 3 WHERE name IN ('Devimon', 'Plantmon'); 
UPDATE animals SET owner_id = 4 WHERE name IN ('Charmander', 'Squirtle', 'Blossom'); 
UPDATE animals SET owner_id = 5 WHERE name IN ('Angemon', 'Boarmon');


-- Insert the following data for the vets
INSERT INTO vets(name,age,date_of_graduation)
VALUES('William Tatcher', 45, '2000-04-23') 
,('Maisy Smith', 26,  '2019-01-17'),
('Stephanie Mendez', 64,  '1981-05-04'),
('Jack Harkness', 38,  '2008-06-08');


-- Insert data for the specializations
INSERT INTO specializations(vets_id,species_id) VALUES ('1', '1'),('3', '1'),('3', '2'),('4', '2');

-- Insert the following data for visits

INSERT INTO visits(animals_id, vets_id, date_of_visit)
VALUES
	('20', '1', date '2020-05-24'),
	('20', '3', date '2020-07-22'),
	('21', '4', date '2021-02-02'),
	('22', '2', date '2020-01-05'),
	('22', '2', date '2020-03-08'),
	('22', '2', date '2020-05-14'),
	('23', '3', date '2021-05-04'),
	('24', '4', date '2021-02-24'),
	('25', '2', date '2019-12-21'),
	('25', '1', date '2020-08-10'),
	('25', '2', date '2021-04-07'),
	('26', '3', date '2019-09-29'),
	('27', '4', date '2020-10-03'),
	('27', '4', date '2020-11-04'),
	('28', '2', date '2019-01-24'),
	('28', '2', date '2019-05-15'),
	('28', '2', date '2020-02-27'),
	('28', '2', date '2020-08-03'),
	('29', '3', date '2020-05-24'),
	('29', '1', date '2021-01-11');

	-- Insert new visits and data -- 
INSERT INTO visits (animal_id, vet_id, date_of_visit) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- Insert new owners and emails-- 
insert into owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';

ALTER TABLE owners ALTER COLUMN age INT NOT NULL;