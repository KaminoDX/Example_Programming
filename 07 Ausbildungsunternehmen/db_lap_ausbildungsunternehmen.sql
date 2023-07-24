-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Erstellungszeit: 18. Mai 2022 um 18:18
-- Server-Version: 10.4.11-MariaDB
-- PHP-Version: 7.4.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `db_lap_ausbildungsunternehmen`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tbl_einsaetze`
--

CREATE TABLE `tbl_einsaetze` (
  `IDEinsatz` int(10) UNSIGNED NOT NULL,
  `FIDLehrgangsdurchfuehrung` int(10) UNSIGNED NOT NULL,
  `FIDLehrgangsplanung` int(10) UNSIGNED NOT NULL,
  `FIDVortragender` int(10) UNSIGNED DEFAULT NULL,
  `Stundenzahl` tinyint(3) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `tbl_einsaetze`
--

INSERT INTO `tbl_einsaetze` (`IDEinsatz`, `FIDLehrgangsdurchfuehrung`, `FIDLehrgangsplanung`, `FIDVortragender`, `Stundenzahl`) VALUES
(1, 4, 1, 1, 60),
(2, 4, 2, 3, 90),
(3, 4, 2, 1, 10),
(4, 4, 3, 1, 64),
(5, 4, 3, 2, 16),
(6, 4, 3, 4, 16),
(7, 4, 4, 3, 50),
(8, 4, 5, 3, 60),
(9, 4, 5, 1, 60),
(10, 4, 6, 4, 36),
(11, 4, 6, 2, 50),
(12, 4, 7, 2, 36),
(13, 4, 8, 4, 100),
(14, 4, 8, 1, 50),
(15, 4, 9, 2, 30),
(16, 4, 10, 2, 40),
(17, 4, 11, 2, 16),
(18, 4, 12, 4, 75),
(19, 4, 12, 1, 75),
(20, 4, 13, 2, 50),
(21, 4, 14, 1, 25),
(22, 4, 15, 2, 15);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tbl_gegenstaende`
--

