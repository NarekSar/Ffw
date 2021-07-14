-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : mer. 14 juil. 2021 à 18:26
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
  `account` varchar(255) DEFAULT NULL,
  `clothe` longtext DEFAULT NULL,
  `coords` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `players`
--

INSERT INTO `players` (`identifier`, `group`, `vip`, `name`, `account`, `clothe`, `coords`) VALUES
('3b2fee7e9c7169d893241dded5753d8d6ddd0e1a', 'user', 0, NULL, '{\"money\":2500,\"bank\":7500,\"black\":0}', NULL, '{\"y\":830.0703125,\"z\":182.12451171875,\"h\":11.338582038879395,\"x\":-1543.2659912109376}');

-- --------------------------------------------------------

--
-- Structure de la table `players_inv`
--

CREATE TABLE `players_inv` (
  `id` int(11) NOT NULL,
  `identifier` varchar(60) DEFAULT NULL,
  `item_label` varchar(60) DEFAULT NULL,
  `item_name` varchar(60) DEFAULT NULL,
  `item_count` int(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `players`
--
ALTER TABLE `players`
  ADD PRIMARY KEY (`identifier`);

--
-- Index pour la table `players_inv`
--
ALTER TABLE `players_inv`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `players_inv`
--
ALTER TABLE `players_inv`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
