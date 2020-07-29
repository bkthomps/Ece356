USE CHESS;

-- 1. What fraction of games does white win? 0.4593
SELECT (
	SELECT COUNT(*)
    FROM Main
    WHERE winner='white' AND (victoryStatus='mate' OR victoryStatus='resign')
) / COUNT(*) AS ratio FROM Main;

-- 2. What's the average number of moves when white wins? And if black wins? 56.5735, 59.7762
SELECT AVG(turns)
FROM Main
WHERE winner='white' AND (victoryStatus='mate' OR victoryStatus='resign')
UNION
SELECT AVG(turns)
FROM Main
WHERE winner='black' AND (victoryStatus='mate' OR victoryStatus='resign');

-- 3. What fraction of games start with a pawn move? 0.9466
SELECT (
	SELECT COUNT(*)
    FROM Main
    INNER JOIN Ply USING (gameID)
		WHERE turn=1 AND NOT move REGEXP '^(N|B|R|Q|K)'
) / COUNT(*) AS ratio FROM Main;

-- 4. How many moves does white make before moving knight? Bishop? Rooks (including castles)? 4.2313, 7.1957, 17.6357
SELECT AVG(minTurn) AS whiteAverage
FROM Main
INNER JOIN (
	SELECT gameID, MIN(turn) AS minTurn
    FROM Ply
	WHERE move REGEXP '^N'
    GROUP BY (gameID)
) A USING (gameID)
WHERE winner='white'
UNION
SELECT AVG(minTurn) AS whiteAverage
FROM Main
INNER JOIN (
	SELECT gameID, MIN(turn) AS minTurn
    FROM Ply
	WHERE move REGEXP '^B'
    GROUP BY (gameID)
) A USING (gameID)
WHERE winner='white'
UNION
SELECT AVG(minTurn) AS whiteAverage
FROM Main
INNER JOIN (
	SELECT gameID, MIN(turn) AS minTurn
    FROM Ply
	WHERE move REGEXP '^(R|(O-O))'
    GROUP BY (gameID)
) A USING (gameID)
WHERE winner='white';

-- 5. Same as 4 but black? 4.2785, 7.1044, 17.8067
SELECT AVG(minTurn) AS blackAverage
FROM Main
INNER JOIN (
	SELECT gameID, MIN(turn) AS minTurn
    FROM Ply
	WHERE move REGEXP '^N'
    GROUP BY (gameID)
) A USING (gameID)
WHERE winner='black'
UNION
SELECT AVG(minTurn) AS blackAverage
FROM Main
INNER JOIN (
	SELECT gameID, MIN(turn) AS minTurn
    FROM Ply
	WHERE move REGEXP '^B'
    GROUP BY (gameID)
) A USING (gameID)
WHERE winner='black'
UNION
SELECT AVG(minTurn) AS blackAverage
FROM Main
INNER JOIN (
	SELECT gameID, MIN(turn) AS minTurn
    FROM Ply
	WHERE move REGEXP '^(R|(O-O))'
    GROUP BY (gameID)
) A USING (gameID)
WHERE winner='black';
