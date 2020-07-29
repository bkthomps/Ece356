USE BASEBALL;
-- setup this db from my assignment 1 because my chosen foreign keys might alter from yours

-- Do the following from MySQL Server terminal as a one-time initial setup:
-- Give user SELECT, UPDATE, DROP permissions
-- INSERT INTO performance_schema.setup_objects VALUES ('EVENT','BASEBALL','%','YES','YES');

SET SQL_SAFE_UPDATES = 0;
UPDATE performance_schema.setup_instruments
	SET enabled='YES', TIMED='YES'
    WHERE enabled='NO' OR TIMED='NO';
UPDATE performance_schema.setup_consumers
	SET enabled='YES'
    WHERE enabled='NO';
TRUNCATE TABLE performance_schema.events_transactions_history;

-- 1a) minimum primary keys
ALTER TABLE `Master` DROP PRIMARY KEY, ADD PRIMARY KEY (playerID);
ALTER TABLE `Salaries` DROP PRIMARY KEY, ADD PRIMARY KEY (playerID,yearID,teamID);
ALTER TABLE `Batting` DROP PRIMARY KEY, ADD PRIMARY KEY (playerID,yearID,teamID,stint);
TRUNCATE TABLE performance_schema.events_transactions_history;
select count(playerID) from Master where birthYear is null or birthYear = "" or birthMonth is null or birthMonth = "" or birthDay is null or birthDay = "";
SELECT (A.TIMER_END - A.TIMER_START) / 1000000 AS '1a1' FROM (SELECT * FROM performance_schema.events_transactions_history) AS A;
TRUNCATE TABLE performance_schema.events_transactions_history;
select playerID,sum(salary) as totalPay from Salaries left outer join Appearances using (playerID,yearID,teamID) left outer join Managers using (playerID,yearID,teamID) where G is null and G_all is null group by playerID order by totalPay desc limit 3;
SELECT (A.TIMER_END - A.TIMER_START) / 1000000 AS '1a2' FROM (SELECT * FROM performance_schema.events_transactions_history) AS A;
TRUNCATE TABLE performance_schema.events_transactions_history;
select nameLast,nameFirst from (select playerID,max(RBI) from Batting inner join Master using (playerID) where HR = 0 group by (playerID) limit 1) A inner join Master using (playerID);
SELECT (A.TIMER_END - A.TIMER_START) / 1000000 AS '1a3' FROM (SELECT * FROM performance_schema.events_transactions_history) AS A;
TRUNCATE TABLE performance_schema.events_transactions_history;
-- 1b) maximum primary keys
ALTER TABLE `Master` DROP PRIMARY KEY, ADD PRIMARY KEY (playerID,birthYear,birthMonth,birthDay,birthCountry,birthState,birthCity);
ALTER TABLE `Salaries` DROP PRIMARY KEY, ADD PRIMARY KEY (playerID,yearID,teamID,lgID,salary);
ALTER TABLE `Batting` DROP PRIMARY KEY, ADD PRIMARY KEY (playerID,yearID,teamID,stint,HR,RBI);
TRUNCATE TABLE performance_schema.events_transactions_history;
select count(playerID) from Master where birthYear is null or birthYear = "" or birthMonth is null or birthMonth = "" or birthDay is null or birthDay = "";
SELECT (A.TIMER_END - A.TIMER_START) / 1000000 AS '1b1' FROM (SELECT * FROM performance_schema.events_transactions_history) AS A;
TRUNCATE TABLE performance_schema.events_transactions_history;
select playerID,sum(salary) as totalPay from Salaries left outer join Appearances using (playerID,yearID,teamID) left outer join Managers using (playerID,yearID,teamID) where G is null and G_all is null group by playerID order by totalPay desc limit 3;
SELECT (A.TIMER_END - A.TIMER_START) / 1000000 AS '1b2' FROM (SELECT * FROM performance_schema.events_transactions_history) AS A;
TRUNCATE TABLE performance_schema.events_transactions_history;
select nameLast,nameFirst from (select playerID,max(RBI) from Batting inner join Master using (playerID) where HR = 0 group by (playerID) limit 1) A inner join Master using (playerID);
SELECT (A.TIMER_END - A.TIMER_START) / 1000000 AS '1b3' FROM (SELECT * FROM performance_schema.events_transactions_history) AS A;
TRUNCATE TABLE performance_schema.events_transactions_history;
-- 1c) restore state to normal
ALTER TABLE `Master` DROP PRIMARY KEY, ADD PRIMARY KEY (playerID);
ALTER TABLE `Salaries` DROP PRIMARY KEY, ADD PRIMARY KEY (playerID,yearID,teamID);
ALTER TABLE `Batting` DROP PRIMARY KEY, ADD PRIMARY KEY (playerID,yearID,teamID,stint);

