-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 17. Apr 2023 um 12:08
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
-- Datenbank: `db_3443_newsforum`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tbl_eintraege`
--

CREATE TABLE `tbl_eintraege` (
  `IDEintrag` int(10) UNSIGNED NOT NULL,
  `FIDEintrag` int(10) UNSIGNED DEFAULT NULL,
  `FIDUser` int(10) UNSIGNED DEFAULT NULL,
  `Eintrag` text NOT NULL,
  `Eintragezeitpunkt` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `tbl_eintraege`
--

INSERT INTO `tbl_eintraege` (`IDEintrag`, `FIDEintrag`, `FIDUser`, `Eintrag`, `Eintragezeitpunkt`) VALUES
(1, NULL, 1, 'Hier ein paar Verhaltensregeln: ...', '2021-10-27 06:21:01'),
(3, 1, 3, 'Danke für Deine Ausführungen. Was mich dabei noch etwas stört, ist die Vorgabe so vieler Regeln. Könnte man das nicht einfacher gestalten?', '2021-10-27 06:23:06'),
(4, 1, 4, 'Hey, das ist eine gute Idee. Ich finde auch, dass man sich in einem Forum an gewisse Regeln halten sollte. Eine Erweiterung wäre etwa die Netiquette.', '2021-10-27 06:23:59'),
(5, 3, 4, 'Was stört Dich daran so sehr? Es ist doch legitim, dass wenn man ein Forum betreibt, auch Regeln vorgibt. Meine Meinung.', '2021-10-27 06:24:49'),
(6, 5, 3, 'Hmmm, ja, das schon. Aber die schiere Menge...?', '2021-10-27 06:25:19'),
(7, 6, 4, 'Da hast Du auch nicht unrecht... :-)', '2021-10-27 06:25:43'),
(8, NULL, 3, 'Hi zusammen, ich bin schon länger am Grübeln, ob ich mir ein neues Mountainbike oder ein neues Rennrad zulegen soll. Beide haben ihre Vor- und Nachteile, und beides macht mir Spaß. Wie seht Ihr das: was ist Euer Favorite?', '2021-10-27 06:27:08'),
(9, 8, 2, 'Ich bin eher der MTB-Typ. Berge, Abfahrten, und einfach viel mehr Natur.', '2021-10-27 06:28:39'),
(10, 8, 1, 'Rennrad. Ganz klar. Straßen haben wir alle direkt vor der Haustüre, und außerdem ist der Trainingseffekt viel besser kontrollierbar.', '2021-10-27 06:29:30'),
(11, 9, 1, '...obwohl das mit der Natur hat natürlich auch was für sich. Stimmt schon.', '2021-10-27 06:30:01'),
(12, 8, 4, 'Rennrad, Rennrad, Rennrad!', '2021-10-27 06:30:26'),
(13, 12, 1, 'Hahahahaaaaa! :-D', '2021-10-27 06:30:45'),
(14, 1, 2, 'Du sprichst mir aus der Seele. Ich denke auch, dass ein Forum nur dann Sinn macht, wenn es hier freundlich abläuft und es keine Gehässigkeiten gibt.', '2021-10-27 06:31:35'),
(15, 14, 3, 'Stimmt. Ich gebe mich geschlagen. Bleiben wir dabei.', '2021-10-27 06:32:03'),
(16, 15, 4, 'Top!', '2021-10-27 06:32:17');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tbl_user`
--

CREATE TABLE `tbl_user` (
  `IDUser` int(10) UNSIGNED NOT NULL,
  `Emailadresse` varchar(64) NOT NULL,
  `Passwort` varchar(255) NOT NULL,
  `Vorname` varchar(32) DEFAULT NULL,
  `Nachname` varchar(32) DEFAULT NULL,
  `GebDatum` date DEFAULT NULL,
  `RegZeitpunkt` timestamp NOT NULL DEFAULT current_timestamp(),
  `letzterLogin` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `tbl_user`
--

INSERT INTO `tbl_user` (`IDUser`, `Emailadresse`, `Passwort`, `Vorname`, `Nachname`, `GebDatum`, `RegZeitpunkt`, `letzterLogin`) VALUES
(1, 'uwe.mutz@syne.at', 'test123', 'Uwe', 'Mutz', '1972-10-17', '2023-04-17 09:25:29', '2023-04-17 02:22:54'),
(2, 'superkicker@kicker.at', 'test789', 'Uwe', NULL, NULL, '2023-04-17 09:25:29', NULL),
(3, 'silvia.mutz@syne.at', 'test456', 'Silvia', 'Mutz', '1978-05-02', '2023-04-17 09:12:54', '2023-04-17 09:18:54'),
(4, 'berti@test.at', 'test012', 'Bertl', 'Braun', NULL, '2023-04-17 09:25:29', NULL);

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `tbl_eintraege`
--
ALTER TABLE `tbl_eintraege`
  ADD PRIMARY KEY (`IDEintrag`),
  ADD KEY `FIDEintrag` (`FIDEintrag`),
  ADD KEY `FIDUser` (`FIDUser`);

--
-- Indizes für die Tabelle `tbl_user`
--
ALTER TABLE `tbl_user`
  ADD PRIMARY KEY (`IDUser`),
  ADD UNIQUE KEY `Emailadresse` (`Emailadresse`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `tbl_eintraege`
--
ALTER TABLE `tbl_eintraege`
  MODIFY `IDEintrag` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT für Tabelle `tbl_user`
--
ALTER TABLE `tbl_user`
  MODIFY `IDUser` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `tbl_eintraege`
--
ALTER TABLE `tbl_eintraege`
  ADD CONSTRAINT `tbl_eintraege_ibfk_1` FOREIGN KEY (`FIDEintrag`) REFERENCES `tbl_eintraege` (`IDEintrag`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tbl_eintraege_ibfk_2` FOREIGN KEY (`FIDUser`) REFERENCES `tbl_user` (`IDUser`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
