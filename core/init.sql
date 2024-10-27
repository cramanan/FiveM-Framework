-- --------------------------------------------------------
-- Hôte:                         localhost
-- Version du serveur:           11.5.2-MariaDB - mariadb.org binary distribution
-- SE du serveur:                Win64
-- HeidiSQL Version:             12.6.0.6765
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Listage de la structure de la base pour clawz_core
CREATE DATABASE IF NOT EXISTS `clawz_core` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `clawz_core`;

-- Listage de la structure de la table clawz_core. banking
CREATE TABLE IF NOT EXISTS `banking` (
  `steam_id` varchar(60) NOT NULL,
  `balance` int(11) NOT NULL DEFAULT 0,
  `wallet` int(11) NOT NULL DEFAULT 0,
  KEY `steam_id` (`steam_id`),
  CONSTRAINT `banking_ibfk_1` FOREIGN KEY (`steam_id`) REFERENCES `users` (`steam_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Les données exportées n'étaient pas sélectionnées.

-- Listage de la structure de la table clawz_core. spawn_record
CREATE TABLE IF NOT EXISTS `spawn_record` (
  `steam_id` varchar(60) NOT NULL,
  `x` float DEFAULT NULL,
  `y` float DEFAULT NULL,
  `z` float DEFAULT NULL,
  `model` varchar(50) DEFAULT 'player_zero',
  KEY `steam_id` (`steam_id`),
  CONSTRAINT `steam_id` FOREIGN KEY (`steam_id`) REFERENCES `users` (`steam_id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='This table holds players spawn informations such as coords and model.';

-- Les données exportées n'étaient pas sélectionnées.

-- Listage de la structure de la table clawz_core. users
CREATE TABLE IF NOT EXISTS `users` (
  `steam_id` varchar(60) NOT NULL,
  `name` varchar(60) NOT NULL,
  PRIMARY KEY (`steam_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Les données exportées n'étaient pas sélectionnées.

-- Listage de la structure de la table clawz_core. weapons_record
CREATE TABLE IF NOT EXISTS `weapons_record` (
  `steam_id` varchar(50) NOT NULL,
  `weapon` varchar(50) NOT NULL,
  KEY `steam_id` (`steam_id`),
  CONSTRAINT `weapons_record_ibfk_1` FOREIGN KEY (`steam_id`) REFERENCES `users` (`steam_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Les données exportées n'étaient pas sélectionnées.

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
