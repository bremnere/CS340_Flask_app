/* 
1      # Citation for the general code was initially adapted from exporting SQL file from PHP after inputting data into sql Workbench:
2      # Date: 05/02/2024
3      # Adapted from PHP/sql Workbench: 
4      # Source URL: https://www.phpmyadmin.net/downloads/
4      # Source URL:  https://dev.mysql.com/downloads/workbench/

1      # Citation for general cleaning up/organizing of code adapted from Activity 1 - Creating a Customer Object Table (Adding/ Creating Tables and Insertion of Data to table):
2      # Date: 05/02/2024
3      # Adapted from Activity 1 - Creating a Customer Object Table: :
4      # Source URL: https://canvas.oregonstate.edu/courses/1958399/pages/activity-1-creating-a-customer-object-table?module_item_id=24181817

1      # Citation for cascade/delete information:
2      # Date: 05/02/2024
3      # Adapted from Exploration: - MySQL Casade:
4      # Source URL: https://canvas.oregonstate.edu/courses/1958399/pages/exploration-mysql-cascade?module_item_id=24181838
*/

SET FOREIGN_KEY_CHECKS=0;
SET AUTOCOMMIT = 0;

-- Create Species Table
CREATE OR REPLACE TABLE `Species` (
    `species_id` int(11) NOT NULL AUTO_INCREMENT,
    `species_name` varchar(100) NOT NULL,
    PRIMARY KEY (`species_id`)
);

-- Create GardenBeds Table
CREATE OR REPLACE TABLE `GardenBeds` (
    `garden_bed_id` int(11) NOT NULL AUTO_INCREMENT,
    `garden_bed_name` varchar(100) NOT NULL,
    -- Most often will be Sun, Part-Sun, or Shade
    `sun_level` varchar(100) NOT NULL,
    `square_feet` int NOT NULL,
    -- Which direction the garden bed faces (North, South, East, West)
    `cardinal_direction` varchar(100) NOT NULL,
    PRIMARY KEY (`garden_bed_id`) 
);

-- Create Amendments Table
CREATE OR REPLACE TABLE `Amendments` (
    `amendment_id` int(11) NOT NULL AUTO_INCREMENT,
    -- additions to the soil to improve quality or to meet specific needs
    `amendment_type` varchar(145) NOT NULL,
    `amendment_quantity` decimal(6,2) NOT NULL,
    `date_applied` date NOT NULL,
    PRIMARY KEY (`amendment_id`)
);

-- Create Plants Table
CREATE OR REPLACE TABLE `Plants` (
    `plant_id` int(11) NOT NULL AUTO_INCREMENT,
    `plant_name` varchar(100) NOT NULL,
    `date_planted` date NOT NULL,
    -- Shows whether the plant is drought resistant or not, 1 is True, 0 is False
    `drought_resistant` tinyint(1) NOT NULL,
    `garden_bed_id` int(11),
    `species_id` int(11) NOT NULL,
    PRIMARY KEY (`plant_id`),
    FOREIGN KEY (`garden_bed_id`) REFERENCES `GardenBeds`(`garden_bed_id`)
    ON DELETE CASCADE,
    FOREIGN KEY (`species_id`) REFERENCES `Species`(`species_id`)
    ON DELETE CASCADE
);

-- Create Harvests Table
CREATE OR REPLACE TABLE `Harvests` (
    `harvest_id` int(11) NOT NULL AUTO_INCREMENT,
    `plant_id` int(11) NOT NULL,
    `harvest_date` date NOT NULL,
    -- Will be listed in pounds
    `harvest_quantity` decimal(6,2) NOT NULL,
    PRIMARY KEY (`harvest_id`),
    FOREIGN KEY (`plant_id`) REFERENCES `Plants`(`plant_id`)
    ON DELETE CASCADE
);

-- Intersection table for GardenBeds and Amendments

CREATE OR REPLACE TABLE `GardenBedAmendments` (
    `garden_bed_amendments_id` int(11) NOT NULL AUTO_INCREMENT,
    `garden_bed_id` int(11) NOT NULL,
    `amendment_id` int(11) NOT NULL,
    -- Will be listed in pounds
    PRIMARY KEY (`garden_bed_amendments_id`),
    FOREIGN KEY (`garden_bed_id`) REFERENCES `GardenBeds`(`garden_bed_id`)
    ON DELETE CASCADE,
    FOREIGN KEY (`amendment_id`) REFERENCES `Amendments` (`amendment_id`)
    ON DELETE CASCADE
);

-- Insert data into Species table
INSERT INTO `Species` (`species_name`) VALUES
('Tomato'),
('Corn'),
('Okra'),
('Sweet Pepper'),
('Sweet Potato');

-- Insert data into GardenBeds table
INSERT INTO `GardenBeds` (`sun_level`, `garden_bed_name`, `square_feet`, `cardinal_direction`) VALUES
('Part-Sun','Plot One', 24, 'West'),
('Shade', 'Plot Two', 20, 'North'),
('Sun', 'Plot Three', 30, 'East');


-- Insert data into Plants table
INSERT INTO `Plants` (`plant_name`, `date_planted`, `drought_resistant`, `garden_bed_id`, `species_id`) VALUES
('Roma', '2024-05-01', 0, 3, 1),
('Lunchbox', '2024-04-15', 1, 3, 4),
('Jewel', '2024-04-20', 0, 1, 2);

-- Insert data into Amendments table
INSERT INTO `Amendments` (`amendment_type`, `amendment_quantity`, `date_applied`) VALUES
('Mulch', 20, '2024-04-01'),
('Compost', 10.5, '2024-04-10'),
('Manure', 5, '2024-04-20');

-- Insert data into Harvests table
INSERT INTO `Harvests` (`plant_id`, `harvest_date`, `harvest_quantity`) VALUES
(1, '2023-07-25', 1.25),
(2, '2023-08-10', 0.2),
(2, '2023-08-30', 0.5);

-- Insert data into GardenBedAmendments table
INSERT INTO `GardenBedAmendments` (`garden_bed_id`, `amendment_id`) VALUES
(3, 2),
(3, 3),
(2, 2);

SET FOREIGN_KEY_CHECKS=1;
COMMIT;