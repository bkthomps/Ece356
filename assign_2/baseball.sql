USE BASEBALL;
-- If you are using data from last assignment, you must do so by removing the foreign keys in the declarations
-- because these tests will create their own foreign keys and assume none exist yet. This is a one-time thing
-- due to the fact that these tests will clean up the state after they are done running. If this is not possible,
-- then simply comment out the 3b section. Sections 3a and 3c will work no matter the foreign key configuration.


-- 3a) minimum primary keys
ALTER TABLE `Master` DROP PRIMARY KEY, ADD PRIMARY KEY (playerID);
ALTER TABLE `Salaries` DROP PRIMARY KEY, ADD PRIMARY KEY (playerID,yearID,teamID);
select count(playerID) from Master where birthYear is null or birthYear = "" or birthMonth is null or birthMonth = "" or birthDay is null or birthDay = "";
select playerID,sum(salary) as totalPay from Salaries left outer join Appearances using (playerID,yearID,teamID) left outer join Managers using (playerID,yearID,teamID) where G is null and G_all is null group by playerID order by totalPay desc limit 3;
-- 3a) maximum primary keys
ALTER TABLE `Master` DROP PRIMARY KEY, ADD PRIMARY KEY (playerID,birthYear,birthMonth,birthDay,birthCountry,birthState,birthCity);
ALTER TABLE `Salaries` DROP PRIMARY KEY, ADD PRIMARY KEY (playerID,yearID,teamID,lgID,salary);
select count(playerID) from Master where birthYear is null or birthYear = "" or birthMonth is null or birthMonth = "" or birthDay is null or birthDay = "";
select playerID,sum(salary) as totalPay from Salaries left outer join Appearances using (playerID,yearID,teamID) left outer join Managers using (playerID,yearID,teamID) where G is null and G_all is null group by playerID order by totalPay desc limit 3;
-- 3a) restore state to normal
ALTER TABLE `Master` DROP PRIMARY KEY, ADD PRIMARY KEY (playerID);
ALTER TABLE `Salaries` DROP PRIMARY KEY, ADD PRIMARY KEY (playerID,yearID,teamID);

-- 3b) no foreign keys
select count(playerID) from Master where birthYear is null or birthYear = "" or birthMonth is null or birthMonth = "" or birthDay is null or birthDay = "";
select playerID,sum(salary) as totalPay from Salaries left outer join Appearances using (playerID,yearID,teamID) left outer join Managers using (playerID,yearID,teamID) where G is null and G_all is null group by playerID order by totalPay desc limit 3;
-- 3b) with foreign keys
ALTER TABLE `Appearances` ADD CONSTRAINT foreignKey_1 FOREIGN KEY (playerID) REFERENCES Master(playerID);
ALTER TABLE `Appearances` ADD CONSTRAINT foreignKey_2 FOREIGN KEY (teamID, yearID) REFERENCES Teams(teamID, yearID);
ALTER TABLE `Managers` ADD CONSTRAINT foreignKey FOREIGN KEY (teamID, yearID) REFERENCES Teams(teamID, yearID);
select count(playerID) from Master where birthYear is null or birthYear = "" or birthMonth is null or birthMonth = "" or birthDay is null or birthDay = "";
select playerID,sum(salary) as totalPay from Salaries left outer join Appearances using (playerID,yearID,teamID) left outer join Managers using (playerID,yearID,teamID) where G is null and G_all is null group by playerID order by totalPay desc limit 3;
-- 3b) restore state to normal
ALTER TABLE `Appearances` DROP FOREIGN KEY Appearances_ibfk_1;
ALTER TABLE `Appearances` DROP FOREIGN KEY Appearances_ibfk_2;
DROP INDEX foreignKey_1 ON `Appearances`;
DROP INDEX foreignKey_2 ON `Appearances`;
ALTER TABLE `Managers` DROP FOREIGN KEY Managers_ibfk_2;
DROP INDEX foreignKey ON `Managers`;

-- 3c) no explicit indexes
select count(playerID) from Master where birthYear is null or birthYear = "" or birthMonth is null or birthMonth = "" or birthDay is null or birthDay = "";
select playerID,sum(salary) as totalPay from Salaries left outer join Appearances using (playerID,yearID,teamID) left outer join Managers using (playerID,yearID,teamID) where G is null and G_all is null group by playerID order by totalPay desc limit 3;
-- 3c) explicit indexes related to these queries
ALTER TABLE `Master` ADD INDEX birthYear (birthYear);
ALTER TABLE `Master` ADD INDEX birthMonth (birthMonth);
ALTER TABLE `Master` ADD INDEX birthDay (birthDay);
ALTER TABLE `Salaries` ADD INDEX salary (salary);
ALTER TABLE `Appearances` ADD INDEX G_all (G_all);
ALTER TABLE `Managers` ADD INDEX G (G);
select count(playerID) from Master where birthYear is null or birthYear = "" or birthMonth is null or birthMonth = "" or birthDay is null or birthDay = "";
select playerID,sum(salary) as totalPay from Salaries left outer join Appearances using (playerID,yearID,teamID) left outer join Managers using (playerID,yearID,teamID) where G is null and G_all is null group by playerID order by totalPay desc limit 3;
-- 3c) restore state to normal
DROP INDEX birthYear ON `Master`;
DROP INDEX birthMonth ON `Master`;
DROP INDEX birthDay ON `Master`;
DROP INDEX salary ON `Salaries`;
DROP INDEX G_all ON `Appearances`;
DROP INDEX G ON `Managers`;
