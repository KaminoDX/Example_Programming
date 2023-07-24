-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 28. Mrz 2023 um 08:41
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
-- Datenbank: `db_3443_schule2`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tbl_klassen`
--

CREATE TABLE `tbl_klassen` (
  `IDKlasse` int(10) UNSIGNED NOT NULL,
  `FIDRaum` int(10) UNSIGNED DEFAULT NULL,
  `FIDKV` int(10) UNSIGNED DEFAULT NULL,
  `Bezeichnung` varchar(16) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `tbl_klassen`
--

INSERT INTO `tbl_klassen` (`IDKlasse`, `FIDRaum`, `FIDKV`, `Bezeichnung`) VALUES
(1, 1, 4, '1a'),
(2, 2, 5, '1b'),
(3, 3, 1, '2a'),
(4, 4, 3, '3a'),
(5, 5, 6, '3b'),
(6, 7, 10, '4a');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tbl_lehrer`
--

CREATE TABLE `tbl_lehrer` (
  `IDLehrer` int(10) UNSIGNED NOT NULL,
  `Vorname` varchar(32) NOT NULL,
  `Nachname` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `tbl_lehrer`
--

INSERT INTO `tbl_lehrer` (`IDLehrer`, `Vorname`, `Nachname`) VALUES
(1, 'Uwe', 'Mutz'),
(2, 'Silvia', 'Mutz'),
(3, 'Thomas', 'Wegerer'),
(4, 'Harald', 'Baumgartner'),
(5, 'Sabine', 'Steirer'),
(6, 'Eduard', 'Nittner'),
(7, 'Heinz', 'Fischer'),
(8, 'Sandra', 'Oberhuber'),
(9, 'Mathilde', 'Connors'),
(10, 'Stefanie', 'Semmelweis');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tbl_raeume`
--

CREATE TABLE `tbl_raeume` (
  `IDRaum` int(10) UNSIGNED NOT NULL,
  `Bezeichnung` varchar(16) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `tbl_raeume`
--

INSERT INTO `tbl_raeume` (`IDRaum`, `Bezeichnung`) VALUES
(10, 'CR1'),
(1, 'EG1'),
(2, 'EG2'),
(3, 'EG3'),
(4, 'EG4'),
(8, 'KG1'),
(9, 'KG2'),
(5, 'OG1'),
(6, 'OG2'),
(7, 'OG3');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tbl_schueler`
--

CREATE TABLE `tbl_schueler` (
  `IDSchueler` int(10) UNSIGNED NOT NULL,
  `FIDKlasse` int(10) UNSIGNED DEFAULT NULL,
  `Vorname` varchar(32) NOT NULL,
  `Nachname` varchar(32) NOT NULL,
  `GebDatum` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `tbl_schueler`
--

INSERT INTO `tbl_schueler` (`IDSchueler`, `FIDKlasse`, `Vorname`, `Nachname`, `GebDatum`) VALUES
(1, 1, 'Sandra', 'Huber', '2016-09-01'),
(2, 1, 'Kevin', 'Müller', '2016-12-24'),
(3, 1, 'Chantalle-Monique', 'Svoboda', '2017-03-29'),
(4, 1, 'Tamara', 'Tarantula', '2017-07-08'),
(5, 1, 'Sandra', 'Maier-Mauhart', '2016-11-12'),
(6, 2, 'Walter', 'Oberhuber', '2016-12-03'),
(7, 2, 'Waltraud', 'Oberhuber', '2016-12-03'),
(8, 2, 'Wolfram', 'Timbold', '2017-01-31'),
(9, 2, 'Tatjana', 'Maierhuber', '2016-12-04'),
(10, 2, 'Claudia', 'Huberndorfer', '2017-05-06'),
(11, 2, 'Heribert', 'Gnagger', '2017-04-28'),
(12, 3, 'Tim', 'Körri', '2015-10-17'),
(13, 3, 'Tom', 'Katzinger', '2016-04-18'),
(14, 3, 'Jeremy', 'Mausenbacher', '2016-04-19'),
(15, 3, 'Walter', 'Speichel', '2016-06-29'),
(16, 3, 'Sandrine', 'Edwardson', '2015-11-11'),
(17, 3, 'Sandra', 'Kleibinger-Müller', '2015-12-31'),
(18, 3, 'Klaus', 'Meindl', '2015-11-11'),
(19, 4, 'Julian', 'Mair', '2014-09-18'),
(20, 4, 'Jaqueline', 'Huber', '2014-10-01'),
(21, 4, 'Tim', 'Boltz', '2015-04-11'),
(22, 4, 'Tom', 'Pilz', '2014-12-04'),
(23, 4, 'Nina', 'Toyfl', '2015-06-06'),
(24, 5, 'Thomas', 'Muster', '2014-10-10'),
(25, 5, 'Lara', 'Meier', '2014-11-19'),
(26, 5, 'Laura', 'Papageno', '2015-03-26'),
(27, 5, 'Lorenz', 'Singvogel', '2015-03-27'),
(28, 5, 'Juliana', 'Ebreichsdorfer', '2015-04-02'),
(29, 6, 'Jeremy', 'Wutzel', '2013-10-02'),
(30, 6, 'Rebecca', 'Weidholm', '2014-05-17'),
(31, 6, 'Florian', 'Vogel', '2013-12-12'),
(32, 6, 'Konstantin', 'Eigelsberger-Marchand', '2013-11-27'),
(33, 6, 'Konstanze', 'Adelsbrecht', '2014-04-05');

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `tbl_klassen`
--
ALTER TABLE `tbl_klassen`
  ADD PRIMARY KEY (`IDKlasse`),
  ADD UNIQUE KEY `Bezeichnung` (`Bezeichnung`),
  ADD UNIQUE KEY `FIDRaum` (`FIDRaum`) USING BTREE,
  ADD UNIQUE KEY `FIDKV` (`FIDKV`) USING BTREE;

--
-- Indizes für die Tabelle `tbl_lehrer`
--
ALTER TABLE `tbl_lehrer`
  ADD PRIMARY KEY (`IDLehrer`);

--
-- Indizes für die Tabelle `tbl_raeume`
--
ALTER TABLE `tbl_raeume`
  ADD PRIMARY KEY (`IDRaum`),
  ADD UNIQUE KEY `Bezeichnung` (`Bezeichnung`);

--
-- Indizes für die Tabelle `tbl_schueler`
--
ALTER TABLE `tbl_schueler`
  ADD PRIMARY KEY (`IDSchueler`),
  ADD KEY `FIDKlasse` (`FIDKlasse`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `tbl_klassen`
--
ALTER TABLE `tbl_klassen`
  MODIFY `IDKlasse` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT für Tabelle `tbl_lehrer`
--
ALTER TABLE `tbl_lehrer`
  MODIFY `IDLehrer` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT für Tabelle `tbl_raeume`
--
ALTER TABLE `tbl_raeume`
  MODIFY `IDRaum` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT für Tabelle `tbl_schueler`
--
ALTER TABLE `tbl_schueler`
  MODIFY `IDSchueler` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `tbl_klassen`
--
ALTER TABLE `tbl_klassen`
  ADD CONSTRAINT `tbl_klassen_ibfk_1` FOREIGN KEY (`FIDRaum`) REFERENCES `tbl_raeume` (`IDRaum`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tbl_klassen_ibfk_2` FOREIGN KEY (`FIDKV`) REFERENCES `tbl_lehrer` (`IDLehrer`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints der Tabelle `tbl_schueler`
--
ALTER TABLE `tbl_schueler`
  ADD CONSTRAINT `tbl_schueler_ibfk_1` FOREIGN KEY (`FIDKlasse`) REFERENCES `tbl_klassen` (`IDKlasse`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
