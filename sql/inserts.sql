USE SpaceColonizationDB;

-- Sample data for Astronaut table
INSERT INTO Astronaut (First_Name, Last_Name, Date_of_Birth) VALUES
('Mayon', 'Doe', '1990-05-15'),
('Heathers', 'Smith', '1988-08-22'),
('Xenon', 'Johnson', '1992-03-10');

-- Sample data for Mission_Type table
INSERT INTO Mission_Type (mission_type_code, code_name, description) VALUES
('M1', 'Moon Mission', 'Exploration of the lunar surface'),
('M2', 'Mars Mission', 'Mission to explore and study Mars'),
('M3', 'Space Station', 'Construction and maintenance of a space station');

-- Sample data for Mission table
INSERT INTO Mission (Mission_Name, Description, Start_Date, End_Date, mission_type_code) VALUES
('Apollo 11', 'First manned mission to the Moon', '1969-07-16', '1969-07-24', 'M1'),
('Mars Rover', 'Exploration of Mars using rovers', '2022-01-01', '2022-12-31', 'M2'),
('Space Station Gamma', 'Establishing the first space station', '2023-01-01', '2024-01-01', 'M3');

-- Sample data for Astronaut_Missions table
INSERT INTO Astronaut_Missions (Astronaut_ID, Mission_ID) VALUES
(1, 1),
(2, 1),
(3, 2),
(1, 3);

-- Sample data for Component table
INSERT INTO Component (Component_Name) VALUES
('Oxygen Tank'),
('Navigation System'),
('Communication Module');

-- Sample data for Astronaut_Suit table
INSERT INTO Astronaut_Suit (Suit_Codename, Status, Composition, State, Mission_ID_Suit, Component_ID) VALUES
('Alpha001', 'Active', 'Polyester', 'Good', 1, 1),
('Beta002', 'Inactive', 'Nylon', 'Needs Repair', 2, 2),
('Gamma003', 'In Use', 'Polyester-Nylon Blend', 'Good', 3, 3);

-- Sample data for Colony_Admin table
INSERT INTO Colony_Admin (Name) VALUES
('Weathers'),
('Konen'),
('Voident');

-- Sample data for Decommissioned_By table
INSERT INTO Decommissioned_By (Admin_ID1, Admin_ID2) VALUES
(1, 2),
(2, 3),
(3, 1);

-- Sample data for Colony_Admin_Mission table
INSERT INTO Colony_Admin_Mission (colony_admin_id, mission_id_colony) VALUES
(1, 1),
(2, 2),
(3, 3);

-- Sample data for Planet_Seasons table
INSERT INTO Planet_Seasons (season_name) VALUES
('Spring'),
('Summer'),
('Autumn'),
('Winter');

-- Sample data for Sustainability_Report table
INSERT INTO Sustainability_Report (timestamp, author_first_name, author_last_name, code_name, target_carbon, actual_carbon, season_id) VALUES
('2023-01-01 12:00:00', 'Mayon', 'Doe', 'Report 1', 500.0, 450.0, 1),
('2023-02-01 14:30:00', 'Heathers', 'Smith', 'Report 2', 600.0, 580.0, 2),
('2023-03-01 10:45:00', 'Xenon', 'Johnson', 'Report 3', 700.0, 680.0, 3);

-- Sample data for Mission_Report table
INSERT INTO Mission_Report (mission_id_report, report_id) VALUES
(1, 1),
(2, 2),
(3, 3);

-- Sample data for Resource_Manager table
INSERT INTO Resource_Manager (resource_status, resource_description) VALUES
('Available', 'Oxygen Tanks'),
('In Use', 'Communication Modules'),
('Under Maintenance', 'Navigation Systems');

-- Sample data for Resource_Category table
INSERT INTO Resource_Category (category_name, description, resource_manager_id) VALUES
('Life Support', 'Resources related to astronaut life support systems', 1),
('Communication', 'Resources related to communication systems', 2),
('Navigation', 'Resources related to navigation systems', 3);

-- Sample data for Resource_Subcategory table
INSERT INTO Resource_Subcategory (subcategory_name, description, resource_category_id) VALUES
('Oxygen Tanks', 'Individual tanks providing oxygen supply', 1),
('Radio Transmitters', 'Devices for communication with ground control', 2),
('GPS Modules', 'Navigation modules for spacecraft', 3);

