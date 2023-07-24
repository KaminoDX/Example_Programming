-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 28. Jun 2023 um 11:34
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
-- Datenbank: `db_rechnungslegung`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tbl_kunden`
--

CREATE TABLE `tbl_kunden` (
  `IDKunde` int(10) UNSIGNED NOT NULL,
  `Nachname` varchar(32) NOT NULL,
  `Vorname` varchar(32) NOT NULL,
  `Adresse` varchar(64) NOT NULL,
  `PLZ` varchar(8) NOT NULL,
  `Ort` varchar(32) NOT NULL,
  `FIDStaat` int(10) UNSIGNED NOT NULL,
  `Emailadresse` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `tbl_kunden`
--

INSERT INTO `tbl_kunden` (`IDKunde`, `Nachname`, `Vorname`, `Adresse`, `PLZ`, `Ort`, `FIDStaat`, `Emailadresse`) VALUES
(1, 'Mutz', 'Uwe', 'Holzwindenerstr. 38', '4221', 'Steyregg', 1, 'uwe.mutz@gmail.com');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tbl_paketgroessen`
--

CREATE TABLE `tbl_paketgroessen` (
  `IDPaketgroesse` int(10) UNSIGNED NOT NULL,
  `Bezeichnung` varchar(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `tbl_paketgroessen`
--

INSERT INTO `tbl_paketgroessen` (`IDPaketgroesse`, `Bezeichnung`) VALUES
(4, '-'),
(3, 'L'),
(2, 'M'),
(1, 'S');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tbl_positionen`
--

CREATE TABLE `tbl_positionen` (
  `IDPosition` int(10) UNSIGNED NOT NULL,
  `FIDRechnung` int(10) UNSIGNED NOT NULL,
  `FIDProdukt` int(10) UNSIGNED NOT NULL,
  `Anzahl` float(5,2) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `tbl_positionen`
--

INSERT INTO `tbl_positionen` (`IDPosition`, `FIDRechnung`, `FIDProdukt`, `Anzahl`) VALUES
(1, 1, 1, 1.00),
(2, 1, 2, 2.00),
(3, 1, 3, 2.00),
(4, 1, 4, 2.00);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tbl_produkte`
--

CREATE TABLE `tbl_produkte` (
  `IDProdukt` int(10) UNSIGNED NOT NULL,
  `Produkt` varchar(64) NOT NULL,
  `Beschreibung` text DEFAULT NULL,
  `PreisExkl` decimal(7,2) UNSIGNED NOT NULL,
  `FIDUStSatz` int(10) UNSIGNED NOT NULL,
  `Produktbild` varchar(128) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `tbl_produkte`
--

INSERT INTO `tbl_produkte` (`IDProdukt`, `Produkt`, `Beschreibung`, `PreisExkl`, `FIDUStSatz`, `Produktbild`) VALUES
(1, 'Pure Racing-Bremsbeläge Z04', NULL, '108.00', 1, NULL),
(2, 'D 213 GP Pro vorne', NULL, '167.00', 1, NULL),
(3, 'D 213 GP Pro vorne', 'Mischung:\r\nPRO 2 RACE', '167.00', 1, NULL),
(4, 'KR108 Slick hinten - 200/70R17', 'Mischung:\r\nMS1 RACE (NTEC)', '257.00', 1, NULL);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tbl_rechnungen`
--

CREATE TABLE `tbl_rechnungen` (
  `IDRechnung` int(10) UNSIGNED NOT NULL,
  `ReNo` varchar(32) NOT NULL,
  `Datum` date NOT NULL,
  `FIDKunde` int(10) UNSIGNED NOT NULL,
  `FIDZahlungsart` int(10) UNSIGNED NOT NULL,
  `FIDVersandPaket` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `tbl_rechnungen`
--

INSERT INTO `tbl_rechnungen` (`IDRechnung`, `ReNo`, `Datum`, `FIDKunde`, `FIDZahlungsart`, `FIDVersandPaket`) VALUES
(1, 'Re-2-2022', '2022-02-17', 1, 1, 13);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tbl_staaten`
--

CREATE TABLE `tbl_staaten` (
  `IDStaat` int(10) UNSIGNED NOT NULL,
  `Staat` varchar(32) NOT NULL,
  `Kurzzeichen` varchar(2) NOT NULL,
  `Vorwahl` smallint(4) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `tbl_staaten`
--

INSERT INTO `tbl_staaten` (`IDStaat`, `Staat`, `Kurzzeichen`, `Vorwahl`) VALUES
(1, 'Österreich', 'AT', 43),
(2, 'Deutschland', 'DE', 49),
(3, 'Italien', 'IT', 39),
(4, 'Spanien', 'ES', 34);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tbl_ustsaetze`
--

CREATE TABLE `tbl_ustsaetze` (
  `IDUStSatz` int(10) UNSIGNED NOT NULL,
  `Beschreibung` varchar(8) DEFAULT NULL,
  `UStSatz` decimal(4,2) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `tbl_ustsaetze`
--

INSERT INTO `tbl_ustsaetze` (`IDUStSatz`, `Beschreibung`, `UStSatz`) VALUES
(1, '20%', '20.00'),
(2, '19%', '19.00'),
(3, '22%', '22.00'),
(4, '0%', '0.00');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tbl_versandarten`
--

CREATE TABLE `tbl_versandarten` (
  `IDVersandart` int(10) UNSIGNED NOT NULL,
  `Versandart` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `tbl_versandarten`
--

INSERT INTO `tbl_versandarten` (`IDVersandart`, `Versandart`) VALUES
(2, 'Abholung'),
(1, 'Versand');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tbl_versand_paket`
--

CREATE TABLE `tbl_versand_paket` (
  `IDVersandPaket` int(10) UNSIGNED NOT NULL,
  `FIDVersandart` int(10) UNSIGNED NOT NULL,
  `FIDPaket` int(10) UNSIGNED NOT NULL,
  `Kosten` decimal(5,2) UNSIGNED NOT NULL,
  `FIDUStSatz` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `tbl_versand_paket`
--

INSERT INTO `tbl_versand_paket` (`IDVersandPaket`, `FIDVersandart`, `FIDPaket`, `Kosten`, `FIDUStSatz`) VALUES
(7, 1, 1, '5.00', 1),
(8, 1, 2, '8.00', 1),
(9, 1, 3, '12.00', 1),
(10, 2, 1, '0.00', 1),
(11, 2, 2, '0.00', 1),
(12, 2, 3, '0.00', 1),
(13, 2, 4, '0.00', 1);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tbl_zahlungsarten`
--

CREATE TABLE `tbl_zahlungsarten` (
  `IDZahlungsart` int(10) UNSIGNED NOT NULL,
  `Zahlungsart` varchar(32) NOT NULL,
  `AufpreisProzent` decimal(4,2) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `tbl_zahlungsarten`
--

INSERT INTO `tbl_zahlungsarten` (`IDZahlungsart`, `Zahlungsart`, `AufpreisProzent`) VALUES
(1, 'Vorauskasse', '0.00'),
(2, 'Paypal', '3.50');

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `tbl_kunden`
--
ALTER TABLE `tbl_kunden`
  ADD PRIMARY KEY (`IDKunde`),
  ADD UNIQUE KEY `Emailadresse` (`Emailadresse`),
  ADD KEY `FIDStaat` (`FIDStaat`);

--
-- Indizes für die Tabelle `tbl_paketgroessen`
--
ALTER TABLE `tbl_paketgroessen`
  ADD PRIMARY KEY (`IDPaketgroesse`),
  ADD UNIQUE KEY `Bezeichnung` (`Bezeichnung`);

--
-- Indizes für die Tabelle `tbl_positionen`
--
ALTER TABLE `tbl_positionen`
  ADD PRIMARY KEY (`IDPosition`),
  ADD KEY `FIDRechnung` (`FIDRechnung`),
  ADD KEY `FIDProdukt` (`FIDProdukt`);

--
-- Indizes für die Tabelle `tbl_produkte`
--
ALTER TABLE `tbl_produkte`
  ADD PRIMARY KEY (`IDProdukt`),
  ADD KEY `FIDUStSatz` (`FIDUStSatz`);

--
-- Indizes für die Tabelle `tbl_rechnungen`
--
ALTER TABLE `tbl_rechnungen`
  ADD PRIMARY KEY (`IDRechnung`),
  ADD UNIQUE KEY `ReNo` (`ReNo`),
  ADD KEY `FIDKunde` (`FIDKunde`),
  ADD KEY `FIDZahlungsart` (`FIDZahlungsart`),
  ADD KEY `FIDVersandPaket` (`FIDVersandPaket`);

--
-- Indizes für die Tabelle `tbl_staaten`
--
ALTER TABLE `tbl_staaten`
  ADD PRIMARY KEY (`IDStaat`),
  ADD UNIQUE KEY `Staat` (`Staat`),
  ADD UNIQUE KEY `Kurzzeichen` (`Kurzzeichen`),
  ADD UNIQUE KEY `Vorwahl` (`Vorwahl`);

--
-- Indizes für die Tabelle `tbl_ustsaetze`
--
ALTER TABLE `tbl_ustsaetze`
  ADD PRIMARY KEY (`IDUStSatz`),
  ADD UNIQUE KEY `UStSatz` (`UStSatz`);

--
-- Indizes für die Tabelle `tbl_versandarten`
--
ALTER TABLE `tbl_versandarten`
  ADD PRIMARY KEY (`IDVersandart`),
  ADD UNIQUE KEY `Versandart` (`Versandart`);

--
-- Indizes für die Tabelle `tbl_versand_paket`
--
ALTER TABLE `tbl_versand_paket`
  ADD PRIMARY KEY (`IDVersandPaket`),
  ADD UNIQUE KEY `FIDVersandart` (`FIDVersandart`,`FIDPaket`),
  ADD KEY `FIDPaket` (`FIDPaket`),
  ADD KEY `FIDUStSatz` (`FIDUStSatz`);

--
-- Indizes für die Tabelle `tbl_zahlungsarten`
--
ALTER TABLE `tbl_zahlungsarten`
  ADD PRIMARY KEY (`IDZahlungsart`),
  ADD UNIQUE KEY `Zahlungsart` (`Zahlungsart`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `tbl_kunden`
--
ALTER TABLE `tbl_kunden`
  MODIFY `IDKunde` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT für Tabelle `tbl_paketgroessen`
--
ALTER TABLE `tbl_paketgroessen`
  MODIFY `IDPaketgroesse` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT für Tabelle `tbl_positionen`
--
ALTER TABLE `tbl_positionen`
  MODIFY `IDPosition` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT für Tabelle `tbl_produkte`
--
ALTER TABLE `tbl_produkte`
  MODIFY `IDProdukt` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT für Tabelle `tbl_rechnungen`
--
ALTER TABLE `tbl_rechnungen`
  MODIFY `IDRechnung` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT für Tabelle `tbl_staaten`
--
ALTER TABLE `tbl_staaten`
  MODIFY `IDStaat` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT für Tabelle `tbl_ustsaetze`
--
ALTER TABLE `tbl_ustsaetze`
  MODIFY `IDUStSatz` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT für Tabelle `tbl_versandarten`
--
ALTER TABLE `tbl_versandarten`
  MODIFY `IDVersandart` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT für Tabelle `tbl_versand_paket`
--
ALTER TABLE `tbl_versand_paket`
  MODIFY `IDVersandPaket` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT für Tabelle `tbl_zahlungsarten`
--
ALTER TABLE `tbl_zahlungsarten`
  MODIFY `IDZahlungsart` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `tbl_kunden`
--
ALTER TABLE `tbl_kunden`
  ADD CONSTRAINT `tbl_kunden_ibfk_1` FOREIGN KEY (`FIDStaat`) REFERENCES `tbl_staaten` (`IDStaat`) ON UPDATE CASCADE;

--
-- Constraints der Tabelle `tbl_positionen`
--
ALTER TABLE `tbl_positionen`
  ADD CONSTRAINT `tbl_positionen_ibfk_1` FOREIGN KEY (`FIDRechnung`) REFERENCES `tbl_rechnungen` (`IDRechnung`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tbl_positionen_ibfk_2` FOREIGN KEY (`FIDProdukt`) REFERENCES `tbl_produkte` (`IDProdukt`) ON UPDATE CASCADE;

--
-- Constraints der Tabelle `tbl_produkte`
--
ALTER TABLE `tbl_produkte`
  ADD CONSTRAINT `tbl_produkte_ibfk_1` FOREIGN KEY (`FIDUStSatz`) REFERENCES `tbl_ustsaetze` (`IDUStSatz`) ON UPDATE CASCADE;

--
-- Constraints der Tabelle `tbl_rechnungen`
--
ALTER TABLE `tbl_rechnungen`
  ADD CONSTRAINT `tbl_rechnungen_ibfk_1` FOREIGN KEY (`FIDKunde`) REFERENCES `tbl_kunden` (`IDKunde`) ON UPDATE CASCADE,
  ADD CONSTRAINT `tbl_rechnungen_ibfk_2` FOREIGN KEY (`FIDZahlungsart`) REFERENCES `tbl_zahlungsarten` (`IDZahlungsart`) ON UPDATE CASCADE,
  ADD CONSTRAINT `tbl_rechnungen_ibfk_3` FOREIGN KEY (`FIDVersandPaket`) REFERENCES `tbl_versand_paket` (`IDVersandPaket`) ON UPDATE CASCADE;

--
-- Constraints der Tabelle `tbl_versand_paket`
--
ALTER TABLE `tbl_versand_paket`
  ADD CONSTRAINT `tbl_versand_paket_ibfk_1` FOREIGN KEY (`FIDVersandart`) REFERENCES `tbl_versandarten` (`IDVersandart`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tbl_versand_paket_ibfk_2` FOREIGN KEY (`FIDPaket`) REFERENCES `tbl_paketgroessen` (`IDPaketgroesse`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tbl_versand_paket_ibfk_3` FOREIGN KEY (`FIDUStSatz`) REFERENCES `tbl_ustsaetze` (`IDUStSatz`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
