DROP DATABASE forms_workshop;
CREATE DATABASE forms_workshop ENCODING UTF8;
\c forms_workshop
CREATE EXTENSION postgis;
CREATE SCHEMA water;

CREATE TABLE water.pipe (id serial PRIMARY KEY, geom geometry(LINESTRING, 3844));
INSERT INTO water.pipe (geom) VALUES (ST_GeomFromText('LINESTRING(450300  400520, 450320 400750)', 3844));

ALTER TABLE water.pipe ADD COLUMN year smallint;
-- ALTER TABLE water.pipe ALTER COLUMN year SET NOT NULL;
-- ALTER TABLE water.pipe ADD CONSTRAINT year_check CHECK (year <= EXTRACT(YEAR FROM NOW()));

ALTER TABLE water.pipe DROP COLUMN year;
ALTER TABLE water.pipe ADD COLUMN year smallint CHECK (year IS NULL OR (year >= 1950 AND year <= EXTRACT(YEAR FROM NOW())));
COMMENT ON COLUMN water.pipe.year IS 'Represents the year when the pipe has been installed.';


-- Create the schema that will hold the dictionaries
CREATE SCHEMA dictionary;

CREATE TABLE dictionary.pipe_function (
	    id integer NOT NULL PRIMARY KEY,
	    vl_active boolean DEFAULT true,
	    value_ro character varying(40) UNIQUE
);

INSERT INTO dictionary.pipe_function (id, vl_active, value_ro) VALUES (101, true, 'alta');
INSERT INTO dictionary.pipe_function (id, vl_active, value_ro) VALUES (102, true, 'necunoscută');
INSERT INTO dictionary.pipe_function (id, vl_active, value_ro) VALUES (103, true, 'de determinat');
INSERT INTO dictionary.pipe_function (id, vl_active, value_ro) VALUES (4103, true, 'Conductă de golire');
INSERT INTO dictionary.pipe_function (id, vl_active, value_ro) VALUES (4105, true, 'Conductă de distribuţie');
INSERT INTO dictionary.pipe_function (id, vl_active, value_ro) VALUES (4106, true, 'Branşament comun');
INSERT INTO dictionary.pipe_function (id, vl_active, value_ro) VALUES (4107, true, 'By-pass');
INSERT INTO dictionary.pipe_function (id, vl_active, value_ro) VALUES (4108, true, 'Branşament privat');
INSERT INTO dictionary.pipe_function (id, vl_active, value_ro) VALUES (4109, true, 'Conductă de înaltă presiune');
INSERT INTO dictionary.pipe_function (id, vl_active, value_ro) VALUES (4110, true, 'Captare dren');
INSERT INTO dictionary.pipe_function (id, vl_active, value_ro) VALUES (4111, true, 'Prea plin');
INSERT INTO dictionary.pipe_function (id, vl_active, value_ro) VALUES (4112, true, 'Aerisire');
INSERT INTO dictionary.pipe_function (id, vl_active, value_ro) VALUES (4101, true, 'Conductă de transport');
INSERT INTO dictionary.pipe_function (id, vl_active, value_ro) VALUES (4102, true, 'Conductă de hidrant');

