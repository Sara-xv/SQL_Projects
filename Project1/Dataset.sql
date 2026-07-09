-- Create table
CREATE TABLE Streaming_Logs (
    LogID INT PRIMARY KEY,
    UserID INT,
    Region VARCHAR(50),
    MovieTitle VARCHAR(100),
    WatchDuration_Min INT, -- Watch duration in minutes
    LogDate DATETIME
);

-- Insert sample data (including duplicates and ties for precise testing)
INSERT INTO Streaming_Logs VALUES 
-- Original rows
(101, 1, 'North America', 'Inception', 120, '2025-01-01 10:00'),
(102, 1, 'North America', 'Interstellar', 180, '2025-01-02 14:00'),
(103, 2, 'Europe', 'The Matrix', 150, '2025-01-01 09:00'),
(104, 2, 'Europe', 'The Matrix', 150, '2025-01-01 09:00'), -- Duplicate record for testing
(105, 3, 'Europe', 'Inception', 120, '2025-01-03 11:00'),
(106, 4, 'Asia', 'Parasite', 130, '2025-01-05 20:00'),
(107, 5, 'Asia', 'Parasite', 130, '2025-01-06 21:00'),
(108, 6, 'North America', 'Inception', 120, '2025-01-04 18:00'),
(109, 7, 'Europe', 'The Dark Knight', 150, '2025-01-07 10:00'),
(110, 8, 'Asia', 'The Matrix', 100, '2025-01-08 12:00'),

-- Additional rows for more comprehensive testing
(111, 9, 'South America', 'Inception', 135, '2025-01-09 15:30'),
(112, 10, 'North America', 'Interstellar', 169, '2025-01-10 20:00'),
(113, 11, 'Europe', 'Parasite', 132, '2025-01-11 19:45'),
(114, 12, 'Asia', 'The Dark Knight', 152, '2025-01-12 22:00'),
(115, 13, 'Africa', 'The Matrix', 110, '2025-01-13 14:15'),
(116, 14, 'Oceania', 'Inception', 148, '2025-01-14 16:20'),
(117, 1, 'North America', 'Tenet', 150, '2025-01-15 12:00'), -- Same UserID as 101
(118, 2, 'Europe', 'Tenet', 150, '2025-01-15 12:00'), -- Duplicate of 117 across users
(119, 15, 'Asia', 'Interstellar', 180, '2025-01-16 23:00'),
(120, 16, 'Europe', 'The Dark Knight', 152, '2025-01-17 09:30'),
(121, 17, 'North America', 'Parasite', 130, '2025-01-18 21:15'),
(122, 18, 'South America', 'The Matrix', 145, '2025-01-19 18:45'),
(123, 19, 'Africa', 'Inception', 120, '2025-01-20 13:10'),
(124, 20, 'Oceania', 'Interstellar', 169, '2025-01-21 11:25'),
(125, 21, 'Asia', 'Tenet', 150, '2025-01-22 17:30'),
(126, 22, 'Europe', 'The Matrix', 100, '2025-01-23 08:00'), -- Tied duration with row 110
(127, 23, 'North America', 'The Dark Knight', 150, '2025-01-24 20:40'),
(128, 24, 'South America', 'Parasite', 132, '2025-01-25 22:55'),
(129, 25, 'Africa', 'Tenet', 145, '2025-01-26 19:05'),
(130, 26, 'Oceania', 'The Matrix', 150, '2025-01-27 07:30'); -- Tied with rows 103,104,109,127
