-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 17. Jul 2023 um 18:45
-- Server-Version: 10.4.21-MariaDB
-- PHP-Version: 8.0.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `db_lap_registrierung`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tbl_geschlechter`
--

CREATE TABLE `tbl_geschlechter` (
  `IDGeschlecht` int(10) UNSIGNED NOT NULL,
  `Geschlecht` varchar(16) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `tbl_geschlechter`
--

INSERT INTO `tbl_geschlechter` (`IDGeschlecht`, `Geschlecht`) VALUES
(3, 'divers'),
(2, 'männlich'),
(1, 'weiblich');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tbl_passwoerter`
--

CREATE TABLE `tbl_passwoerter` (
  `IDPasswort` int(10) UNSIGNED NOT NULL,
  `FIDUser` int(10) UNSIGNED NOT NULL,
  `Passwort` varchar(255) NOT NULL,
  `Nutzungszeitpunkt` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tbl_rollen`
--

CREATE TABLE `tbl_rollen` (
  `IDRolle` int(10) UNSIGNED NOT NULL,
  `Rolle` varchar(64) NOT NULL,
  `Berechtigungsstufe` tinyint(3) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `tbl_rollen`
--

INSERT INTO `tbl_rollen` (`IDRolle`, `Rolle`, `Berechtigungsstufe`) VALUES
(1, 'Standarduser', 100),
(2, 'Moderator', 20),
(3, 'Administrator', 10);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tbl_staaten`
--

CREATE TABLE `tbl_staaten` (
  `FIDStaat` int(10) UNSIGNED NOT NULL,
  `Staat` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `tbl_staaten`
--

INSERT INTO `tbl_staaten` (`FIDStaat`, `Staat`) VALUES
(2, 'Deutschland'),
(4, 'Italien'),
(5, 'Kroatien'),
(1, 'Österreich'),
(6, 'Schottland'),
(3, 'Spanien');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tbl_user`
--

CREATE TABLE `tbl_user` (
  `IDUser` int(10) UNSIGNED NOT NULL,
  `FIDRolle` int(10) UNSIGNED NOT NULL,
  `Emailadresse` varchar(64) NOT NULL,
  `Vorname` varchar(32) DEFAULT NULL,
  `Nachname` varchar(32) DEFAULT NULL,
  `GebDatum` date DEFAULT NULL,
  `FIDGebLand` int(10) UNSIGNED DEFAULT NULL,
  `FIDGeschlecht` int(10) UNSIGNED DEFAULT NULL,
  `Profilbild` varchar(128) DEFAULT NULL,
  `aktiv` tinyint(1) UNSIGNED NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `tbl_geschlechter`
--
ALTER TABLE `tbl_geschlechter`
  ADD PRIMARY KEY (`IDGeschlecht`),
  ADD UNIQUE KEY `Geschlecht` (`Geschlecht`);

--
-- Indizes für die Tabelle `tbl_passwoerter`
--
ALTER TABLE `tbl_passwoerter`
  ADD PRIMARY KEY (`IDPasswort`),
  ADD KEY `FIDUser` (`FIDUser`);

--
-- Indizes für die Tabelle `tbl_rollen`
--
ALTER TABLE `tbl_rollen`
  ADD PRIMARY KEY (`IDRolle`),
  ADD UNIQUE KEY `Rolle` (`Rolle`),
  ADD UNIQUE KEY `Berechtigungsstufe` (`Berechtigungsstufe`);

--
-- Indizes für die Tabelle `tbl_staaten`
--
ALTER TABLE `tbl_staaten`
  ADD PRIMARY KEY (`FIDStaat`),
  ADD UNIQUE KEY `Staat` (`Staat`);

--
-- Indizes für die Tabelle `tbl_user`
--
ALTER TABLE `tbl_user`
  ADD PRIMARY KEY (`IDUser`),
  ADD UNIQUE KEY `Emailadresse` (`Emailadresse`),
  ADD KEY `FIDGebLand` (`FIDGebLand`),
  ADD KEY `FIDGeschlecht` (`FIDGeschlecht`),
  ADD KEY `FIDRolle` (`FIDRolle`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `tbl_geschlechter`
--
ALTER TABLE `tbl_geschlechter`
  MODIFY `IDGeschlecht` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT für Tabelle `tbl_passwoerter`
--
ALTER TABLE `tbl_passwoerter`
  MODIFY `IDPasswort` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `tbl_rollen`
--
ALTER TABLE `tbl_rollen`
  MODIFY `IDRolle` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT für Tabelle `tbl_staaten`
--
ALTER TABLE `tbl_staaten`
  MODIFY `FIDStaat` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT für Tabelle `tbl_user`
--
ALTER TABLE `tbl_user`
  MODIFY `IDUser` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `tbl_passwoerter`
--
ALTER TABLE `tbl_passwoerter`
  ADD CONSTRAINT `tbl_passwoerter_ibfk_1` FOREIGN KEY (`FIDUser`) REFERENCES `tbl_user` (`IDUser`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints der Tabelle `tbl_user`
--
ALTER TABLE `tbl_user`
  ADD CONSTRAINT `tbl_user_ibfk_1` FOREIGN KEY (`FIDRolle`) REFERENCES `tbl_rollen` (`IDRolle`) ON UPDATE CASCADE,
  ADD CONSTRAINT `tbl_user_ibfk_2` FOREIGN KEY (`FIDGebLand`) REFERENCES `tbl_staaten` (`FIDStaat`) ON UPDATE CASCADE,
  ADD CONSTRAINT `tbl_user_ibfk_3` FOREIGN KEY (`FIDGeschlecht`) REFERENCES `tbl_geschlechter` (`IDGeschlecht`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
