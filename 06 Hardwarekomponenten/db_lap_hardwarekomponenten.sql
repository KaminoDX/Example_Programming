-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Erstellungszeit: 01. Jun 2022 um 10:50
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
-- Datenbank: `db_lap_hardwarekomponenten`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tbl_kategorien`
--

CREATE TABLE `tbl_kategorien` (
  `IDKategorie` int(10) UNSIGNED NOT NULL,
  `FIDKategorie` int(10) UNSIGNED DEFAULT NULL,
  `Kategorie` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `tbl_kategorien`
--

INSERT INTO `tbl_kategorien` (`IDKategorie`, `FIDKategorie`, `Kategorie`) VALUES
(1, NULL, 'Komponenten'),
(2, NULL, 'Individual-PCs'),
(3, 1, 'Motherboards'),
(4, 1, 'CPUs'),
(5, 1, 'RAM (Hauptspeicher)'),
(6, 1, 'Festplatten'),
(7, 1, 'Netzteile'),
(8, 1, 'Lüfter'),
(9, 1, 'Gehäuse'),
(10, 5, 'DDRAM'),
(11, 5, 'SDRAM'),
(12, 5, 'SORAM'),
(13, 4, 'Intel'),
(14, 4, 'AMD'),
(15, 10, 'v5'),
(16, 10, 'v4'),
(17, 10, 'v3'),
(18, 10, 'v2'),
(19, 10, 'v1');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tbl_konfigurator`
--

