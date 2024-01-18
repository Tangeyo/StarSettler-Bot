-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema SpaceColonizationDB
-- -----------------------------------------------------
DROP DATABASE IF EXISTS SpaceColonizationDB;
CREATE DATABASE SpaceColonizationDB;
USE SpaceColonizationDB;
-- -----------------------------------------------------
-- Table `Astronaut`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Astronaut` ;

CREATE TABLE IF NOT EXISTS `Astronaut` (
  `Astronaut_ID` INT NOT NULL AUTO_INCREMENT,
  `First_Name` VARCHAR(50) NOT NULL,
  `Last_Name` VARCHAR(50) NOT NULL,
  `Date_of_Birth` DATE NULL,
  PRIMARY KEY (`Astronaut_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Mission_Type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Mission_Type` ;

CREATE TABLE IF NOT EXISTS `Mission_Type` (
  `mission_type_code` VARCHAR(10) NOT NULL,
  `code_name` VARCHAR(255) NULL,
  `description` TEXT NOT NULL,
  PRIMARY KEY (`mission_type_code`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Mission`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Mission` ;

CREATE TABLE IF NOT EXISTS `Mission` (
  `Mission_ID` INT NOT NULL AUTO_INCREMENT,
  `Mission_Name` VARCHAR(100) NOT NULL,
  `Description` TEXT NULL,
  `Start_Date` DATE NULL,
  `End_Date` DATE NULL,
  `mission_type_code` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`Mission_ID`),
  INDEX `mission_type_code_idx` (`mission_type_code` ASC) VISIBLE,
  CONSTRAINT `mission_type_code`
    FOREIGN KEY (`mission_type_code`)
    REFERENCES `Mission_Type` (`mission_type_code`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Astronaut_Missions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Astronaut_Missions` ;

