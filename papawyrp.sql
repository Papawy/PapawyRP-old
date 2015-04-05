-- phpMyAdmin SQL Dump
-- version 3.4.11.1deb2+deb7u1
-- http://www.phpmyadmin.net
--
-- Client: localhost
-- Généré le: Dim 05 Avril 2015 à 19:23
-- Version du serveur: 5.5.41
-- Version de PHP: 5.4.36-0+deb7u3

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données: `papawyrp`
--

-- --------------------------------------------------------

--
-- Structure de la table `playersData`
--

CREATE TABLE IF NOT EXISTS `playersData` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL,
  `Pass` varchar(129) DEFAULT NULL,
  `IP` varchar(100) NOT NULL,
  `Email` varchar(255) DEFAULT NULL,
  `RegisterDate` int(11) NOT NULL,
  `AdminRank` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Contenu de la table `playersData`
--

INSERT INTO `playersData` (`ID`, `Name`, `Pass`, `IP`, `Email`, `RegisterDate`, `AdminRank`) VALUES
(1, 'PapawyPapawy', '7D73388F9B889B1E59642AEE8000765', '127.0.0.1', 'contact@papawy.com', 1426086595, 0),
(2, 'Papawy', 'EF0F6B678514EC4769359004DCBF261', '127.0.0.1', 'contact@papawy.com', 1426088368, 0);

-- --------------------------------------------------------

--
-- Structure de la table `serverData`
--

CREATE TABLE IF NOT EXISTS `serverData` (
  `GM_Id` int(11) NOT NULL,
  `GM_Name` varchar(100) DEFAULT NULL,
  `GM_Website` varchar(100) DEFAULT NULL,
  `GM_Map` varchar(100) DEFAULT NULL,
  `GM_Mode` varchar(100) DEFAULT NULL,
  `MaxPlayersConnected` int(11) DEFAULT NULL,
  `MaxPlayersRegistered` int(11) DEFAULT NULL,
  PRIMARY KEY (`GM_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `serverData`
--

INSERT INTO `serverData` (`GM_Id`, `GM_Name`, `GM_Website`, `GM_Map`, `GM_Mode`, `MaxPlayersConnected`, `MaxPlayersRegistered`) VALUES
(1, 'PapawyRP', 'http://www.404.fr', 'Mapping-pong', 'PapawyRP V.', 1, 0);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