CREATE TABLE `tbl_gegenstaende` (
  `IDGegenstand` int(10) UNSIGNED NOT NULL,
  `Gegenstand` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `tbl_gegenstaende`
--

INSERT INTO `tbl_gegenstaende` (`IDGegenstand`, `Gegenstand`) VALUES
(1, 'Mathematik'),
(2, 'Informatik'),
(3, 'Fotografie'),
(4, 'Video'),
(5, 'Marketing'),
(6, 'Elektronik'),
(7, 'Elektrotechnik'),
(8, 'Druck & Design'),
(9, '3D-Visualisierung und -Animation'),
(10, 'Datenbanken');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tbl_lehrgaenge`
--

CREATE TABLE `tbl_lehrgaenge` (
  `IDLehrgang` int(10) UNSIGNED NOT NULL,
  `Lehrgang` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `tbl_lehrgaenge`
--

INSERT INTO `tbl_lehrgaenge` (`IDLehrgang`, `Lehrgang`) VALUES
(1, 'Fachakademie Automatisierungstechnik'),
(2, 'Fachakademie Medieninformatik'),
(3, 'Fachakademie Mediendesign');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tbl_lehrgangsdurchfuehrungen`
--

CREATE TABLE `tbl_lehrgangsdurchfuehrungen` (
  `IDLehrgangsdurchfuehrung` int(10) UNSIGNED NOT NULL,
  `FIDLehrgang` int(10) UNSIGNED NOT NULL,
  `Beginnjahr` year(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `tbl_lehrgangsdurchfuehrungen`
--

INSERT INTO `tbl_lehrgangsdurchfuehrungen` (`IDLehrgangsdurchfuehrung`, `FIDLehrgang`, `Beginnjahr`) VALUES
(1, 3, 2021),
(2, 3, 2022),
(3, 1, 2019),
(4, 2, 2022);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tbl_lehrgangsplanung`
--

CREATE TABLE `tbl_lehrgangsplanung` (
  `IDLehrgangsplanung` int(10) UNSIGNED NOT NULL,
  `FIDLehrgang` int(10) UNSIGNED NOT NULL,
  `FIDSemester` int(10) UNSIGNED NOT NULL,
  `FIDGegenstand` int(10) UNSIGNED DEFAULT NULL,
  `Stundenzahl` tinyint(3) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `tbl_lehrgangsplanung`
--

INSERT INTO `tbl_lehrgangsplanung` (`IDLehrgangsplanung`, `FIDLehrgang`, `FIDSemester`, `FIDGegenstand`, `Stundenzahl`) VALUES
(1, 2, 1, 1, 60),
(2, 2, 1, 2, 100),
(3, 2, 1, 5, 96),
(4, 2, 2, 1, 50),
(5, 2, 2, 2, 120),
(6, 2, 2, 10, 86),
(7, 2, 3, 1, 36),
(8, 2, 3, 2, 150),
(9, 2, 3, 5, 30),
(10, 2, 3, 10, 40),
(11, 2, 4, 1, 16),
(12, 2, 4, 2, 150),
(13, 2, 4, 10, 50),
(14, 2, 4, 5, 25),
(15, 2, 4, 6, 15);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tbl_semester`
--

CREATE TABLE `tbl_semester` (
  `IDSemester` int(10) UNSIGNED NOT NULL,
  `Semester` tinyint(1) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `tbl_semester`
--

INSERT INTO `tbl_semester` (`IDSemester`, `Semester`) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tbl_vortragende`
--

CREATE TABLE `tbl_vortragende` (
  `IDVortragender` int(10) UNSIGNED NOT NULL,
  `Nachname` varchar(32) NOT NULL,
  `Vorname` varchar(32) NOT NULL,
  `SVNr` smallint(4) UNSIGNED ZEROFILL NOT NULL,
  `GebDatum` date NOT NULL,
  `Telno` varchar(64) DEFAULT NULL,
  `Emailadresse` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `tbl_vortragende`
--

INSERT INTO `tbl_vortragende` (`IDVortragender`, `Nachname`, `Vorname`, `SVNr`, `GebDatum`, `Telno`, `Emailadresse`) VALUES
(1, 'Mutz', 'Uwe', 1234, '1972-10-17', NULL, 'uwe.mutz@syne.at'),
(2, 'Mutz', 'Silvia', 2345, '1978-05-02', NULL, 'silvia.mutz@syne.at'),
(3, 'Meisinger', 'Christoph', 0255, '1975-02-01', '+43 676 1234567', 'christoph.m@gmail.com'),
(4, 'Wegerer', 'Thomas', 0090, '1979-01-19', '', 'tom@interactive-values.at');

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `tbl_einsaetze`
--
ALTER TABLE `tbl_einsaetze`
  ADD PRIMARY KEY (`IDEinsatz`),
  ADD KEY `FIDLehrgangsdurchfuehrung` (`FIDLehrgangsdurchfuehrung`),
  ADD KEY `FIDVortragender` (`FIDVortragender`),
  ADD KEY `FIDLehrgangsplanung` (`FIDLehrgangsplanung`);

--
-- Indizes für die Tabelle `tbl_gegenstaende`
--
ALTER TABLE `tbl_gegenstaende`
  ADD PRIMARY KEY (`IDGegenstand`);

--
-- Indizes für die Tabelle `tbl_lehrgaenge`
--
ALTER TABLE `tbl_lehrgaenge`
  ADD PRIMARY KEY (`IDLehrgang`);

--
-- Indizes für die Tabelle `tbl_lehrgangsdurchfuehrungen`
--
ALTER TABLE `tbl_lehrgangsdurchfuehrungen`
  ADD PRIMARY KEY (`IDLehrgangsdurchfuehrung`),
  ADD KEY `FIDLehrgang` (`FIDLehrgang`);

--
-- Indizes für die Tabelle `tbl_lehrgangsplanung`
--
ALTER TABLE `tbl_lehrgangsplanung`
  ADD PRIMARY KEY (`IDLehrgangsplanung`),
  ADD KEY `FIDLehrgang` (`FIDLehrgang`),
  ADD KEY `FIDSemester` (`FIDSemester`),
  ADD KEY `FIDGegenstand` (`FIDGegenstand`);

--
-- Indizes für die Tabelle `tbl_semester`
--
ALTER TABLE `tbl_semester`
  ADD PRIMARY KEY (`IDSemester`),
  ADD UNIQUE KEY `Semester` (`Semester`);

--
-- Indizes für die Tabelle `tbl_vortragende`
--
ALTER TABLE `tbl_vortragende`
  ADD PRIMARY KEY (`IDVortragender`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `tbl_einsaetze`
--
ALTER TABLE `tbl_einsaetze`
  MODIFY `IDEinsatz` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT für Tabelle `tbl_gegenstaende`
--
ALTER TABLE `tbl_gegenstaende`
  MODIFY `IDGegenstand` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT für Tabelle `tbl_lehrgaenge`
--
ALTER TABLE `tbl_lehrgaenge`
  MODIFY `IDLehrgang` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT für Tabelle `tbl_lehrgangsdurchfuehrungen`
--
ALTER TABLE `tbl_lehrgangsdurchfuehrungen`
  MODIFY `IDLehrgangsdurchfuehrung` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT für Tabelle `tbl_lehrgangsplanung`
--
ALTER TABLE `tbl_lehrgangsplanung`
  MODIFY `IDLehrgangsplanung` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT für Tabelle `tbl_semester`
--
ALTER TABLE `tbl_semester`
  MODIFY `IDSemester` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT für Tabelle `tbl_vortragende`
--
ALTER TABLE `tbl_vortragende`
  MODIFY `IDVortragender` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `tbl_einsaetze`
--
ALTER TABLE `tbl_einsaetze`
  ADD CONSTRAINT `tbl_einsaetze_ibfk_1` FOREIGN KEY (`FIDLehrgangsdurchfuehrung`) REFERENCES `tbl_lehrgangsdurchfuehrungen` (`IDLehrgangsdurchfuehrung`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tbl_einsaetze_ibfk_2` FOREIGN KEY (`FIDLehrgangsplanung`) REFERENCES `tbl_lehrgangsplanung` (`IDLehrgangsplanung`) ON UPDATE CASCADE,
  ADD CONSTRAINT `tbl_einsaetze_ibfk_3` FOREIGN KEY (`FIDVortragender`) REFERENCES `tbl_vortragende` (`IDVortragender`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints der Tabelle `tbl_lehrgangsdurchfuehrungen`
--
ALTER TABLE `tbl_lehrgangsdurchfuehrungen`
  ADD CONSTRAINT `tbl_lehrgangsdurchfuehrungen_ibfk_1` FOREIGN KEY (`FIDLehrgang`) REFERENCES `tbl_lehrgaenge` (`IDLehrgang`) ON UPDATE CASCADE;

--
-- Constraints der Tabelle `tbl_lehrgangsplanung`
--
ALTER TABLE `tbl_lehrgangsplanung`
  ADD CONSTRAINT `tbl_lehrgangsplanung_ibfk_1` FOREIGN KEY (`FIDLehrgang`) REFERENCES `tbl_lehrgaenge` (`IDLehrgang`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tbl_lehrgangsplanung_ibfk_2` FOREIGN KEY (`FIDSemester`) REFERENCES `tbl_semester` (`IDSemester`) ON UPDATE CASCADE,
  ADD CONSTRAINT `tbl_lehrgangsplanung_ibfk_3` FOREIGN KEY (`FIDGegenstand`) REFERENCES `tbl_gegenstaende` (`IDGegenstand`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
