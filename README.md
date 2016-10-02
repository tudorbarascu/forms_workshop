Forms Workshop
==============


Initiate database
-----------------

``psql -U postgres -f db_setup.sql``

Widgets
-------

- **year** column

 Represents the year when the pipe has been installed.
 The minimum year should be 1950 and the maximum year should
 be the current year.

 Database side constraint:

 ``CHECK (year IS NULL OR (year >= 1950 AND year <= EXTRACT(YEAR FROM NOW())));``

 QGIS Side constraint:

 ``"year" IS NULL OR (1950 <= "year" AND "year" <= now())``

 Description: ``Install year must be between 1950 and the current year.``

 Possible QGIS widgets:

 - Textedit 
 - Range (Editable, Slider, Dial)



