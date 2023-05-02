/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
   id INTEGER PRIMARY KEY,
	name VARCHAR ( 50 ) UNIQUE NOT NULL,
	date_of_birth DATE NOT NULL,
	escape_attempts INTEGER UNIQUE NOT NULL,
	neutered BOOLEAN NOT NULL,
    weight_kg BIGINT NOT NULL,
	 species VARCHAR(50)
);
