-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 21. Mrz 2023 um 10:43
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
-- Datenbank: `db_3443_musikverwaltung`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tbl_alben`
--

CREATE TABLE `tbl_alben` (
  `IDAlbum` int(10) UNSIGNED NOT NULL,
  `FIDInterpret` int(10) UNSIGNED NOT NULL,
  `Albumtitel` varchar(128) NOT NULL,
  `Erscheinungsjahr` year(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `tbl_alben`
--

INSERT INTO `tbl_alben` (`IDAlbum`, `FIDInterpret`, `Albumtitel`, `Erscheinungsjahr`) VALUES
(1, 2, 'Nevermind', 1991),
(2, 2, 'Bleach', 1989),
(3, 1, 'Black Album', 1994),
(4, 3, 'Follow the Leader', 1998);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tbl_interpreten`
--

CREATE TABLE `tbl_interpreten` (
  `IDInterpret` int(10) UNSIGNED NOT NULL,
  `Interpret` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `tbl_interpreten`
--

INSERT INTO `tbl_interpreten` (`IDInterpret`, `Interpret`) VALUES
(1, 'Metallica'),
(2, 'Nirvana'),
(3, 'Korn');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tbl_songs`
--

CREATE TABLE `tbl_songs` (
  `IDSong` int(10) UNSIGNED NOT NULL,
  `FIDAlbum` int(10) UNSIGNED NOT NULL,
  `Songtitel` varchar(128) NOT NULL,
  `Reihenfolge` tinyint(2) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `tbl_songs`
--

INSERT INTO `tbl_songs` (`IDSong`, `FIDAlbum`, `Songtitel`, `Reihenfolge`) VALUES
(1, 1, 'Smells like Teen Spirit', 1),
(2, 1, 'Im Bloom', 2),
(3, 1, 'Come as you are', 3),
(4, 1, 'Breed', 4),
(5, 1, 'Lithium', 5),
(6, 1, 'Polly', 6),
(7, 1, 'Territorial Pissings', 7),
(8, 1, 'Drain you', 8),
(9, 1, 'Lounge Act', 9),
(10, 1, 'Stay away', 10),
(11, 1, 'On a Plain', 11),
(12, 1, 'Something in the way', 12),
(13, 2, 'Blew', 1),
(14, 2, 'Floyd the Barber', 2),
(15, 2, 'About a Girl', 3),
(16, 2, 'School', 4),
(17, 2, 'Love Buzz', 5),
(18, 2, 'Paper Cuts', 6),
(19, 2, 'Negative Creep', 7),
(20, 2, 'Scoff', 8),
(21, 2, 'Swap Meet', 9),
(22, 2, 'Mr. Moustache', 10),
(23, 2, 'Sifting', 11),
(24, 2, 'Big Cheese', 12),
(25, 2, 'Downer', 13),
(26, 3, 'Enter Sandman', 1),
(27, 3, 'Sad but true', 2),
(28, 3, 'Holier than thou', 3),
(29, 3, 'The Unforgiven', 4),
(30, 3, 'Wherever I may roam', 5),
(31, 3, 'Don\'t tread on me', 6),
(32, 3, 'Through the Never', 7),
(33, 3, 'Nothing else matters', 8),
(34, 3, 'Of Wolf and Man', 9),
(35, 3, 'The God that failed', 10),
(36, 3, 'My Friend of Misery', 11),
(37, 3, 'The Struggle within', 12),
(38, 4, 'Untitled 01', 1),
(39, 4, 'Untitled 02', 2),
(40, 4, 'Untitled 03', 3),
(41, 4, 'Untitled 04', 4),
(42, 4, 'Untitled 05', 5),
(43, 4, 'Untitled 06', 6),
(44, 4, 'Untitled 07', 7),
(45, 4, 'Untitled 08', 8),
(46, 4, 'Untitled 09', 9),
(47, 4, 'Untitled 10', 10),
(48, 4, 'Untitled 11', 11),
(49, 4, 'Untitled 12', 12),
(50, 4, 'It\'s on!', 13),
(51, 4, 'Freak on a Leash', 14),
(52, 4, 'Got the Life', 15),
(53, 4, 'Dead Bodies everywhere', 16),
(54, 4, 'Children of the KoRn', 17),
(55, 4, 'B.B.K.', 18),
(56, 4, 'Pretty', 19),
(57, 4, 'All in the Family', 20),
(58, 4, 'Reclaim my Place', 21),
(59, 4, 'Justin', 22),
(60, 4, 'Seed', 23),
(61, 4, 'Camelitosis', 24),
(62, 4, 'My Gift to you', 25),
(63, 4, 'Earache my Eye', 26);

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `tbl_alben`
--
ALTER TABLE `tbl_alben`
  ADD PRIMARY KEY (`IDAlbum`),
  ADD KEY `FIDInterpret` (`FIDInterpret`);

--
-- Indizes für die Tabelle `tbl_interpreten`
--
ALTER TABLE `tbl_interpreten`
  ADD PRIMARY KEY (`IDInterpret`);

--
-- Indizes für die Tabelle `tbl_songs`
--
ALTER TABLE `tbl_songs`
  ADD PRIMARY KEY (`IDSong`),
  ADD KEY `FIDAlbum` (`FIDAlbum`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `tbl_alben`
--
ALTER TABLE `tbl_alben`
  MODIFY `IDAlbum` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT für Tabelle `tbl_interpreten`
--
ALTER TABLE `tbl_interpreten`
  MODIFY `IDInterpret` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT für Tabelle `tbl_songs`
--
ALTER TABLE `tbl_songs`
  MODIFY `IDSong` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `tbl_alben`
--
ALTER TABLE `tbl_alben`
  ADD CONSTRAINT `tbl_alben_ibfk_1` FOREIGN KEY (`FIDInterpret`) REFERENCES `tbl_interpreten` (`IDInterpret`) ON UPDATE CASCADE;

--
-- Constraints der Tabelle `tbl_songs`
--
ALTER TABLE `tbl_songs`
  ADD CONSTRAINT `tbl_songs_ibfk_1` FOREIGN KEY (`FIDAlbum`) REFERENCES `tbl_alben` (`IDAlbum`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