-- debugging foreign keys
-- SELECT * FROM information_schema.TABLE_CONSTRAINTS
-- WHERE information_schema.TABLE_CONSTRAINTS.CONSTRAINT_TYPE = 'FOREIGN KEY'
-- AND information_schema.TABLE_CONSTRAINTS.TABLE_NAME = 'Appearances';

-- 2a) no foreign keys
ALTER TABLE `Managers` DROP FOREIGN KEY Managers_ibfk_1;
ALTER TABLE `Appearances` DROP FOREIGN KEY Appearances_ibfk_1;
ALTER TABLE `Appearances` DROP FOREIGN KEY Appearances_ibfk_2;
TRUNCATE TABLE performance_schema.events_transactions_history;
select count(playerID) from Master where birthYear is null or birthYear = "" or birthMonth is null or birthMonth = "" or birthDay is null or birthDay = "";
SELECT (A.TIMER_END - A.TIMER_START) / 1000000 AS '2a1' FROM (SELECT * FROM performance_schema.events_transactions_history) AS A;
TRUNCATE TABLE performance_schema.events_transactions_history;
select playerID,sum(salary) as totalPay from Salaries left outer join Appearances using (playerID,yearID,teamID) left outer join Managers using (playerID,yearID,teamID) where G is null and G_all is null group by playerID order by totalPay desc limit 3;
SELECT (A.TIMER_END - A.TIMER_START) / 1000000 AS '2a2' FROM (SELECT * FROM performance_schema.events_transactions_history) AS A;
TRUNCATE TABLE performance_schema.events_transactions_history;
select nameLast,nameFirst from (select playerID,max(RBI) from Batting inner join Master using (playerID) where HR = 0 group by (playerID) limit 1) A inner join Master using (playerID);
SELECT (A.TIMER_END - A.TIMER_START) / 1000000 AS '2a3' FROM (SELECT * FROM performance_schema.events_transactions_history) AS A;
TRUNCATE TABLE performance_schema.events_transactions_history;
-- 2b) with foreign keys
ALTER TABLE `Appearances` ADD CONSTRAINT foreignKey_1 FOREIGN KEY (playerID) REFERENCES Master(playerID);
ALTER TABLE `Appearances` ADD CONSTRAINT foreignKey_2 FOREIGN KEY (teamID, yearID) REFERENCES Teams(teamID, yearID);
ALTER TABLE `Managers` ADD CONSTRAINT foreignKey FOREIGN KEY (teamID, yearID) REFERENCES Teams(teamID, yearID);
TRUNCATE TABLE performance_schema.events_transactions_history;
select count(playerID) from Master where birthYear is null or birthYear = "" or birthMonth is null or birthMonth = "" or birthDay is null or birthDay = "";
SELECT (A.TIMER_END - A.TIMER_START) / 1000000 AS '2b1' FROM (SELECT * FROM performance_schema.events_transactions_history) AS A;
TRUNCATE TABLE performance_schema.events_transactions_history;
select playerID,sum(salary) as totalPay from Salaries left outer join Appearances using (playerID,yearID,teamID) left outer join Managers using (playerID,yearID,teamID) where G is null and G_all is null group by playerID order by totalPay desc limit 3;
SELECT (A.TIMER_END - A.TIMER_START) / 1000000 AS '2b2' FROM (SELECT * FROM performance_schema.events_transactions_history) AS A;
TRUNCATE TABLE performance_schema.events_transactions_history;
select nameLast,nameFirst from (select playerID,max(RBI) from Batting inner join Master using (playerID) where HR = 0 group by (playerID) limit 1) A inner join Master using (playerID);
SELECT (A.TIMER_END - A.TIMER_START) / 1000000 AS '2b3' FROM (SELECT * FROM performance_schema.events_transactions_history) AS A;
TRUNCATE TABLE performance_schema.events_transactions_history;

