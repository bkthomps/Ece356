USE `BASEBALL`;

SET NAMES utf8mb4;

-- 3a) How many players have an unknown birthdate? (449)
SELECT COUNT(*)
	FROM `Master`
	WHERE `birthDay` = 0 or `birthMonth` = 0 or `birthYear` = 0;

-- 3b) How many people are in the Hall of Fame? (317)
SELECT COUNT(*)
	FROM `HallOfFame`
    WHERE `inducted` = 'Y';
-- What fraction of each category of person are in the Hall Of Fame? (250 player, 23 manager, 10 umpire, 34 pioneer/executive)
SELECT COUNT(*)
	FROM `HallOfFame`
	WHERE `inducted` = 'Y' and `category` = "Player";
SELECT COUNT(*)
	FROM `HallOfFame`
	WHERE `inducted` = 'Y' and `category` = "Manager";
SELECT COUNT(*)
	FROM `HallOfFame`
	WHERE `inducted` = 'Y' and `category` = "Umpire";
SELECT COUNT(*)
	FROM `HallOfFame`
	WHERE `inducted` = 'Y' and `category` = "Pioneer/Executive";
-- Are more people in the Hall Of Fame alive or dead? (74 alive, 243 dead)
SELECT COUNT(*)
	FROM `HallOfFame` A
    LEFT JOIN `Master` B
    ON A.playerID = B.playerID
    WHERE `inducted` = 'Y' and `deathYear` = '' and `deathMonth` = '' and `deathDay` = ''
		and `deathCountry` = '' and `deathState` = '' and `deathCity` = '';
SELECT COUNT(*)
	FROM `HallOfFame` A
    LEFT JOIN `Master` B
    ON A.playerID = B.playerID
    WHERE `inducted` = 'Y' and (`deathYear` != '' or `deathMonth` != '' or `deathDay` != ''
		or `deathCountry` != '' or `deathState` != '' or `deathCity` != '');
-- Does this vary by category? (65 alive players, 185 dead players, 5 alive managers, 18 dead managers, 1 alive umpire, 9 dead umpires, 3 alive pioneers/executives, 31 dead pioneers/executives)
SELECT COUNT(*)
	FROM `HallOfFame` A
    LEFT JOIN `Master` B
    ON A.playerID = B.playerID
    WHERE `inducted` = 'Y' and (`deathYear` = '' and `deathMonth` = '' and `deathDay` = ''
		and `deathCountry` = '' and `deathState` = '' and `deathCity` = '')
        and `category` = "Player";
SELECT COUNT(*)
	FROM `HallOfFame` A
    LEFT JOIN `Master` B
    ON A.playerID = B.playerID
    WHERE `inducted` = 'Y' and (`deathYear` != '' or `deathMonth` != '' or `deathDay` != ''
		or `deathCountry` != '' or `deathState` != '' or `deathCity` != '')
        and `category` = "Player";
SELECT COUNT(*)
	FROM `HallOfFame` A
    LEFT JOIN `Master` B
    ON A.playerID = B.playerID
    WHERE `inducted` = 'Y' and (`deathYear` = '' and `deathMonth` = '' and `deathDay` = ''
		and `deathCountry` = '' and `deathState` = '' and `deathCity` = '')
        and `category` = "Manager";
SELECT COUNT(*)
	FROM `HallOfFame` A
    LEFT JOIN `Master` B
    ON A.playerID = B.playerID
    WHERE `inducted` = 'Y' and (`deathYear` != '' or `deathMonth` != '' or `deathDay` != ''
		or `deathCountry` != '' or `deathState` != '' or `deathCity` != '')
        and `category` = "Manager";
SELECT COUNT(*)
	FROM `HallOfFame` A
    LEFT JOIN `Master` B
    ON A.playerID = B.playerID
    WHERE `inducted` = 'Y' and (`deathYear` = '' and `deathMonth` = '' and `deathDay` = ''
		and `deathCountry` = '' and `deathState` = '' and `deathCity` = '')
        and `category` = "Umpire";
SELECT COUNT(*)
	FROM `HallOfFame` A
    LEFT JOIN `Master` B
    ON A.playerID = B.playerID
    WHERE `inducted` = 'Y' and (`deathYear` != '' or `deathMonth` != '' or `deathDay` != ''
		or `deathCountry` != '' or `deathState` != '' or `deathCity` != '')
        and `category` = "Umpire";
SELECT COUNT(*)
	FROM `HallOfFame` A
    LEFT JOIN `Master` B
    ON A.playerID = B.playerID
    WHERE `inducted` = 'Y' and (`deathYear` = '' and `deathMonth` = '' and `deathDay` = ''
		and `deathCountry` = '' and `deathState` = '' and `deathCity` = '')
        and `category` = "Pioneer/Executive";
SELECT COUNT(*)
	FROM `HallOfFame` A
    LEFT JOIN `Master` B
    ON A.playerID = B.playerID
    WHERE `inducted` = 'Y' and (`deathYear` != '' or `deathMonth` != '' or `deathDay` != ''
		or `deathCountry` != '' or `deathState` != '' or `deathCity` != '')
        and `category` = "Pioneer/Executive";