CREATE TABLE IF NOT EXISTS `Astronaut_Missions` (
  `Astronaut_ID` INT NOT NULL,
  `Mission_ID` INT NOT NULL,
  INDEX `Astronaut_ID_idx` (`Astronaut_ID` ASC) VISIBLE,
  INDEX `Mission_ID_idx` (`Mission_ID` ASC) VISIBLE,
  PRIMARY KEY (`Astronaut_ID`, `Mission_ID`),
  CONSTRAINT `Astronaut_ID`
    FOREIGN KEY (`Astronaut_ID`)
    REFERENCES `Astronaut` (`Astronaut_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Mission_ID`
    FOREIGN KEY (`Mission_ID`)
    REFERENCES `Mission` (`Mission_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Component`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Component` ;

CREATE TABLE IF NOT EXISTS `Component` (
  `Component_ID` INT NOT NULL AUTO_INCREMENT,
  `Component_Name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`Component_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Astronaut_Suit`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Astronaut_Suit` ;

CREATE TABLE IF NOT EXISTS `Astronaut_Suit` (
  `Suit_ID` INT NOT NULL AUTO_INCREMENT,
  `Suit_Codename` VARCHAR(50) NULL,
  `Status` ENUM('Active', 'Inactive', 'In Use', 'In Maintenance', 'Retired') NULL,
  `Composition` VARCHAR(100) NULL,
  `State` ENUM('Good', 'Needs Repair') NULL,
  `Mission_ID_Suit` INT NULL,
  `Component_ID` INT NULL,
  PRIMARY KEY (`Suit_ID`),
  INDEX `Mission_ID_idx` (`Mission_ID_Suit` ASC) VISIBLE,
  INDEX `Component_ID_idx` (`Component_ID` ASC) VISIBLE,
  CONSTRAINT `Mission_ID_Suit2`
    FOREIGN KEY (`Mission_ID_Suit`)
    REFERENCES `Mission` (`Mission_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Component_ID`
    FOREIGN KEY (`Component_ID`)
    REFERENCES `Component` (`Component_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Colony_Admin`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Colony_Admin` ;

CREATE TABLE IF NOT EXISTS `Colony_Admin` (
  `Admin_ID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`Admin_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Decommissioned_By`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Decommissioned_By` ;

CREATE TABLE IF NOT EXISTS `Decommissioned_By` (
  `Admin_ID1` INT NOT NULL,
  `Admin_ID2` INT NOT NULL,
  PRIMARY KEY (`Admin_ID1`, `Admin_ID2`),
  INDEX `Admin_ID2_idx` (`Admin_ID2` ASC) VISIBLE,
  CONSTRAINT `Admin_ID1`
    FOREIGN KEY (`Admin_ID1`)
    REFERENCES `Colony_Admin` (`Admin_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Admin_ID2`
    FOREIGN KEY (`Admin_ID2`)
    REFERENCES `Colony_Admin` (`Admin_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Colony_Admin_Mission`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Colony_Admin_Mission` ;

CREATE TABLE IF NOT EXISTS `Colony_Admin_Mission` (
  `idColony_Admin_Mission` INT NOT NULL AUTO_INCREMENT,
  `colony_admin_id` INT NOT NULL,
  `mission_id_colony` INT NOT NULL,
  PRIMARY KEY (`idColony_Admin_Mission`),
  INDEX `colony_admin_id_idx` (`colony_admin_id` ASC) VISIBLE,
  INDEX `mission_id_idx` (`mission_id_colony` ASC) VISIBLE,
  CONSTRAINT `colony_admin_id`
    FOREIGN KEY (`colony_admin_id`)
    REFERENCES `Colony_Admin` (`Admin_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `mission_id_colony2`
    FOREIGN KEY (`mission_id_colony`)
    REFERENCES `Mission` (`Mission_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Planet_Seasons`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Planet_Seasons` ;

CREATE TABLE IF NOT EXISTS `Planet_Seasons` (
  `season_id` INT NOT NULL AUTO_INCREMENT,
  `season_name` VARCHAR(20) NULL,
  PRIMARY KEY (`season_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Sustainability_Report`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Sustainability_Report` ;

CREATE TABLE IF NOT EXISTS `Sustainability_Report` (
  `susreport_id` INT NOT NULL AUTO_INCREMENT,
  `timestamp` TIMESTAMP NOT NULL,
  `author_first_name` VARCHAR(255) NOT NULL,
  `author_last_name` VARCHAR(255) NOT NULL,
  `code_name` VARCHAR(255) NOT NULL,
  `target_carbon` FLOAT NOT NULL,
  `actual_carbon` FLOAT NULL,
  `season_id` INT NULL,
  PRIMARY KEY (`susreport_id`),
  INDEX `season_id_idx` (`season_id` ASC) VISIBLE,
  CONSTRAINT `season_id_report`
    FOREIGN KEY (`season_id`)
    REFERENCES `Planet_Seasons` (`season_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Mission_Report`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Mission_Report` ;

CREATE TABLE IF NOT EXISTS `Mission_Report` (
  `mission_id_report` INT NOT NULL,
  `report_id` INT NOT NULL,
  INDEX `mission_id_idx` (`mission_id_report` ASC) VISIBLE,
  INDEX `report_id_idx` (`report_id` ASC) VISIBLE,
  PRIMARY KEY (`mission_id_report`, `report_id`),
  CONSTRAINT `mission_id_report2`
    FOREIGN KEY (`mission_id_report`)
    REFERENCES `Mission` (`Mission_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `report_id`
    FOREIGN KEY (`report_id`)
    REFERENCES `Sustainability_Report` (`susreport_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Resource_Manager`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Resource_Manager` ;

CREATE TABLE IF NOT EXISTS `Resource_Manager` (
  `resource_manager_id` INT NOT NULL AUTO_INCREMENT,
  `resource_status` VARCHAR(10) NOT NULL,
  `resource_description` TEXT NULL,
  PRIMARY KEY (`resource_manager_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Resource_Category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Resource_Category` ;

CREATE TABLE IF NOT EXISTS `Resource_Category` (
  `resource_category_id` INT NOT NULL AUTO_INCREMENT,
  `category_name` VARCHAR(45) NOT NULL,
  `description` TEXT NULL,
  `resource_manager_id` INT NULL,
  PRIMARY KEY (`resource_category_id`),
  INDEX `resource_manager_id_idx` (`resource_manager_id` ASC) VISIBLE,
  CONSTRAINT `resource_manager_id`
    FOREIGN KEY (`resource_manager_id`)
    REFERENCES `Resource_Manager` (`resource_manager_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Resource_Subcategory`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Resource_Subcategory` ;

CREATE TABLE IF NOT EXISTS `Resource_Subcategory` (
  `resource_subcategory_id` INT NOT NULL AUTO_INCREMENT,
  `subcategory_name` VARCHAR(45) NOT NULL,
  `description` TEXT NULL,
  `resource_category_id` INT NULL,
  PRIMARY KEY (`resource_subcategory_id`),
  INDEX `resource_category_id_idx` (`resource_category_id` ASC) VISIBLE,
  CONSTRAINT `resource_category_id_sub`
    FOREIGN KEY (`resource_category_id`)
    REFERENCES `Resource_Category` (`resource_category_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ResourceManager_Mission`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ResourceManager_Mission` ;

CREATE TABLE IF NOT EXISTS `ResourceManager_Mission` (
  `resource_manager_id1` INT NOT NULL,
  `mission_id_manager` INT NOT NULL,
  PRIMARY KEY (`resource_manager_id1`, `mission_id_manager`),
  INDEX `mission_id_idx` (`mission_id_manager` ASC) VISIBLE,
  CONSTRAINT `resource_manager_id2`
    FOREIGN KEY (`resource_manager_id1`)
    REFERENCES `Resource_Manager` (`resource_manager_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `mission_id_manager2`
    FOREIGN KEY (`mission_id_manager`)
    REFERENCES `Mission` (`Mission_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Colony_Scientist`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Colony_Scientist` ;

CREATE TABLE IF NOT EXISTS `Colony_Scientist` (
  `scientist_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`scientist_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Milestones`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Milestones` ;

CREATE TABLE IF NOT EXISTS `Milestones` (
  `milestone_id` INT NOT NULL AUTO_INCREMENT,
  `date` DATE NOT NULL,
  `description` TEXT NULL,
  `mission_id_milestone1` INT NULL,
  PRIMARY KEY (`milestone_id`),
  INDEX `mission_id_idx` (`mission_id_milestone1` ASC) VISIBLE,
  CONSTRAINT `mission_id_milestone`
    FOREIGN KEY (`mission_id_milestone1`)
    REFERENCES `Mission` (`Mission_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Milestones_Colony_Scientist`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Milestones_Colony_Scientist` ;

CREATE TABLE IF NOT EXISTS `Milestones_Colony_Scientist` (
  `milestone_id` INT NOT NULL,
  `scientist_id` INT NOT NULL,
  PRIMARY KEY (`milestone_id`, `scientist_id`),
  INDEX `scientist_id_idx` (`scientist_id` ASC) VISIBLE,
  CONSTRAINT `milestone_id_scientist2`
    FOREIGN KEY (`milestone_id`)
    REFERENCES `Milestones` (`milestone_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `scientist_id_scientist2`
    FOREIGN KEY (`scientist_id`)
    REFERENCES `Colony_Scientist` (`scientist_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Medical_History`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Medical_History` ;

CREATE TABLE IF NOT EXISTS `Medical_History` (
  `history_id` INT NOT NULL AUTO_INCREMENT,
  `astronaut_id_medical` INT NULL,
  `medical_condition` VARCHAR(70) NOT NULL,
  PRIMARY KEY (`history_id`),
  INDEX `astronaut_id_idx` (`astronaut_id_medical` ASC) VISIBLE,
  CONSTRAINT `astronaut_id_FK`
    FOREIGN KEY (`astronaut_id_medical`)
    REFERENCES `Astronaut` (`Astronaut_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Vital_Sign_Reading`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Vital_Sign_Reading` ;

CREATE TABLE IF NOT EXISTS `Vital_Sign_Reading` (
  `reading_id` INT NOT NULL AUTO_INCREMENT,
  `medical_history_id` INT NULL,
  `reading_type` VARCHAR(75) NOT NULL,
  `reading_date` DATE NOT NULL,
  PRIMARY KEY (`reading_id`),
  INDEX `medical_history_id_idx` (`medical_history_id` ASC) VISIBLE,
  CONSTRAINT `medical_history_id`
    FOREIGN KEY (`medical_history_id`)
    REFERENCES `Medical_History` (`history_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Medical_Operator`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Medical_Operator` ;

CREATE TABLE IF NOT EXISTS `Medical_Operator` (
  `operator_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`operator_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Medical_Operator_Vital_Sign_Reading`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Medical_Operator_Vital_Sign_Reading` ;

CREATE TABLE IF NOT EXISTS `Medical_Operator_Vital_Sign_Reading` (
  `operator_id` INT NOT NULL,
  `reading_id` INT NOT NULL,
  `can_measure_vitals` TINYINT NOT NULL,
  PRIMARY KEY (`operator_id`, `reading_id`),
  INDEX `reading_id_idx` (`reading_id` ASC) VISIBLE,
  CONSTRAINT `operator_id_vital`
    FOREIGN KEY (`operator_id`)
    REFERENCES `Medical_Operator` (`operator_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `reading_id_vital`
    FOREIGN KEY (`reading_id`)
    REFERENCES `Vital_Sign_Reading` (`reading_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Medical_Operator_Astronaut`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Medical_Operator_Astronaut` ;

CREATE TABLE IF NOT EXISTS `Medical_Operator_Astronaut` (
  `operator_id` INT NOT NULL,
  `astronaut_id` INT NOT NULL,
  `can_edit_vitals` TINYINT NOT NULL,
  PRIMARY KEY (`operator_id`, `astronaut_id`),
  INDEX `astronaut_id_idx` (`astronaut_id` ASC) VISIBLE,
  CONSTRAINT `operator_id_FK2`
    FOREIGN KEY (`operator_id`)
    REFERENCES `Medical_Operator` (`operator_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `astronaut_id_FK2`
    FOREIGN KEY (`astronaut_id`)
    REFERENCES `Astronaut` (`Astronaut_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Mission_Base`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Mission_Base` ;

CREATE TABLE IF NOT EXISTS `Mission_Base` (
  `base_id` INT NOT NULL AUTO_INCREMENT,
  `base_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`base_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Mission_Colony`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Mission_Colony` ;

CREATE TABLE IF NOT EXISTS `Mission_Colony` (
  `base_id` INT NOT NULL,
  `colony_type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`base_id`),
  CONSTRAINT `base_id_Mission`
    FOREIGN KEY (`base_id`)
    REFERENCES `Mission_Base` (`base_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Space_Colony`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Space_Colony` ;

CREATE TABLE IF NOT EXISTS `Space_Colony` (
  `base_id` INT NOT NULL,
  `colony_capacity` INT NOT NULL,
  PRIMARY KEY (`base_id`),
  CONSTRAINT `base_id_Space`
    FOREIGN KEY (`base_id`)
    REFERENCES `Mission_Base` (`base_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spacecraft`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Spacecraft` ;

CREATE TABLE IF NOT EXISTS `Spacecraft` (
  `craft_id` INT NOT NULL AUTO_INCREMENT,
  `craft_type` VARCHAR(45) NOT NULL,
  `flight_time` INT NOT NULL,
  `resource_manager_id` INT NULL,
  `mission_id` INT NULL,
  PRIMARY KEY (`craft_id`),
  INDEX `resource_manager_id_idx` (`resource_manager_id` ASC) VISIBLE,
  INDEX `mission_id_idx` (`mission_id` ASC) VISIBLE,
  CONSTRAINT `resource_manager_id_Space`
    FOREIGN KEY (`resource_manager_id`)
    REFERENCES `Resource_Manager` (`resource_manager_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `mission_id_space`
    FOREIGN KEY (`mission_id`)
    REFERENCES `Mission` (`Mission_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Power`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Power` ;

CREATE TABLE IF NOT EXISTS `Power` (
  `power_id` INT NOT NULL AUTO_INCREMENT,
  `power_percentage` DECIMAL(5,2) NOT NULL,
  `reading_date` DATE NOT NULL,
  `mission_id` INT NULL,
  PRIMARY KEY (`power_id`),
  INDEX `mission_id_idx` (`mission_id` ASC) VISIBLE,
  CONSTRAINT `mission_id_power`
    FOREIGN KEY (`mission_id`)
    REFERENCES `Mission` (`Mission_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Health_Data`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Health_Data` ;

CREATE TABLE IF NOT EXISTS `Health_Data` (
  `data_id` INT NOT NULL AUTO_INCREMENT,
  `astronaut_id` INT NULL,
  `data_type` VARCHAR(45) NULL,
  `reading_date` DATE NULL,
  PRIMARY KEY (`data_id`),
  INDEX `astronaut_id_idx` (`astronaut_id` ASC) VISIBLE,
  CONSTRAINT `astronaut_id_health`
    FOREIGN KEY (`astronaut_id`)
    REFERENCES `Astronaut` (`Astronaut_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Environmental_Impact`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Environmental_Impact` ;

CREATE TABLE IF NOT EXISTS `Environmental_Impact` (
  `impact_id` INT NOT NULL AUTO_INCREMENT,
  `mission_id` INT NULL,
  `impact_type` VARCHAR(45) NULL,
  `description` TEXT NULL,
  PRIMARY KEY (`impact_id`),
  INDEX `mission_id_idx` (`mission_id` ASC) VISIBLE,
  CONSTRAINT `mission_id_enviro`
    FOREIGN KEY (`mission_id`)
    REFERENCES `Mission` (`Mission_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Research_Discovery`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Research_Discovery` ;

CREATE TABLE IF NOT EXISTS `Research_Discovery` (
  `discovery_id` INT NOT NULL AUTO_INCREMENT,
  `discovery_description` TEXT NULL,
  PRIMARY KEY (`discovery_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Colony_Scientist_Research_Discovery`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Colony_Scientist_Research_Discovery` ;

CREATE TABLE IF NOT EXISTS `Colony_Scientist_Research_Discovery` (
  `scientist_id` INT NOT NULL,
  `discovery_id` INT NOT NULL,
  PRIMARY KEY (`scientist_id`, `discovery_id`),
  INDEX `discovery_id_idx` (`discovery_id` ASC) VISIBLE,
  CONSTRAINT `scientist_id_researchdis`
    FOREIGN KEY (`scientist_id`)
    REFERENCES `Colony_Scientist` (`scientist_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `discovery_id_researchdis`
    FOREIGN KEY (`discovery_id`)
    REFERENCES `Research_Discovery` (`discovery_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
