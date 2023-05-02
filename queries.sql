/*Queries that provide answers to the questions from all projects.*/

SELECT name FROM animals WHERE name LIKE '%mon';
SELECT name,date_of_birth FROM animals WHERE date_of_birth BETWEEN '2016-01-01' and '2019-01-01';
SELECT name,neutered FROM animals WHERE neutered=TRUE AND escape_attempts < 3 ;
SELECT date_of_birth FROM animals WHERE name='Agumon' OR name='Pikachu' ;
SELECT name,escape_attempts FROM animals WHERE weight_kg > 10.5 ;
SELECT * FROM animals WHERE neutered = TRUE;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3 ;

-- Inside a transaction update the animals table by setting the species column to unspecified. Verify that change was made. 
-- Then roll back the change and verify that the species columns went back to the state before the transaction.
BEGIN;

UPDATE animals
SET species = NULL;

SELECT * FROM animals;

ROLLBACK;

-- transaction:
--     Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
--     Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
--     Commit the transaction.

BEGIN;

UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';

UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;

COMMIT;

-- Deleting all and rollback -- 
BEGIN;
DELETE FROM animals;
ROLLBACK; 

--     Delete all animals born after Jan 1st, 2022.
--     Create a savepoint for the transaction.
--     Update all animals' weight to be their weight multiplied by -1.
--     Rollback to the savepoint
--     Update all animals' weights that are negative to be their weight multiplied by -1.
--     Commit transaction
BEGIN;

DELETE FROM animals WHERE date_of_birth > '2022-01-01';

SAVEPOINT SAVEPOINT1;

UPDATE animals
SET weight_kg = weight_kg * -1;

ROLLBACK to SAVEPOINT SAVEPOINT1;

UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;

COMMIT;

--How many animals are there?--
SELECT COUNT(*) AS total_number FROM animals;

--How many animals have never tried to escape?--
SELECT COUNT(*) AS never_escaped FROM animals WHERE escape_attempts=0;

--What is the average weight of animals?--
SELECT CAST(AVG(weight_kg) AS DECIMAL(5,2))  AS avg_weight FROM animals;

--Who escapes the most, neutered or not neutered animals?--
SELECT name, MAX(escape_attempts) AS escapes_attempts FROM animals WHERE neutered = true OR neutered=false GROUP BY name ORDER BY MAX(escape_attempts) DESC ;

--What is the minimum and maximum weight of each type of animal?--
SELECT MAX(weight_kg) AS max_weight, MIN(weight_kg) AS min_weight FROM animals; 

--What is the average number of escape attempts per animal type of those born between 1990 and 2000?--
SELECT CAST(AVG(escape_attempts) AS DECIMAL(5,2)) AS average_escapes FROM animals WHERE extract(YEAR FROM date_of_birth) BETWEEN 1990 AND 2000;


-- What animals belong to Melody Pond?
SELECT animals.name FROM animals JOIN owners ON animals.owner_id = owners.id where owners.full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT animals.name FROM animals JOIN species ON animals.species_id = species.id where species.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT owners.full_name, animals.name from owners FULL JOIN animals ON animals.owner_id = owners.id;

-- How many animals are there per species?
SELECT species.name, COUNT(*) FROM animals JOIN species ON animals.species_id = species.id GROUP BY  species.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT animals.name FROM animals JOIN species ON animals.species_id = species.id JOIN owners ON owners.id = animals.owner_id 
WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT animals.name FROM animals JOIN owners ON animals.owner_id = owners.id 
WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;


-- Who owns the most animals?
SELECT owners.full_name AS name, COUNT(*) AS animal_count 
FROM animals JOIN owners ON animals.owner_id = owners.id
GROUP BY  owners.full_name ORDER BY animal_count DESC LIMIT 1;