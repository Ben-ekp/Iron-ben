use sakila;

-- Add the new films to the database. 

drop table if exists films_2020;
CREATE TABLE `films_2020` (
  `film_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` text,
  `release_year` year(4) DEFAULT NULL,
  `language_id` tinyint(3) unsigned NOT NULL,
  `original_language_id` tinyint(3) unsigned DEFAULT NULL,
  `rental_duration` char(6),
  `rental_rate` decimal(4,2),
  `length` smallint(5) unsigned DEFAULT NULL,
  `replacement_cost` decimal(5,2) DEFAULT NULL,
  `rating` enum('G','PG','PG-13','R','NC-17') DEFAULT NULL,
  PRIMARY KEY (`film_id`),
  CONSTRAINT FOREIGN KEY (`original_language_id`) REFERENCES `language` (`language_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1003 DEFAULT CHARSET=utf8;

select * from films_2020;

load data infile '/files_for_lab/films_2020.csv'
into table films_2020
fields terminated by ',';

show variables like 'local_infile';
set global local_infile = 1;

show variables like 'secure_file_priv';

set sql_safe_updates = 0;

load data infile 'C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\films_2020.csv'
into table films_2020
fields terminated by ',';

-- all above resulted in errors, I used Import wizard
drop table if exists films_2020;
CREATE TABLE `films_2020` (
  `film_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` text,
  `release_yeafilms_2020r` year(4) DEFAULT NULL,
  `language_id` tinyint(3) unsigned NOT NULL,
  `original_language_id` tinyint(3) unsigned DEFAULT NULL,
  `rental_duration` char(6),
  `rental_rate` char(10),
  `length` smallint(5) unsigned DEFAULT NULL,
  `replacement_cost` char(10) DEFAULT NULL,
  `rating` enum('G','PG','PG-13','R','NC-17') DEFAULT NULL,
  PRIMARY KEY (`film_id`),
  CONSTRAINT FOREIGN KEY (`original_language_id`) REFERENCES `language` (`language_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1003 DEFAULT CHARSET=utf8;

select * from films_2020;


-- Update information on rental_duration, rental_rate and replacement_cost. 

update films_2020 
set rental_duration = 3, rental_rate = 2.99, replacement_cost = 8.99
where release_year = 2020;

select * from films_2020;


