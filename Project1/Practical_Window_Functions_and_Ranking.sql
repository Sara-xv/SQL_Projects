--1
-- Task: For each user, find the first movie they have watched
SELECT 
	I.UserID,
	I.MovieTitle
FROM(SELECT
	*,
	ROW_NUMBER() OVER(PARTITION BY S.UserID ORDER BY S.LogDate ASC ) Rank_per_customer
FROM Streaming_Logs S)I
WHERE I.Rank_per_customer = 1

--2
--Write a query that returns all columns but removes completely duplicate records.

WITH CTE AS (
    SELECT DISTINCT *,
    ROW_NUMBER() OVER(
               PARTITION BY UserID, Region, MovieTitle, WatchDuration_Min, LogDate
               ORDER BY LogID
           ) R
    FROM Streaming_Logs 
)
SELECT *
FROM CTE
WHERE R = 1
--3
/* In each region, rank movies based on the total watch duration.
If two movies have the same total duration, they should receive the same rank and the next rank should have a gap.*/

WITH MovieStats AS (
    SELECT
        Region,
        MovieTitle,
        SUM(WatchDuration_Min) TotalWatch
    FROM Streaming_Logs
    GROUP BY Region, MovieTitle
)
SELECT
    *,
    RANK() OVER(PARTITION BY Region ORDER BY TotalWatch DESC)  MovieRank
FROM MovieStats

--4
/*
We want to award medals (gold, silver, bronze) to users with the highest watch time. 
If multiple users have the same watch time, they should all receive the same medal, 
and the next user should immediately receive the next medal (without gaps in rank). */

SELECT
	II.UserID,
	II.TTPC [Wach Time],
	II.WatchRank,
	CASE
	WHEN II.WatchRank = 1 THEN 'GOLD'
	WHEN II.WatchRank = 2 THEN 'SILVER'
	WHEN II.WatchRank = 3 THEN 'BRONZE'
	ELSE NULL
	END  Model
FROM(SELECT	
	*,
	DENSE_RANK() OVER(ORDER BY I.TTPC DESC ) WatchRank
FROM(SELECT
	*,
	SUM(S.WatchDuration_Min) OVER(PARTITION BY S.UserID) TTPC --total timer per customer
FROM Streaming_Logs S )I)II

--5
/*Prepare a list that includes user name, movie name, and 
"the user's watch session number" (e.g., the first movie user X watched is number 1, the second movie is number 2, etc.). */

SELECT
	*,
	ROW_NUMBER() OVER(PARTITION BY S.UserID ORDER BY S.LogDate ) [Session Sequencing]
FROM Streaming_Logs S