-- 3c) What are the names and total pay (individually) of the three people with the three largest total salaries?
-- (Alexander Enmanuel Rodriguez - 398416252, Derek Sanderson Jeter - 264618093, Mark Charles Teixeira - 214275000)
SELECT `nameGiven`, `nameLast`, `SUM(salary)`
	FROM (
		SELECT `playerId`, SUM(salary)
		FROM `Salaries`
		GROUP BY `playerID`
	) A
    LEFT JOIN `Master` B
    ON A.playerID = B.playerID
    ORDER BY `SUM(salary)` DESC
    LIMIT 3;
-- What category are these people? (They are all players)
SELECT C.`nameGiven`, C.`nameLast`, `SUM(salary)` FROM
	(SELECT A.`playerID`, `nameGiven`, `nameLast`, `SUM(salary)`
		FROM (
			SELECT `playerId`, SUM(salary)
			FROM `Salaries`
			GROUP BY `playerID`
		) A
		LEFT JOIN `Master` B
		ON A.playerID = B.playerID
		ORDER BY `SUM(salary)` DESC
		LIMIT 3) C
	INNER JOIN `Master` D
    ON C.playerID = D.playerID;
-- What are the top three in the other categories?
-- Players -> (Alexander Enmanuel Rodriguez - 398416252, Derek Sanderson Jeter - 264618093, Mark Charles Teixeira - 214275000)
-- Managers -> (Matthew Derrick Williams - 78860000, Robin Mark Ventura - 67135000, Paul Leo Molitor - 38116666)
-- Others -> (sabatc.01 - 25000000, rosajo01 - 12500000, dicker.01 - 12000000)
SELECT C.`nameGiven`, C.`nameLast`, `SUM(salary)` FROM
	(SELECT A.`playerID`, `nameGiven`, `nameLast`, `SUM(salary)`
		FROM (
			SELECT `playerId`, SUM(salary)
			FROM `Salaries`
			GROUP BY `playerID`
		) A
		LEFT JOIN `Master` B
		ON A.playerID = B.playerID) C
	INNER JOIN `Master` D
    ON C.playerID = D.playerID
	ORDER BY `SUM(salary)` DESC
	LIMIT 3;
SELECT C.`nameGiven`, C.`nameLast`, `SUM(salary)` FROM
	(SELECT A.`playerID`, `nameGiven`, `nameLast`, `SUM(salary)`
		FROM (
			SELECT `playerId`, SUM(salary)
			FROM `Salaries`
			GROUP BY `playerID`
		) A
		LEFT JOIN `Master` B
		ON A.playerID = B.playerID) C
	INNER JOIN (
		SELECT `playerID`
        FROM `Managers`
        GROUP BY `playerID`
	) D
    ON C.playerID = D.playerID
	ORDER BY `SUM(salary)` DESC
    LIMIT 3;
SELECT A.`playerID`, `SUM(salary)`
	FROM (
		SELECT `playerId`, SUM(salary)
		FROM `Salaries`
		GROUP BY `playerID`
	) A
    LEFT JOIN (
		SELECT `playerId`
		FROM `Master`
		UNION SELECT `playerId`
		FROM `Managers`) B
    ON A.playerID = B.playerID
    WHERE B.playerID is NULL
    ORDER BY `SUM(salary)` DESC
    LIMIT 3;

-- 3d) What is the average number of Home Runs a player has? (15.3419)
SELECT AVG(`totalHR`)
	FROM (
		SELECT `playerID`, `totalHR`
		FROM (
			SELECT A.`playerId`, IFNULL(regHR, 0) + IFNULL(postHR, 0) as totalHR
			FROM (
				SELECT `playerId`, SUM(HR) as regHR
				FROM `Batting`
				GROUP BY `playerID`
			) A
			LEFT JOIN (
				SELECT `playerId`, SUM(HR) as postHR
				FROM `BattingPost`
				GROUP BY `playerID`
			) B
			ON A.playerID = B.playerID
		) X
		UNION
		SELECT `playerID`, `totalHR`
		FROM (
			SELECT C.`playerId`, IFNULL(regHR, 0) + IFNULL(postHR, 0) as totalHR
			FROM (
				SELECT `playerId`, SUM(HR) as regHR
				FROM `Batting`
				GROUP BY `playerID`
			) C
			RIGHT JOIN (
				SELECT `playerId`, SUM(HR) as postHR
				FROM `BattingPost`
				GROUP BY `playerID`
			) D
			ON C.playerID = D.playerID
		) Y
	) Z;

