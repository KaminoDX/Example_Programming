-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 09. Mai 2022 um 19:14
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
-- Datenbank: `db_lap_malereibetrieb`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tbl_einsatz`
--

CREATE TABLE `tbl_einsatz` (
  `IDEinsatz` int(10) UNSIGNED NOT NULL,
  `FIDMitarbeiter` int(10) UNSIGNED DEFAULT NULL,
  `FIDKunde` int(10) UNSIGNED DEFAULT NULL,
  `Startzeitpunkt` datetime NOT NULL,
  `Endzeitpunkt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `tbl_einsatz`
--

INSERT INTO `tbl_einsatz` (`IDEinsatz`, `FIDMitarbeiter`, `FIDKunde`, `Startzeitpunkt`, `Endzeitpunkt`) VALUES
(1, 1, 4, '2022-04-09 08:00:00', '2022-04-09 11:30:00'),
(2, 1, 2, '2022-04-09 12:00:00', '2022-04-09 17:30:00'),
(3, 2, 4, '2022-04-09 08:00:00', '2022-04-09 11:30:00'),
(4, 3, 2, '2022-04-09 12:00:00', '2022-04-09 16:30:00'),
(5, 3, 3, '2022-02-10 07:30:00', '2022-02-10 16:00:00'),
(6, 3, 3, '2022-02-11 07:30:00', '2022-02-11 16:30:00'),
(7, 3, 3, '2022-02-12 09:00:00', '2022-02-12 13:30:00'),
(8, 2, 3, '2022-02-12 08:00:00', '2022-02-12 16:00:00'),
(9, 1, 3, '2022-02-11 08:00:00', '2022-02-11 11:30:00'),
(10, 1, 1, '2022-03-31 12:00:00', '2022-03-31 18:00:00');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tbl_kategorien`
--

CREATE TABLE `tbl_kategorien` (
  `IDKategorie` int(10) UNSIGNED NOT NULL,
  `Bezeichnung` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `tbl_kategorien`
--

INSERT INTO `tbl_kategorien` (`IDKategorie`, `Bezeichnung`) VALUES
(1, 'geschäftlich'),
(2, 'privat');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tbl_kunden`
--

