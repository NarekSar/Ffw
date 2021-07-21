-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : mer. 21 juil. 2021 à 23:59
-- Version du serveur :  10.4.18-MariaDB
-- Version de PHP : 8.0.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `ffw`
--

-- --------------------------------------------------------

--
-- Structure de la table `players`
--

CREATE TABLE `players` (
  `identifier` varchar(60) NOT NULL,
  `group` varchar(8) DEFAULT 'user',
  `vip` tinyint(1) NOT NULL DEFAULT 0,
  `name` varchar(41) DEFAULT NULL,
  `jobGrade` int(11) DEFAULT NULL,
  `jobName` varchar(30) DEFAULT NULL,
  `account` varchar(255) DEFAULT NULL,
  `inventory` longtext DEFAULT NULL,
  `clothe` longtext DEFAULT NULL,
  `coords` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `players`
--

INSERT INTO `players` (`identifier`, `group`, `vip`, `name`, `jobGrade`, `jobName`, `account`, `inventory`, `clothe`, `coords`) VALUES
('3b2fee7e9c7169d893241dded5753d8d6ddd0e1a', 'user', 0, NULL, 0, NULL, '{\"money\":2500,\"bank\":7500,\"black\":0}', '{\"ntm\":{\"count\":3,\"name\":\"ntm\",\"label\":\"Ntm\"}}', NULL, '{\"z\":144.6336669921875,\"y\":458.17584228515627,\"x\":654.10546875,\"h\":204.09449768066407}');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `players`
--
ALTER TABLE `players`
  ADD PRIMARY KEY (`identifier`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
