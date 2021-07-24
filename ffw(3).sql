-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : sam. 24 juil. 2021 à 19:51
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
-- Structure de la table `items`
--

CREATE TABLE `items` (
  `label` varchar(31) DEFAULT NULL,
  `name` varchar(31) NOT NULL,
  `type` varchar(10) DEFAULT NULL,
  `limite` int(11) NOT NULL,
  `inLtd` tinyint(1) NOT NULL DEFAULT 0,
  `price` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `items`
--

INSERT INTO `items` (`label`, `name`, `type`, `limite`, `inLtd`, `price`) VALUES
('Pain', 'pain', 'food', 15, 1, 10);

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
('3b2fee7e9c7169d893241dded5753d8d6ddd0e1a', 'owner', 0, NULL, 0, NULL, '{\"money\":2500,\"bank\":7500,\"black\":0}', '{\"ntm\":{\"count\":3,\"name\":\"ntm\",\"label\":\"Ntm\"}}', NULL, '{\"y\":456.22418212890627,\"z\":144.6336669921875,\"h\":229.60629272460938,\"x\":652.6945190429688}');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`name`);

--
-- Index pour la table `players`
--
ALTER TABLE `players`
  ADD PRIMARY KEY (`identifier`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