-- Sample data for ResourceManager_Mission table
INSERT INTO ResourceManager_Mission (resource_manager_id1, mission_id_manager) VALUES
(1, 1),
(2, 2),
(3, 3);

-- Sample data for Colony_Scientist table
INSERT INTO Colony_Scientist (first_name, last_name, email) VALUES
('Griffin', 'Axois', 'gaxois@gmail.com'),
('Justice', 'Weathers', 'jweathers@gmail.com'),
('Kith', 'Rengon', 'Krengon@gmail.com');

-- Sample data for Milestones table
INSERT INTO Milestones (date, description, mission_id_milestone1) VALUES
('2023-01-15', 'Spacecraft launch', 1),
('2023-03-01', 'Mars Rover landing', 2),
('2023-05-01', 'Space Station module installation', 3);

-- Sample data for Milestones_Colony_Scientist table
INSERT INTO Milestones_Colony_Scientist (milestone_id, scientist_id) VALUES
(1, 1),
(2, 2),
(3, 3);

-- Sample data for Medical_History table
INSERT INTO Medical_History (astronaut_id_medical, medical_condition) VALUES
(1, 'Headache'),
(2, 'Broken Arm'),
(3, 'Respiratory Infection');

-- Sample data for Vital_Sign_Reading table
INSERT INTO Vital_Sign_Reading (medical_history_id, reading_type, reading_date) VALUES
(1, 'Heart Rate', '2023-01-01'),
(2, 'Temperature', '2023-02-01'),
(3, 'Blood Pressure', '2023-03-01');

-- Sample data for Medical_Operator table
INSERT INTO Medical_Operator (first_name, last_name) VALUES
('John', 'Obuons'),
('Uneon', 'Star'),
('Steff', 'Badgers');

-- Sample data for Medical_Operator_Vital_Sign_Reading table
INSERT INTO Medical_Operator_Vital_Sign_Reading (operator_id, reading_id, can_measure_vitals) VALUES
(1, 1, 1),
(2, 2, 0),
(3, 3, 1);

-- Sample data for Medical_Operator_Astronaut table
INSERT INTO Medical_Operator_Astronaut (operator_id, astronaut_id, can_edit_vitals) VALUES
(1, 1, 1),
(2, 2, 0),
(3, 3, 1);

-- Sample data for Mission_Base table
INSERT INTO Mission_Base (base_name) VALUES
('Gamma101'),
('Beta808'),
('Alpha606');

-- Sample data for Mission_Colony table
INSERT INTO Mission_Colony (base_id, colony_type) VALUES
(1, 'Lunar'),
(2, 'Martian'),
(3, 'Space Station');

-- Sample data for Space_Colony table
INSERT INTO Space_Colony (base_id, colony_capacity) VALUES
(1, 100),
(2, 50),
(3, 200);

-- Sample data for Spacecraft table
INSERT INTO Spacecraft (craft_type, flight_time, resource_manager_id, mission_id) VALUES
('Rover', 365, 2, 2),
('Spaceship', 730, 1, 1),
('Space Shuttle', 365, 3, 3);

-- Sample data for Power table
INSERT INTO Power (power_percentage, reading_date, mission_id) VALUES
(80.0, '2023-01-01', 1),
(70.0, '2023-02-01', 2),
(90.0, '2023-03-01', 3);

-- Sample data for Health_Data table
INSERT INTO Health_Data (astronaut_id, data_type, reading_date) VALUES
(1, 'Weight', '2023-01-01'),
(2, 'Height', '2023-02-01'),
(3, 'BMI', '2023-03-01');

-- Sample data for Environmental_Impact table
INSERT INTO Environmental_Impact (mission_id, impact_type, description) VALUES
(1, 'Carbon Emission', 'Moderate impact on carbon emissions'),
(2, 'Terrain Disturbance', 'Low impact on Martian terrain'),
(3, 'Space Debris', 'Minimal impact on space environment');

-- Sample data for Research_Discovery table
INSERT INTO Research_Discovery (discovery_description) VALUES
('New species of microorganisms found on Mars'),
('Analysis of lunar soil composition reveals valuable minerals'),
('Discovery of a new exoplanet in a nearby star system');

-- Sample data for Colony_Scientist_Research_Discovery table
INSERT INTO Colony_Scientist_Research_Discovery (scientist_id, discovery_id) VALUES
(1, 1),
(2, 2),
(3, 3);