-- 3a) no explicit indexes
TRUNCATE TABLE performance_schema.events_transactions_history;
select count(playerID) from Master where birthYear is null or birthYear = "" or birthMonth is null or birthMonth = "" or birthDay is null or birthDay = "";
SELECT (A.TIMER_END - A.TIMER_START) / 1000000 AS '3a1' FROM (SELECT * FROM performance_schema.events_transactions_history) AS A;
TRUNCATE TABLE performance_schema.events_transactions_history;
select playerID,sum(salary) as totalPay from Salaries left outer join Appearances using (playerID,yearID,teamID) left outer join Managers using (playerID,yearID,teamID) where G is null and G_all is null group by playerID order by totalPay desc limit 3;
SELECT (A.TIMER_END - A.TIMER_START) / 1000000 AS '3a2' FROM (SELECT * FROM performance_schema.events_transactions_history) AS A;
TRUNCATE TABLE performance_schema.events_transactions_history;
select nameLast,nameFirst from (select playerID,max(RBI) from Batting inner join Master using (playerID) where HR = 0 group by (playerID) limit 1) A inner join Master using (playerID);
SELECT (A.TIMER_END - A.TIMER_START) / 1000000 AS '3a3' FROM (SELECT * FROM performance_schema.events_transactions_history) AS A;
TRUNCATE TABLE performance_schema.events_transactions_history;
-- 3b) explicit indexes related to these queries
ALTER TABLE `Master` ADD INDEX birthYear (birthYear);
ALTER TABLE `Master` ADD INDEX birthMonth (birthMonth);
ALTER TABLE `Master` ADD INDEX birthDay (birthDay);
ALTER TABLE `Master` ADD INDEX nameLast (nameLast);
ALTER TABLE `Master` ADD INDEX nameFirst (nameFirst);
ALTER TABLE `Batting` ADD INDEX rbi (RBI);
ALTER TABLE `Batting` ADD INDEX hr (HR);
ALTER TABLE `Salaries` ADD INDEX salary (salary);
ALTER TABLE `Appearances` ADD INDEX G_all (G_all);
ALTER TABLE `Managers` ADD INDEX G (G);
TRUNCATE TABLE performance_schema.events_transactions_history;
select count(playerID) from Master where birthYear is null or birthYear = "" or birthMonth is null or birthMonth = "" or birthDay is null or birthDay = "";
SELECT (A.TIMER_END - A.TIMER_START) / 1000000 AS '3b1' FROM (SELECT * FROM performance_schema.events_transactions_history) AS A;
TRUNCATE TABLE performance_schema.events_transactions_history;
select playerID,sum(salary) as totalPay from Salaries left outer join Appearances using (playerID,yearID,teamID) left outer join Managers using (playerID,yearID,teamID) where G is null and G_all is null group by playerID order by totalPay desc limit 3;
SELECT (A.TIMER_END - A.TIMER_START) / 1000000 AS '3b2' FROM (SELECT * FROM performance_schema.events_transactions_history) AS A;
TRUNCATE TABLE performance_schema.events_transactions_history;
select nameLast,nameFirst from (select playerID,max(RBI) from Batting inner join Master using (playerID) where HR = 0 group by (playerID) limit 1) A inner join Master using (playerID);
SELECT (A.TIMER_END - A.TIMER_START) / 1000000 AS '3b3' FROM (SELECT * FROM performance_schema.events_transactions_history) AS A;
TRUNCATE TABLE performance_schema.events_transactions_history;
-- 3c) restore state to normal
DROP INDEX birthYear ON `Master`;
DROP INDEX birthMonth ON `Master`;
DROP INDEX birthDay ON `Master`;
DROP INDEX nameLast ON `Master`;
DROP INDEX nameFirst ON `Master`;
DROP INDEX rbi ON `Batting`;
DROP INDEX hr ON `Batting`;
DROP INDEX salary ON `Salaries`;
DROP INDEX G_all ON `Appearances`;
DROP INDEX G ON `Managers`;
