-- Forward Engineering code (to create empty database)
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- Schema art_gallery
CREATE SCHEMA IF NOT EXISTS `art_gallery` DEFAULT CHARACTER SET utf8 ;
USE `art_gallery` ;

-- Table `artist`
CREATE TABLE IF NOT EXISTS `artist` (
  `artist_id` INT NOT NULL,
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  PRIMARY KEY (`artist_id`))
ENGINE = InnoDB;

-- Table `artwork`
CREATE TABLE IF NOT EXISTS `artwork` (
  `artwork_id` INT NOT NULL,
  `title` VARCHAR(100) NULL,
  `year_created` INT NULL,
  `artist_id` INT NOT NULL,
  PRIMARY KEY (`artwork_id`),
  INDEX `fk_artwork_artist_idx` (`artist_id` ASC) VISIBLE,
  CONSTRAINT `fk_artwork_artist`
    FOREIGN KEY (`artist_id`)
    REFERENCES `artist` (`artist_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- Table `keyword`
CREATE TABLE IF NOT EXISTS `keyword` (
  `keyword_id` INT NOT NULL,
  `keyword_name` VARCHAR(45) NULL,
  PRIMARY KEY (`keyword_id`))
ENGINE = InnoDB;

-- Table `artwork_keyword` (linking table)
CREATE TABLE IF NOT EXISTS `artwork_keyword` (
  `artwork_id` INT NOT NULL,
  `keyword_id` INT NOT NULL,
  PRIMARY KEY (`artwork_id`, `keyword_id`),
  INDEX `fk_artwork_keyword_keyword1_idx` (`keyword_id` ASC) VISIBLE,
  CONSTRAINT `fk_artwork_keyword_artwork1`
    FOREIGN KEY (`artwork_id`)
    REFERENCES `artwork` (`artwork_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_artwork_keyword_keyword1`
    FOREIGN KEY (`keyword_id`)
    REFERENCES `keyword` (`keyword_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- Insert data into artist table
INSERT INTO `artist` (`artist_id`, `first_name`, `last_name`) VALUES 
(1, 'Vincent', 'van Gogh'),
(2, 'Pablo', 'Picasso'),
(3, 'Claude', 'Monet');

-- Insert data into artwork table
INSERT INTO `artwork` (`artwork_id`, `title`, `year_created`, `artist_id`) VALUES 
(1, 'Starry Night', 1889, 1),
(2, 'Sunflowers', 1888, 1),
(3, 'Guernica', 1937, 2),
(4, 'Water Lilies', 1919, 3);

-- Insert data into keyword table
INSERT INTO `keyword` (`keyword_id`, `keyword_name`) VALUES 
(1, 'Impressionism'),
(2, 'Post-Impressionism'),
(3, 'Cubism'),
(4, 'Landscape'),
(5, 'War');

-- Insert data into artwork_keyword linking table
INSERT INTO `artwork_keyword` (`artwork_id`, `keyword_id`) VALUES 
(1, 2),
(1, 4),
(2, 2),
(3, 3),
(3, 5),
(4, 1),
(4, 4);