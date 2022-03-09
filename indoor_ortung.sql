-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 16. Okt 2021 um 18:40
-- Server-Version: 10.4.18-MariaDB
-- PHP-Version: 8.0.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `indoor_ortung`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `places`
--

CREATE TABLE `places` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `waypoint` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `places`
--

INSERT INTO `places` (`id`, `name`, `waypoint`) VALUES
(1, 'A', 1),
(2, 'B', 2),
(3, 'C', 3),
(4, 'D', 4),
(5, 'E', 5),
(6, 'F', 6);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `waypoints`
--

CREATE TABLE `waypoints` (
  `id` int(11) NOT NULL,
  `longitude` float NOT NULL,
  `latitude` float NOT NULL,
  `level` int(100) NOT NULL,
  `traversable` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `waypoints`
--

INSERT INTO `waypoints` (`id`, `longitude`, `latitude`, `level`, `traversable`) VALUES
(1, 10.1, 20.2, 2, 0),
(2, 10.1, 20.2, 2, 0),
(3, 10.2, 20.1, 2, 0),
(4, 10.3, 20.1, 2, 0),
(5, 10.3, 20.3, 2, 0),
(6, 10.3, 20.4, 1, 0),
(7, 10.3, 20.5, 1, 1),
(8, 10.2, 20.5, 2, 1),
(9, 10.2, 20.3, 2, 1),
(10, 10.2, 20.2, 2, 1),
(11, 10.3, 20.2, 2, 1);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `ways`
--

CREATE TABLE `ways` (
  `id` int(11) NOT NULL,
  `pointsA` int(11) NOT NULL,
  `pointsB` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `ways`
--

INSERT INTO `ways` (`id`, `pointsA`, `pointsB`) VALUES
(1, 3, 10),
(2, 4, 11),
(3, 2, 10),
(4, 10, 11),
(5, 10, 9),
(6, 11, 5),
(7, 1, 9),
(8, 9, 5),
(9, 9, 8),
(10, 6, 7),
(11, 8, 7);

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `places`
--
ALTER TABLE `places`
  ADD PRIMARY KEY (`id`),
  ADD KEY `waypoint` (`waypoint`);

--
-- Indizes für die Tabelle `waypoints`
--
ALTER TABLE `waypoints`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `ways`
--
ALTER TABLE `ways`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pointsA` (`pointsA`),
  ADD KEY `pointsB` (`pointsB`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `places`
--
ALTER TABLE `places`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT für Tabelle `waypoints`
--
ALTER TABLE `waypoints`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT für Tabelle `ways`
--
ALTER TABLE `ways`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `places`
--
ALTER TABLE `places`
  ADD CONSTRAINT `places_ibfk_1` FOREIGN KEY (`waypoint`) REFERENCES `waypoints` (`id`);

--
-- Constraints der Tabelle `ways`
--
ALTER TABLE `ways`
  ADD CONSTRAINT `ways_ibfk_1` FOREIGN KEY (`pointsA`) REFERENCES `waypoints` (`id`),
  ADD CONSTRAINT `ways_ibfk_2` FOREIGN KEY (`pointsB`) REFERENCES `waypoints` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