CREATE TABLE `tbl_kunden` (
  `IDKunde` int(10) UNSIGNED NOT NULL,
  `Vorname` varchar(32) NOT NULL,
  `Nachname` varchar(32) NOT NULL,
  `Adresse` varchar(32) NOT NULL,
  `PLZ` smallint(4) UNSIGNED NOT NULL,
  `Ort` varchar(64) NOT NULL,
  `Telno` varchar(32) NOT NULL,
  `Email` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `tbl_kunden`
--

INSERT INTO `tbl_kunden` (`IDKunde`, `Vorname`, `Nachname`, `Adresse`, `PLZ`, `Ort`, `Telno`, `Email`) VALUES
(1, 'John', 'Doe', 'Gartenweg 17', 4020, 'Linz', '+43 732 123455', NULL),
(2, 'Heinz', 'Fischer', 'Johannesweg 23a', 4221, 'Steyregg', '+43 732 435033', 'heinz.fischer@test.at'),
(3, 'Maria', 'Schneider', 'Blumenstraße 16/2/4', 4060, 'Leonding', '+43 664 3974322', 'maria.s@gmail.com'),
(4, 'Engelbert', 'Müller', 'Ebereschenweg 9', 4050, 'Traun', '+43 7229 34893', NULL);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tbl_mitarbeiter`
--

CREATE TABLE `tbl_mitarbeiter` (
  `IDMitarbeiter` int(10) UNSIGNED NOT NULL,
  `Vorname` varchar(32) NOT NULL,
  `Nachname` varchar(32) NOT NULL,
  `SVNr` smallint(4) UNSIGNED NOT NULL,
  `GebDatum` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `tbl_mitarbeiter`
--

INSERT INTO `tbl_mitarbeiter` (`IDMitarbeiter`, `Vorname`, `Nachname`, `SVNr`, `GebDatum`) VALUES
(1, 'Johann', 'Maier', 4543, '1966-04-09'),
(2, 'Tom', 'Fischerlehner', 3043, '1999-01-31'),
(3, 'Sandra', 'Engel', 1191, '1972-10-11');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tbl_telnos`
--

CREATE TABLE `tbl_telnos` (
  `IDTelno` int(10) UNSIGNED NOT NULL,
  `FIDMitarbeiter` int(10) UNSIGNED NOT NULL,
  `FIDKategorie` int(10) UNSIGNED NOT NULL,
  `Telno` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `tbl_telnos`
--

INSERT INTO `tbl_telnos` (`IDTelno`, `FIDMitarbeiter`, `FIDKategorie`, `Telno`) VALUES
(1, 1, 1, '+43 664 2309403'),
(2, 1, 1, '+43 732 23393-12'),
(3, 3, 2, '+43 676 2343333'),
(4, 2, 1, '+43 732 23393-13'),
(5, 2, 2, '+43 688 23973927'),
(6, 2, 1, '+43 664 9873243');

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `tbl_einsatz`
--
ALTER TABLE `tbl_einsatz`
  ADD PRIMARY KEY (`IDEinsatz`),
  ADD KEY `FIDMitarbeiter` (`FIDMitarbeiter`),
  ADD KEY `FIDKunde` (`FIDKunde`);

--
-- Indizes für die Tabelle `tbl_kategorien`
--
ALTER TABLE `tbl_kategorien`
  ADD PRIMARY KEY (`IDKategorie`);

--
-- Indizes für die Tabelle `tbl_kunden`
--
ALTER TABLE `tbl_kunden`
  ADD PRIMARY KEY (`IDKunde`);

--
-- Indizes für die Tabelle `tbl_mitarbeiter`
--
ALTER TABLE `tbl_mitarbeiter`
  ADD PRIMARY KEY (`IDMitarbeiter`);

--
-- Indizes für die Tabelle `tbl_telnos`
--
ALTER TABLE `tbl_telnos`
  ADD PRIMARY KEY (`IDTelno`),
  ADD KEY `FIDMitarbeiter` (`FIDMitarbeiter`),
  ADD KEY `FIDKategorie` (`FIDKategorie`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `tbl_einsatz`
--
ALTER TABLE `tbl_einsatz`
  MODIFY `IDEinsatz` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT für Tabelle `tbl_kategorien`
--
ALTER TABLE `tbl_kategorien`
  MODIFY `IDKategorie` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT für Tabelle `tbl_kunden`
--
ALTER TABLE `tbl_kunden`
  MODIFY `IDKunde` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT für Tabelle `tbl_mitarbeiter`
--
ALTER TABLE `tbl_mitarbeiter`
  MODIFY `IDMitarbeiter` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT für Tabelle `tbl_telnos`
--
ALTER TABLE `tbl_telnos`
  MODIFY `IDTelno` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `tbl_einsatz`
--
ALTER TABLE `tbl_einsatz`
  ADD CONSTRAINT `tbl_einsatz_ibfk_1` FOREIGN KEY (`FIDKunde`) REFERENCES `tbl_kunden` (`IDKunde`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tbl_einsatz_ibfk_2` FOREIGN KEY (`FIDMitarbeiter`) REFERENCES `tbl_mitarbeiter` (`IDMitarbeiter`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints der Tabelle `tbl_telnos`
--
ALTER TABLE `tbl_telnos`
  ADD CONSTRAINT `tbl_telnos_ibfk_1` FOREIGN KEY (`FIDKategorie`) REFERENCES `tbl_kategorien` (`IDKategorie`) ON UPDATE CASCADE,
  ADD CONSTRAINT `tbl_telnos_ibfk_2` FOREIGN KEY (`FIDMitarbeiter`) REFERENCES `tbl_mitarbeiter` (`IDMitarbeiter`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
