/*
1      # Citation for general code structure was adapted from Activity 5
2      # Date: 05/07/2024
3      # Adapted from Activity 5 - SQL Queries of Multiple Tables (Joins)
4      # Source URL: https://canvas.oregonstate.edu/courses/1958399/pages/activity-5-sql-queries-of-multiple-tables-joins?module_item_id=24181829

1      # Citation for general code structure was adapted from the bsg_sample_data_manipulation_queries.sql file on the PRoject Step 3 Draft Version Assignment Page
2      # Date: 05/07/2024
3      # Adapted from Project Step 3 Draft Version Assignment Page - bsg_sample_data_manipulation_queries.sql
4      # Source URL: https://canvas.oregonstate.edu/courses/1958399/assignments/9589658
*/

-- Query for add a new character functionality with colon : character being used to 
-- denote the variables that will have data from the backend programming language

-- Get all Species IDs and Names to populate the Species dropdown
SELECT species_id, species_name FROM Species;

-- Get all GardenBed IDs and Names to populate the GardenBeds dropdown
SELECT garden_bed_id, garden_bed_name FROM GardenBeds;

-- Get all Amendment IDs and Types to populate the Amendments dropdown
SELECT amendment_id, amendment_type FROM Amendments;

-- Get all Plant IDs and Names to populate the Plants dropdown
SELECT plant_id, plant_name FROM Plants;

-- Species Queries
-- Add a new Species
INSERT INTO Species (species_name) VALUES (:species_name_Input);
-- Select and display Species from dropdown
SELECT species_id, species_name 
FROM Species 
WHERE species_id = :species_id_selected_from_dropdown;
-- Delete a Species
DELETE FROM Species WHERE species_id = :species_id_selected_from_table;

-- GardenBeds Queries
-- Add a new GardenBed
INSERT INTO GardenBeds (garden_bed_name, sun_level, square_feet, cardinal_direction) 
VALUES (:garden_bed_name_Input, :sun_level_from_dropdown_Input, :square_feet_Input, :cardinal_direction_from_dropdown_Input);
-- Select and display GardenBed from dropdown
SELECT garden_bed_id, garden_bed_name, sun_level, square_feet, cardinal_direction 
FROM GardenBeds
WHERE garden_bed_id = :garden_bed_id_selected_from_dropdown;
-- Delete a GardenBed
DELETE FROM GardenBeds WHERE garden_bed_id = :garden_bed_id_selected_from_table;
-- Update a GardenBed based on the Update GardenBed form
UPDATE GardenBeds 
SET garden_bed_name = :garden_bed_name_Input, sun_level = :sun_level_from_dropdown_Input, square_feet = :square_feet_Input, cardinal_direction = :cardinal_direction_from_dropdown_Input 
WHERE garden_bed_id = :garden_bed_id_selected_from_table;

-- Amendments Queries
-- Add a new Amendment
INSERT INTO Amendments (amendment_type, amendment_quantity, date_applied) 
VALUES (:amendment_type_Input, :amendment_quantity_Input, :date_applied_Input);
-- Select and display Amendment from dropdown
SELECT amendment_id, amendment_type, amendment_quantity, date_applied 
FROM Amendments 
WHERE amendment_id = :amendment_id_selected_from_dropdown;
-- Delete an Amendment
DELETE FROM Amendments WHERE amendment_id = :amendment_id_selected_from_table;
-- Update an Amendment based on the Update Amendment form
UPDATE Amendments
SET amendment_type = :amendment_type_Input, amendment_quantity = :amendment_quantity_Input, date_applied = :date_applied_Input
WHERE amendment_id = :amendment_id_selected_from_table

-- Plants Queries
-- Add a new Plant
INSERT INTO Plants (plant_name, date_planted, drought_resistant, garden_bed_id, species_id)
VALUES (:plant_name_Input, :date_planted_Input, :drought_resistant_selected_from_dropdown, :garden_bed_id_selected_from_dropdown, :species_id_selected_from_dropdown);
-- Select and display Plant from dropdown
SELECT plant_id, plant_name, date_planted, drought_resistant, garden_bed_id, species_id
FROM Plants
WHERE plant_id = :plant_id_selected_from_dropdown;
-- Delete a Plant
DELETE FROM Plants WHERE plant_id = :plant_id_selected_from_table;
-- Update a Plant based on the Update Plant form
UPDATE Plants
SET plant_name = :plant_name_Input, date_planted = :date_planted_Input, drought_resistant = :drought_resistant_selected_from_dropdown, garden_bed_id = :garden_bed_id_selected_from_dropdown, species_id = :species_id_selected_from_dropdown
WHERE plant_id = :plant_id_selected_from_table;
-- Select and display Plant information along with Species name and GardenBed details
SELECT Plants.plant_id, Plants.plant_name, Plants.date_planted, Plants.drought_resistant, Species.species_name, GardenBeds.sun_level, GardenBeds.square_feet, GardenBeds.cardinal_direction
FROM Plants
INNER JOIN Species ON Plants.species_id = Species.species_id
INNER JOIN GardenBeds ON Plants.garden_bed_id = GardenBeds.garden_bed_id
WHERE Plants.plant_id = :plant_id_selected_from_dropdown;

-- Harvests Queries
-- Add a new Harvest (associated plant_id dropdown will show plant names using the select statement)
INSERT INTO Harvests (plant_id, harvest_date, harvest_quantity)
VALUES (:plant_id, :harvest_date_Input, :harvest_quantity_Input);
-- Select and display Harvest from dropdown (use Plant dropdown for easier selection)
SELECT harvest_id,  harvest_date, harvest_quantity 
FROM Harvests 
WHERE plant_id = :plant_id_selected_from_dropdown;
-- Select and display detailed Harvest information
SELECT Harvests.harvest_id, Plants.plant_name, Species.species_name, Harvests.harvest_date, Harvests.harvest_quantity
FROM Harvests
INNER JOIN Plants ON Harvests.plant_id = Plants.plant_id
INNER JOIN Species ON Plants.species_id = Species.species_id
WHERE Harvests.plant_id = :plant_id_selected_from_dropdown;

-- GardenBedAmendments Queries
-- Add a new GardenBedAmendment (associated garden_bed_id and amendment_id dropdowns will show names using the select statements)
INSERT INTO GardenBedAmendments (garden_bed_id, amendment_id)
VALUES (:garden_bed_id, :amendment_id);
-- Select and display GardenBedAmendments from dropdown (can use either GardenBed dropdown or Amendment dropdown)
SELECT garden_bed_amendment_id, garden_bed_id, amendment_id
FROM GardenBedAmendments
WHERE garden_bed_id = :garden_bed_id_selected_from_dropdown
or amendment_id = :amendment_id_selected_from_dropdown;
-- Delete a GardenBedAmendment
DELETE FROM GardenBedAmendments 
WHERE garden_bed_amendment_id = :garden_bed_amendment_id_selected_from_table;
-- Update a GardenBedAmendment based on the Update GardenBedAmendment form
UPDATE GardenBedAmendments
SET garden_bed_id = :garden_bed_id_selected_from_dropdown, amendment_id = :amendment_id_selected_from_dropdown
WHERE garden_bed_amendment_id = :garden_bed_amendment_id_selected_from_table;