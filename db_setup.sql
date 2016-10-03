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

SET search_path = dictionary, pg_catalog;

CREATE TABLE pipe_function (
	    id integer NOT NULL PRIMARY KEY,
	    vl_active boolean DEFAULT true,
	    value_ro character varying(40) UNIQUE
);

INSERT INTO pipe_function (id, vl_active, value_ro) VALUES (101, true, 'alta');
INSERT INTO pipe_function (id, vl_active, value_ro) VALUES (102, true, 'necunoscută');
INSERT INTO pipe_function (id, vl_active, value_ro) VALUES (103, true, 'de determinat');
INSERT INTO pipe_function (id, vl_active, value_ro) VALUES (4103, true, 'Conductă de golire');
INSERT INTO pipe_function (id, vl_active, value_ro) VALUES (4105, true, 'Conductă de distribuţie');
INSERT INTO pipe_function (id, vl_active, value_ro) VALUES (4106, true, 'Branşament comun');
INSERT INTO pipe_function (id, vl_active, value_ro) VALUES (4107, true, 'By-pass');
INSERT INTO pipe_function (id, vl_active, value_ro) VALUES (4108, true, 'Branşament privat');
INSERT INTO pipe_function (id, vl_active, value_ro) VALUES (4109, true, 'Conductă de înaltă presiune');
INSERT INTO pipe_function (id, vl_active, value_ro) VALUES (4110, true, 'Captare dren');
INSERT INTO pipe_function (id, vl_active, value_ro) VALUES (4111, true, 'Prea plin');
INSERT INTO pipe_function (id, vl_active, value_ro) VALUES (4112, true, 'Aerisire');
INSERT INTO pipe_function (id, vl_active, value_ro) VALUES (4101, true, 'Conductă de transport');
INSERT INTO pipe_function (id, vl_active, value_ro) VALUES (4102, true, 'Conductă de hidrant');


CREATE TABLE status (
	    id integer NOT NULL PRIMARY KEY,
	    vl_active boolean DEFAULT true,
	    value_ro character varying(40),
	    description_ro text
);


INSERT INTO status (id, vl_active, value_ro, description_ro) VALUES (101, true, 'alta', NULL);
INSERT INTO status (id, vl_active, value_ro, description_ro) VALUES (102, true, 'necunoscută', NULL);
INSERT INTO status (id, vl_active, value_ro, description_ro) VALUES (103, true, 'de determinat', NULL);
INSERT INTO status (id, vl_active, value_ro, description_ro) VALUES (1307, true, 'Fictiv', 'Obiectul este fictiv dar este necesar pentru integritatea topologică.');
INSERT INTO status (id, vl_active, value_ro, description_ro) VALUES (1303, true, 'Dezafectat', 'Punerea în stare dezafectată este semi definitivă iar repunerea în stare funcţională ar necesita operaţiuni speciale. Spre exemplu, o sursă necaptată este considerată ca dezafectată. Sau mai mult, o conductă care nu este racordată dar a cărei stare e utilizabilă.');
INSERT INTO status (id, vl_active, value_ro, description_ro) VALUES (1305, true, 'Distrus', 'Obiectul este distrus complet sau parţial');
INSERT INTO status (id, vl_active, value_ro, description_ro) VALUES (1302, true, 'Nefuncţional', 'Nu contribuie efectiv la reţea, dar poate fi repusă în stare funcţională fară operaţiuni speciale. Starea nefuncţională este considerată ca una temporară. De exemplu, putem avea o sursă care a fost pusă în stare nefuncţională datorită unor probleme de calitate.');
INSERT INTO status (id, vl_active, value_ro, description_ro) VALUES (1301, true, 'Funcţional', 'Contribuie efectiv la reţea.');
INSERT INTO status (id, vl_active, value_ro, description_ro) VALUES (1304, true, 'Abandonat', 'Obiectul este abandonat iar scoaterea din funcţiune este strict definitivă. Spre exemplu, putem avea o conductă neracordată și improprie transportului de apă dar care poate fi eventual folosită ca mediu protector pentru alte conducte sau pt. cabluri. Alt exemplu este o statie de pompare fară nici o pompă  în stare funcţională.');
INSERT INTO status (id, vl_active, value_ro, description_ro) VALUES (1306, true, 'Proiect', 'Obiectul face parte dintr-un proiect care se va face sau în curs de realizare. ');

