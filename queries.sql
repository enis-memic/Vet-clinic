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

-- Who was the last animal seen by William Tatcher? -- 

SELECT animals.name FROM animals INNER JOIN visits ON animals.id=visits.animals_id WHERE vets_id = '1' ORDER BY visits.date_of_visit DESC limit 1;

-- How many different animals did Stephanie Mendez see? --
SELECT COUNT(DISTINCT animals_id) FROM visits WHERE vets_id = '2';


-- List all vets and their specialties, including vets with no specialties.--
SELECT vets.name,species.name  
FROM vets
LEFT JOIN specializations
ON vets.id = specializations.vets_id
LEFT JOIN species
ON species.id = specializations.species_id
ORDER BY vets.id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.--
SELECT animals.name, visits.date_of_visit
FROM animals,vets,visits
WHERE vets.name = 'Stephanie Mendez'
AND vets.id = visits.vets_id
AND animals.id = visits.animals_id
AND visits.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30' 

-- What animal has the most visits to vets?-- 
SELECT animals.name,COUNT(animals_id)
 FROM animals INNER JOIN visits ON animals.id=visits.animals_id 
 GROUP BY animals.name 
 ORDER BY COUNT(animals_id)  DESC 
 limit 1;

-- Who was Maisy Smith's first visit?
SELECT animals.name, visits.date_of_visit 
FROM animals INNER JOIN visits ON animals.id=visits.animals_id
 ORDER BY visits.date_of_visit ASC 
 limit 1; 

-- Details for most recent visit: animal information, vet information, and date of visit.
 SELECT animals.name, animals.date_of_birth, animals.escape_attempts, animals.neutered, animals.weight_kg, species.name, vets.name, vets.age, vets.date_of_graduation, visits.date_of_visit
FROM animals, vets, visits, species
WHERE animals.id = visits.animals_id
AND animals.species_id = species.id
AND vets.id = visits.vets_id
ORDER BY visits.date_of_visit DESC
LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT vets.name, COUNT(visits.animals_id) 
FROM visits JOIN vets ON vets.id = visits.vets_id 
WHERE vets_id = '2' 
GROUP BY vets.name;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT species.name, COUNT(animals.species_id) 
FROM animals JOIN visits ON animals.id = visits.animals_id JOIN vets ON vets.id = visits.vets_id JOIN species ON species.id = animals.species_id
 WHERE vets.name = 'Maisy Smith' 
 GROUP BY species.name 
 ORDER BY COUNT(animals.species_id) DESC
 LIMIT 1;