-- 3e) If we only count players who got at least 1 Home Run, what is the average number of Home Runs a player has? (37.4830)
SELECT AVG(`totalHR`)
	FROM (
		SELECT `playerID`, `totalHR`
		FROM (
			SELECT A.`playerId`, IFNULL(regHR, 0) + IFNULL(postHR, 0) as totalHR
			FROM (
				SELECT `playerId`, SUM(HR) as regHR
				FROM `Batting`
				GROUP BY `playerID`
			) A
			LEFT JOIN (
				SELECT `playerId`, SUM(HR) as postHR
				FROM `BattingPost`
				GROUP BY `playerID`
			) B
			ON A.playerID = B.playerID
		) X
		UNION
		SELECT `playerID`, `totalHR`
		FROM (
			SELECT C.`playerId`, IFNULL(regHR, 0) + IFNULL(postHR, 0) as totalHR
			FROM (
				SELECT `playerId`, SUM(HR) as regHR
				FROM `Batting`
				GROUP BY `playerID`
			) C
			RIGHT JOIN (
				SELECT `playerId`, SUM(HR) as postHR
				FROM `BattingPost`
				GROUP BY `playerID`
			) D
			ON C.playerID = D.playerID
		) Y
	) Z
    WHERE totalHR > 0;

-- 3f) If we define a player as a good batter if they have more than the average number of Home Runs,
-- and a player is a good Pitcher if they have more than the average number of ShutOut games, then
-- how many players are both good batters and good pitchers? (39)
SELECT AVG(`totalSHO`)  -- Determined the average amount of ShutOut games (2.1835)
	FROM (
		SELECT `playerID`, `totalSHO`
		FROM (
			SELECT A.`playerId`, IFNULL(regSHO, 0) + IFNULL(postSHO, 0) as totalSHO
			FROM (
				SELECT `playerId`, SUM(SHO) as regSHO
				FROM `Pitching`
				GROUP BY `playerID`
			) A
			LEFT JOIN (
				SELECT `playerId`, SUM(SHO) as postSHO
				FROM `PitchingPost`
				GROUP BY `playerID`
			) B
			ON A.playerID = B.playerID
		) X
		UNION
		SELECT `playerID`, `totalSHO`
		FROM (
			SELECT C.`playerId`, IFNULL(regSHO, 0) + IFNULL(postSHO, 0) as totalSHO
			FROM (
				SELECT `playerId`, SUM(SHO) as regSHO
				FROM `Pitching`
				GROUP BY `playerID`
			) C
			RIGHT JOIN (
				SELECT `playerId`, SUM(SHO) as postSHO
				FROM `PitchingPost`
				GROUP BY `playerID`
			) D
			ON C.playerID = D.playerID
		) Y
	) Z;

SELECT COUNT(`playerID`)
	FROM (
		SELECT AA.`playerId`, `totalHR`, `totalSHO`
		FROM (
			SELECT `playerID`, `totalHR`
			FROM (
				SELECT A.`playerId`, IFNULL(regHR, 0) + IFNULL(postHR, 0) as totalHR
				FROM (
					SELECT `playerId`, SUM(HR) as regHR
					FROM `Batting`
					GROUP BY `playerID`
				) A
				LEFT JOIN (
					SELECT `playerId`, SUM(HR) as postHR
					FROM `BattingPost`
					GROUP BY `playerID`
				) B
				ON A.playerID = B.playerID
			) X
			UNION
			SELECT `playerID`, `totalHR`
			FROM (
				SELECT C.`playerId`, IFNULL(regHR, 0) + IFNULL(postHR, 0) as totalHR
				FROM (
					SELECT `playerId`, SUM(HR) as regHR
					FROM `Batting`
					GROUP BY `playerID`
				) C
				RIGHT JOIN (
					SELECT `playerId`, SUM(HR) as postHR
					FROM `BattingPost`
					GROUP BY `playerID`
				) D
				ON C.playerID = D.playerID
			) Y
		) AA
		INNER JOIN (
			SELECT `playerID`, `totalSHO`
			FROM (
				SELECT A.`playerId`, IFNULL(regSHO, 0) + IFNULL(postSHO, 0) as totalSHO
				FROM (
					SELECT `playerId`, SUM(SHO) as regSHO
					FROM `Pitching`
					GROUP BY `playerID`
				) A
				LEFT JOIN (
					SELECT `playerId`, SUM(SHO) as postSHO
					FROM `PitchingPost`
					GROUP BY `playerID`
				) B
				ON A.playerID = B.playerID
			) X
			UNION
			SELECT `playerID`, `totalSHO`
			FROM (
				SELECT C.`playerId`, IFNULL(regSHO, 0) + IFNULL(postSHO, 0) as totalSHO
				FROM (
					SELECT `playerId`, SUM(SHO) as regSHO
					FROM `Pitching`
					GROUP BY `playerID`
				) C
				RIGHT JOIN (
					SELECT `playerId`, SUM(SHO) as postSHO
					FROM `PitchingPost`
					GROUP BY `playerID`
				) D
				ON C.playerID = D.playerID
			) Y
		) BB
		ON AA.playerID = BB.playerID
	) ZZ
    WHERE totalHR > 15.3419 and totalSHO > 2.1835;
