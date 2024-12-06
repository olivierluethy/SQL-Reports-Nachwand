DROP DATABASE IF EXISTS iNFIGO;
CREATE DATABASE iNFIGO;
USE iNFIGO;

CREATE TABLE Instanz (
  InstanzId INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL,
  `use` VARCHAR(255) NOT NULL
);

CREATE TABLE Report (
  ReportId INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL,
  report VARCHAR(50) NOT NULL,
  entscheidungsdatum DATE NOT NULL,
  fk_instanzId INT,
  FOREIGN KEY (fk_instanzId) REFERENCES Instanz(InstanzId)
);

-- Einträge in die Tabelle Instanz
INSERT INTO Instanz (name, `use`) VALUES
  ('Instanz 1', 'Produktion'),
  ('Instanz 2', 'Entwicklung'),
  ('Instanz 3', 'Test'),
  ('Instanz 4', 'Produktion'),
  ('Instanz 5', 'Entwicklung'),
  ('Instanz 6', 'Test'),
  ('Instanz 7', 'Produktion'),
  ('Instanz 8', 'Entwicklung'),
  ('Instanz 9', 'Test'),
  ('Instanz 10', 'Produktion');

-- Einträge in die Tabelle Report
INSERT INTO Report (name, report, entscheidungsdatum, fk_instanzId) VALUES
  ('Report 1', 'Monatlicher Bericht', '2024-06-01', 1),
  ('Report 2', 'Wöchentlicher Bericht', '2024-06-05', 2),
  ('Report 3', 'Täglicher Bericht', '2024-06-06', 3),
  ('Report 4', 'Jährlicher Bericht', '2024-01-01', 4),
  ('Report 5', 'Quartalsbericht', '2024-03-31', 5),
  ('Report 6', 'Monatlicher Bericht', '2024-06-01', 6),
  ('Report 7', 'Wöchentlicher Bericht', '2024-06-05', 7),
  ('Report 8', 'Täglicher Bericht', '2024-06-06', 8),
  ('Report 9', 'Jährlicher Bericht', '2024-01-01', 9),
  ('Report 10', 'Quartalsbericht', '2024-03-31', 1),
  ('Report 11', 'Monatlicher Bericht', '2024-06-01', 2),
  ('Report 12', 'Wöchentlicher Bericht', '2024-06-05', 3),
  ('Report 13', 'Täglicher Bericht', '2024-06-06', 4),
  ('Report 14', 'Jährlicher Bericht', '2024-01-01', 5),
  ('Report 15', 'Quartalsbericht', '2024-03-31', 6),
  ('Report 16', 'Monatlicher Bericht', '2024-06-01', NULL),
  ('Report 17', 'Wöchentlicher Bericht', '2024-06-05', NULL),
  ('Report 18', 'Täglicher Bericht', '2024-06-06', NULL),
  ('Report 19', 'Jährlicher Bericht', '2024-01-01', NULL),
  ('Report 20', 'Quartalsbericht', '2024-03-31', NULL);
  
/* SELECT Instanz.name, COUNT(ReportId) AS "Anzahl Reports" FROM Instanz
INNER JOIN Report ON Instanz.InstanzId = Report.fk_instanzId
GROUP BY instanz.name */

/* https://www.blackbox.ai/share/3376ce0b-38eb-4b82-a42e-c58ba2a0a698 */

/* Anzahl an Reports pro Instanz */
SELECT 
  Instanz.name, 
  COALESCE(COUNT(Report.ReportId), 0) AS Anzahl_Reports
FROM 
  Instanz
  LEFT JOIN Report ON Instanz.InstanzId = Report.fk_instanzId
GROUP BY 
  Instanz.name
  
/* Anzahl an Reports nach einem bestimmten Datum, alle anderen werden ausgeblendet */
SELECT 
  Instanz.name, 
  COALESCE(COUNT(Report.ReportId), 0) AS Anzahl_Reports
FROM 
  Instanz
  LEFT JOIN Report ON Instanz.InstanzId = Report.fk_instanzId
  
  WHERE entscheidungsdatum BETWEEN '2024-03-01' AND '2024-03-31'
GROUP BY 
  Instanz.name
  
/* Anzahl an Reports nach einem bestimmten Datum, nichts wird ausgeblendet da der Rest 0 ist */
SELECT
    Instanz.name,
    Instanz.use AS Beschreibung
    COUNT(Report.ReportId) AS Anzahl_Reports
FROM
    Instanz
LEFT JOIN Report ON Instanz.InstanzId = Report.fk_instanzId
    AND Report.entscheidungsdatum BETWEEN '2024-03-01' AND '2024-03-31'
GROUP BY
    Instanz.name;
    
/* Anzahl an Reports gegliedert anhand von verschiedenen Zeitspannen */
SELECT
    Instanz.name AS Instanz,
    Instanz.use AS Beschreibung,
    COUNT(CASE 
        WHEN Report.entscheidungsdatum BETWEEN '2024-03-01' AND '2024-05-31' THEN 1 
    END) AS "0-3",
    COUNT(CASE 
        WHEN Report.entscheidungsdatum BETWEEN '2024-06-01' AND '2024-08-31' THEN 1 
    END) AS "3-6",
    COUNT(CASE 
        WHEN Report.entscheidungsdatum BETWEEN '2024-09-01' AND '2024-11-30' THEN 1 
    END) AS "6-9",
    COUNT(CASE 
        WHEN Report.entscheidungsdatum BETWEEN '2024-12-01' AND '2025-02-30' THEN 1 
    END) AS "9-12"
FROM
    Instanz
LEFT JOIN Report 
    ON Instanz.InstanzId = Report.fk_instanzId
GROUP BY
    Instanz.name, Instanz.use
ORDER BY instanz.name ASC

/* Mit der entsprechenden Sortierung */
SELECT
    Instanz.name AS Instanz,
    Instanz.use AS Beschreibung,
    COUNT(CASE 
        WHEN Report.entscheidungsdatum BETWEEN '2024-03-01' AND '2024-05-31' THEN 1 
    END) AS "0-3",
    COUNT(CASE 
        WHEN Report.entscheidungsdatum BETWEEN '2024-06-01' AND '2024-08-31' THEN 1 
    END) AS "3-6",
    COUNT(CASE 
        WHEN Report.entscheidungsdatum BETWEEN '2024-09-01' AND '2024-11-30' THEN 1 
    END) AS "6-9",
    COUNT(CASE 
        WHEN Report.entscheidungsdatum BETWEEN '2024-12-01' AND '2025-02-30' THEN 1 
    END) AS "9-12"
FROM
    Instanz
LEFT JOIN Report 
    ON Instanz.InstanzId = Report.fk_instanzId
GROUP BY
    Instanz.name, Instanz.use
ORDER BY
    CAST(SUBSTRING(Instanz.name, 8, LENGTH(Instanz.name)) AS UNSIGNED);