CREATE TABLE `tbl_konfigurator` (
  `IDKonfigurator` int(10) UNSIGNED NOT NULL,
  `FIDPC` int(10) UNSIGNED NOT NULL COMMENT 'Verweis auf den PC, der zusammengestellt wird',
  `FIDKomponente` int(10) UNSIGNED NOT NULL COMMENT 'Verweis auf die Komponente, die im PC verwendet werden soll',
  `Anzahl` tinyint(3) UNSIGNED NOT NULL COMMENT 'Stückzahl der Komponente'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `tbl_konfigurator`
--

INSERT INTO `tbl_konfigurator` (`IDKonfigurator`, `FIDPC`, `FIDKomponente`, `Anzahl`) VALUES
(1, 27, 17, 1),
(2, 27, 24, 1),
(3, 27, 7, 1),
(4, 27, 3, 4),
(5, 27, 25, 1),
(6, 27, 20, 3),
(7, 27, 25, 1),
(8, 28, 16, 1),
(9, 28, 24, 1),
(10, 28, 5, 1),
(11, 28, 1, 3),
(12, 28, 20, 4),
(13, 28, 26, 1),
(14, 29, 24, 1),
(15, 29, 26, 1),
(16, 29, 17, 1),
(17, 29, 1, 2),
(18, 29, 11, 2),
(19, 29, 20, 2);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tbl_lieferbarkeiten`
--

CREATE TABLE `tbl_lieferbarkeiten` (
  `IDLieferbarkeit` int(10) UNSIGNED NOT NULL,
  `Lieferbarkeit` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `tbl_lieferbarkeiten`
--

INSERT INTO `tbl_lieferbarkeiten` (`IDLieferbarkeit`, `Lieferbarkeit`) VALUES
(1, 'auf Lager'),
(3, 'im Rückstand'),
(2, 'kurzfristig lieferbar'),
(4, 'nicht lieferbar');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tbl_produkte`
--

CREATE TABLE `tbl_produkte` (
  `IDProdukt` int(10) UNSIGNED NOT NULL,
  `FIDKategorie` int(10) UNSIGNED DEFAULT NULL,
  `Artikelnummer` varchar(32) NOT NULL,
  `Produkt` varchar(64) NOT NULL,
  `Beschreibung` text DEFAULT NULL,
  `Preis` double(6,2) UNSIGNED NOT NULL,
  `FIDLieferbarkeit` int(10) UNSIGNED NOT NULL,
  `Produktfoto` varchar(128) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `tbl_produkte`
--

INSERT INTO `tbl_produkte` (`IDProdukt`, `FIDKategorie`, `Artikelnummer`, `Produkt`, `Beschreibung`, `Preis`, `FIDLieferbarkeit`, `Produktfoto`) VALUES
(1, 15, 'KFDDR5_32GB', 'Kingston FURY DIMM 32 GB DDR5-4800 Kit', NULL, 214.90, 1, NULL),
(2, 10, 'CDDR5-5200_32GB', 'Corsair DIMM 32 GB DDR5-5200 Kit', 'Das ist eine Beschreibung', 271.00, 1, NULL),
(3, 15, 'GKillDDR5_32GB', 'G.Skill DIMM 32GB DDR5-6000 Kit', '', 345.00, 3, NULL),
(4, 16, 'GSkillDDR4_15GB', 'G.Skill DIMM 16GB DDR4-3200 Kit', NULL, 57.90, 1, NULL),
(5, 14, 'AMDRyzen9_5900X', 'AMD Ryzen 9 5900X', NULL, 584.00, 1, NULL),
(6, 14, 'AMDRyzen7_5800X', 'AMD Ryzen 7 5800X', NULL, 457.00, 1, NULL),
(7, 13, 'Corei9_12900KF', 'Intel Core i9-12900KF', NULL, 648.00, 1, NULL),
(8, 13, 'Corei9_12900KS', 'Intel Core i9-12900KS', NULL, 879.00, 1, NULL),
(9, 13, 'Corei9_12900T', 'Intel Core i9-12900T', NULL, 564.00, 3, NULL),
(10, 6, 'Barr_4TB_004', 'Seagate BarraCuda 4TB ST4000DM004', NULL, 88.90, 1, NULL),
(11, 6, 'IronWolfNAS_4TB', 'Seagate IronWolf NAS 4TB CMR 2x', '2er-Bundle', 198.90, 1, NULL),
(15, 9, 'AZZA280B', 'AZZA Spectra 280B, Tower', 'schwarz', 60.90, 1, NULL),
(16, 9, 'Fractal_2RGB', 'Fractal Design Meshify 2 RGB Black TG Light Tint, Tower-Gehäuse', 'schwarz', 191.90, 1, NULL),
(17, 9, 'bQ_DB900', 'be quiet! DARK BASE 900, Big-Tower Gehäuse', 'schwarz/orange', 191.90, 1, NULL),
(20, 8, 'bQ_140mmPWM', 'be quiet! Silent Wings 3 140mm PWM', 'schwarz', 23.29, 1, NULL),
(21, 8, 'LL120RGBPWM', 'Corsair LL120 RGB PWM', 'schwarz, Single Pack, ohne Controller', 30.29, 1, NULL),
(22, 3, 'MSIMPGB550', 'MSI MPG B550 Gaming Plus', NULL, 165.90, 1, NULL),
(23, 3, 'GBZ690', 'Gigabyte Z690 Gaming X DDR 4 1.0', NULL, 242.90, 1, NULL),
(24, 3, 'ASUSROGB550', 'ASUS ROG STRIX B550-F GAMING', NULL, 187.90, 2, NULL),
(25, 7, 'bQ11Platinum1000W', 'be quiet! STRAIGHT POWER 11 Platinum 1000W', 'schwarz, 4x PCIe, Kabel-Management, 1000W', 191.90, 1, NULL),
(26, 7, 'SharkoonWPMGold_750W', 'Sharkoon WPM Gold ZERO 750W', NULL, 88.90, 1, NULL),
(27, 2, 'GMPC1', 'Gaming-PC 1', NULL, 0.00, 1, NULL),
(28, 2, 'GMPC2', 'Gaming-PC 2', NULL, 0.00, 1, NULL),
(29, 2, 'OPC1', 'Office-PC 1', NULL, 0.00, 2, NULL);

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `tbl_kategorien`
--
ALTER TABLE `tbl_kategorien`
  ADD PRIMARY KEY (`IDKategorie`),
  ADD KEY `FIDKategorie` (`FIDKategorie`);

--
-- Indizes für die Tabelle `tbl_konfigurator`
--
ALTER TABLE `tbl_konfigurator`
  ADD PRIMARY KEY (`IDKonfigurator`),
  ADD KEY `FIDPC` (`FIDPC`),
  ADD KEY `FIDKomponente` (`FIDKomponente`);

--
-- Indizes für die Tabelle `tbl_lieferbarkeiten`
--
ALTER TABLE `tbl_lieferbarkeiten`
  ADD PRIMARY KEY (`IDLieferbarkeit`),
  ADD UNIQUE KEY `Lieferbarkeit` (`Lieferbarkeit`);

--
-- Indizes für die Tabelle `tbl_produkte`
--
ALTER TABLE `tbl_produkte`
  ADD PRIMARY KEY (`IDProdukt`),
  ADD UNIQUE KEY `Artikelnummer` (`Artikelnummer`),
  ADD KEY `FIDKategorie` (`FIDKategorie`),
  ADD KEY `FIDLieferbarkeit` (`FIDLieferbarkeit`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `tbl_kategorien`
--
ALTER TABLE `tbl_kategorien`
  MODIFY `IDKategorie` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT für Tabelle `tbl_konfigurator`
--
ALTER TABLE `tbl_konfigurator`
  MODIFY `IDKonfigurator` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT für Tabelle `tbl_lieferbarkeiten`
--
ALTER TABLE `tbl_lieferbarkeiten`
  MODIFY `IDLieferbarkeit` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT für Tabelle `tbl_produkte`
--
ALTER TABLE `tbl_produkte`
  MODIFY `IDProdukt` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `tbl_kategorien`
--
ALTER TABLE `tbl_kategorien`
  ADD CONSTRAINT `tbl_kategorien_ibfk_1` FOREIGN KEY (`FIDKategorie`) REFERENCES `tbl_kategorien` (`IDKategorie`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints der Tabelle `tbl_konfigurator`
--
ALTER TABLE `tbl_konfigurator`
  ADD CONSTRAINT `tbl_konfigurator_ibfk_1` FOREIGN KEY (`FIDPC`) REFERENCES `tbl_produkte` (`IDProdukt`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tbl_konfigurator_ibfk_2` FOREIGN KEY (`FIDKomponente`) REFERENCES `tbl_produkte` (`IDProdukt`) ON UPDATE CASCADE;

--
-- Constraints der Tabelle `tbl_produkte`
--
ALTER TABLE `tbl_produkte`
  ADD CONSTRAINT `tbl_produkte_ibfk_1` FOREIGN KEY (`FIDKategorie`) REFERENCES `tbl_kategorien` (`IDKategorie`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tbl_produkte_ibfk_2` FOREIGN KEY (`FIDLieferbarkeit`) REFERENCES `tbl_lieferbarkeiten` (`IDLieferbarkeit`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
