USE `BASEBALL`;

SET NAMES utf8mb4;

DROP TABLE IF EXISTS `Pitching`;
DROP TABLE IF EXISTS `PitchingPost`;
DROP TABLE IF EXISTS `Salaries`;
DROP TABLE IF EXISTS `TeamsHalf`;
DROP TABLE IF EXISTS `SeriesPost`;
DROP TABLE IF EXISTS `HomeGames`;
DROP TABLE IF EXISTS `Parks`;
DROP TABLE IF EXISTS `HallOfFame`;
DROP TABLE IF EXISTS `FieldingOF`;
DROP TABLE IF EXISTS `FieldingOFsplit`;
DROP TABLE IF EXISTS `FieldingPost`;
DROP TABLE IF EXISTS `Fielding`;
DROP TABLE IF EXISTS `CollegePlaying`;
DROP TABLE IF EXISTS `Schools`;
DROP TABLE IF EXISTS `BattingPost`;
DROP TABLE IF EXISTS `Batting`;
DROP TABLE IF EXISTS `AwardsSharePlayers`;
DROP TABLE IF EXISTS `AwardsPlayers`;
DROP TABLE IF EXISTS `AwardsShareManagers`;
DROP TABLE IF EXISTS `AwardsManagers`;
DROP TABLE IF EXISTS `ManagersHalf`;
DROP TABLE IF EXISTS `Managers`;
DROP TABLE IF EXISTS `Appearances`;
DROP TABLE IF EXISTS `AllstarFull`;
DROP TABLE IF EXISTS `Teams`;
DROP TABLE IF EXISTS `TeamsFranchises`;
DROP TABLE IF EXISTS `Master`;

CREATE TABLE `Master` (
  `playerID`     varchar(255) NOT NULL,
  `birthYear`    int(11)      DEFAULT NULL,
  `birthMonth`   int(11)      DEFAULT NULL,
  `birthDay`     int(11)      DEFAULT NULL,
  `birthCountry` varchar(255) DEFAULT NULL,
  `birthState`   varchar(255) DEFAULT NULL,
  `birthCity`    varchar(255) DEFAULT NULL,
  `deathYear`    varchar(255) DEFAULT NULL,
  `deathMonth`   varchar(255) DEFAULT NULL,
  `deathDay`     varchar(255) DEFAULT NULL,
  `deathCountry` varchar(255) DEFAULT NULL,
  `deathState`   varchar(255) DEFAULT NULL,
  `deathCity`    varchar(255) DEFAULT NULL,
  `nameFirst`    varchar(255) DEFAULT NULL,
  `nameLast`     varchar(255) DEFAULT NULL,
  `nameGiven`    varchar(255) DEFAULT NULL,
  `weight`       int(11)      DEFAULT NULL,
  `height`       int(11)      DEFAULT NULL,
  `bats`         varchar(255) DEFAULT NULL,
  `throws`       varchar(255) DEFAULT NULL,
  `debut`        varchar(255) DEFAULT NULL,
  `finalGame`    varchar(255) DEFAULT NULL,
  `retroID`      varchar(255) DEFAULT NULL,
  `bbrefID`      varchar(255) DEFAULT NULL,
  primary key (`playerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `TeamsFranchises` (
  `franchID`   varchar(255) NOT NULL,
  `franchName` varchar(255) DEFAULT NULL,
  `active`     varchar(255) DEFAULT NULL,
  `NAassoc`    varchar(255) DEFAULT NULL,
  primary key (`franchID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `Teams` (
  `yearID`         int(11)      NOT NULL,
  `lgID`           varchar(255) DEFAULT NULL,
  `teamID`         varchar(255) NOT NULL,
  `franchID`       varchar(255) NOT NULL,
  `divID`          varchar(255) DEFAULT NULL,
  `Rank`           int(11)      DEFAULT NULL,
  `G`              int(11)      DEFAULT NULL,
  `Ghome`          varchar(255) DEFAULT NULL,
  `W`              int(11)      DEFAULT NULL,
  `L`              int(11)      DEFAULT NULL,
  `DivWin`         varchar(255) DEFAULT NULL,
  `WCWin`          varchar(255) DEFAULT NULL,
  `LgWin`          varchar(255) DEFAULT NULL,
  `WSWin`          varchar(255) DEFAULT NULL,
  `R`              int(11)      DEFAULT NULL,
  `AB`             int(11)      DEFAULT NULL,
  `H`              int(11)      DEFAULT NULL,
  `2B`             int(11)      DEFAULT NULL,
  `3B`             int(11)      DEFAULT NULL,
  `HR`             int(11)      DEFAULT NULL,
  `BB`             int(11)      DEFAULT NULL,
  `SO`             int(11)      DEFAULT NULL,
  `SB`             int(11)      DEFAULT NULL,
  `CS`             varchar(255) DEFAULT NULL,
  `HBP`            varchar(255) DEFAULT NULL,
  `SF`             varchar(255) DEFAULT NULL,
  `RA`             int(11)      DEFAULT NULL,
  `ER`             int(11)      DEFAULT NULL,
  `ERA`            float        DEFAULT NULL,
  `CG`             int(11)      DEFAULT NULL,
  `SHO`            int(11)      DEFAULT NULL,
  `SV`             int(11)      DEFAULT NULL,
  `IPouts`         int(11)      DEFAULT NULL,
  `HA`             int(11)      DEFAULT NULL,
  `HRA`            int(11)      DEFAULT NULL,
  `BBA`            int(11)      DEFAULT NULL,
  `SOA`            int(11)      DEFAULT NULL,
  `E`              int(11)      DEFAULT NULL,
  `DP`             varchar(255) DEFAULT NULL,
  `FP`             float        DEFAULT NULL,
  `name`           varchar(255) DEFAULT NULL,
  `park`           varchar(255) DEFAULT NULL,
  `attendance`     varchar(255) DEFAULT NULL,
  `BPF`            int(11)      DEFAULT NULL,
  `PPF`            int(11)      DEFAULT NULL,
  `teamIDBR`       varchar(255) DEFAULT NULL,
  `teamIDlahman45` varchar(255) DEFAULT NULL,
  `teamIDretro`    varchar(255) DEFAULT NULL,
  primary key (`teamID`, `yearID`),
  foreign key (`franchID`)
	references TeamsFranchises(`franchID`)
    on delete cascade
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `AllstarFull` (
  `playerID`    varchar(255) NOT NULL,
  `yearID`      int(11)      NOT NULL,
  `gameNum`     int(11)      DEFAULT NULL,
  `gameID`      varchar(255) NOT NULL,
  `teamID`      varchar(255) NOT NULL,
  `lgID`        varchar(255) DEFAULT NULL,
  `GP`          int(11)      DEFAULT NULL,
  `startingPos` varchar(255) DEFAULT NULL,
  primary key (`playerID`, `gameID`),
  foreign key (`playerID`)
	references Master(`playerID`)
    on delete cascade,
  foreign key (`teamID`, `yearID`)
	references Teams(`teamID`, `yearID`)
    on delete cascade
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `Appearances` (
  `yearID`    int(11)      NOT NULL,
  `teamID`    varchar(255) NOT NULL,
  `lgID`      varchar(255) DEFAULT NULL,
  `playerID`  varchar(255) NOT NULL,
  `G_all`     int(11)      DEFAULT NULL,
  `GS`        varchar(255) DEFAULT NULL,
  `G_batting` int(11)      DEFAULT NULL,
  `G_defense` int(11)      DEFAULT NULL,
  `G_p`       int(11)      DEFAULT NULL,
  `G_c`       int(11)      DEFAULT NULL,
  `G_1b`      int(11)      DEFAULT NULL,
  `G_2b`      int(11)      DEFAULT NULL,
  `G_3b`      int(11)      DEFAULT NULL,
  `G_ss`      int(11)      DEFAULT NULL,
  `G_lf`      int(11)      DEFAULT NULL,
  `G_cf`      int(11)      DEFAULT NULL,
  `G_rf`      int(11)      DEFAULT NULL,
  `G_of`      int(11)      DEFAULT NULL,
  `G_dh`      varchar(255) DEFAULT NULL,
  `G_ph`      varchar(255) DEFAULT NULL,
  `G_pr`      varchar(255) DEFAULT NULL,
  primary key (`playerID`, `yearID`, `teamID`),
  foreign key (`playerID`)
	references Master(`playerID`)
    on delete cascade,
  foreign key (`teamID`, `yearID`)
	references Teams(`teamID`, `yearID`)
    on delete cascade
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `Managers` (
  `playerID` varchar(255) NOT NULL,
  `yearID`   int(11)      NOT NULL,
  `teamID`   varchar(255) NOT NULL,
  `lgID`     varchar(255) DEFAULT NULL,
  `inseason` int(11)      NOT NULL,
  `G`        int(11)      DEFAULT NULL,
  `W`        int(11)      DEFAULT NULL,
  `L`        int(11)      DEFAULT NULL,
  `rank`     int(11)      DEFAULT NULL,
  `plyrMgr`  varchar(255) DEFAULT NULL,
  primary key (`playerID`, `yearID`, `teamID`, `inseason`),
  foreign key (`teamID`, `yearID`)
	references Teams(`teamID`, `yearID`)
    on delete cascade
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `ManagersHalf` (
  `playerID` varchar(255) NOT NULL,
  `yearID`   int(11)      NOT NULL,
  `teamID`   varchar(255) NOT NULL,
  `lgID`     varchar(255) DEFAULT NULL,
  `inseason` int(11)      NOT NULL,
  `half`     int(11)      NOT NULL,
  `G`        int(11)      DEFAULT NULL,
  `W`        int(11)      DEFAULT NULL,
  `L`        int(11)      DEFAULT NULL,
  `rank`     int(11)      DEFAULT NULL,
  primary key (`playerID`, `yearID`, `teamID`, `inseason`, `half`),
  foreign key (`teamID`, `yearID`)
	references Teams(`teamID`, `yearID`)
    on delete cascade,
  foreign key (`playerID`, `yearID`, `teamID`, `inseason`)
	references Managers(`playerID`, `yearID`, `teamID`, `inseason`)
    on delete cascade
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `AwardsManagers` (
  `playerID` varchar(255) NOT NULL,
  `awardID`  varchar(255) NOT NULL,
  `yearID`   int(11)      NOT NULL,
  `lgID`     varchar(255) DEFAULT NULL,
  `tie`      varchar(255) DEFAULT NULL,
  `notes`    varchar(255) DEFAULT NULL,
  primary key (`playerID`, `awardID`, `yearID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `AwardsShareManagers` (
  `awardID`    varchar(255) NOT NULL,
  `yearID`     int(11)      NOT NULL,
  `lgID`       varchar(255) DEFAULT NULL,
  `playerID`   varchar(255) NOT NULL,
  `pointsWon`  int(11)      DEFAULT NULL,
  `pointsMax`  int(11)      DEFAULT NULL,
  `votesFirst` int(11)      DEFAULT NULL,
  primary key (`playerID`, `awardID`, `yearID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `AwardsPlayers` (
  `playerID` varchar(255) NOT NULL,
  `awardID`  varchar(255) NOT NULL,
  `yearID`   int(11)      NOT NULL,
  `lgID`     varchar(255) NOT NULL,
  `tie`      varchar(255) DEFAULT NULL,
  `notes`    varchar(255) DEFAULT NULL,
  primary key (`playerID`, `awardID`, `yearID`, `lgID`),
  foreign key (`playerID`)
	references Master(`playerID`)
    on delete cascade
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `AwardsSharePlayers` (
  `awardID`    varchar(255) NOT NULL,
  `yearID`     int(11)      NOT NULL,
  `lgID`       varchar(255) NOT NULL,
  `playerID`   varchar(255) NOT NULL,
  `pointsWon`  int(11)      DEFAULT NULL,
  `pointsMax`  int(11)      DEFAULT NULL,
  `votesFirst` int(11)      DEFAULT NULL,
  primary key (`playerID`, `awardID`, `yearID`, `lgID`),
  foreign key (`playerID`)
	references Master(`playerID`)
    on delete cascade
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `Batting` (
  `playerID` varchar(255) NOT NULL,
  `yearID`   int(11)      NOT NULL,
  `stint`    int(11)      NOT NULL,
  `teamID`   varchar(255) NOT NULL,
  `lgID`     varchar(255) DEFAULT NULL,
  `G`        int(11)      DEFAULT NULL,
  `AB`       int(11)      DEFAULT NULL,
  `R`        int(11)      DEFAULT NULL,
  `H`        int(11)      DEFAULT NULL,
  `2B`       int(11)      DEFAULT NULL,
  `3B`       int(11)      DEFAULT NULL,
  `HR`       int(11)      DEFAULT NULL,
  `RBI`      int(11)      DEFAULT NULL,
  `SB`       int(11)      DEFAULT NULL,
  `CS`       int(11)      DEFAULT NULL,
  `BB`       int(11)      DEFAULT NULL,
  `SO`       int(11)      DEFAULT NULL,
  `IBB`      varchar(255) DEFAULT NULL,
  `HBP`      varchar(255) DEFAULT NULL,
  `SH`       varchar(255) DEFAULT NULL,
  `SF`       varchar(255) DEFAULT NULL,
  `GIDP`     varchar(255) DEFAULT NULL,
  primary key (`playerID`, `yearID`, `teamID`, `stint`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `BattingPost` (
  `yearID`   int(11)      NOT NULL,
  `round`    varchar(255) NOT NULL,
  `playerID` varchar(255) NOT NULL,
  `teamID`   varchar(255) NOT NULL,
  `lgID`     varchar(255) DEFAULT NULL,
  `G`        int(11)      DEFAULT NULL,
  `AB`       int(11)      DEFAULT NULL,
  `R`        int(11)      DEFAULT NULL,
  `H`        int(11)      DEFAULT NULL,
  `2B`       int(11)      DEFAULT NULL,
  `3B`       int(11)      DEFAULT NULL,
  `HR`       int(11)      DEFAULT NULL,
  `RBI`      int(11)      DEFAULT NULL,
  `SB`       int(11)      DEFAULT NULL,
  `CS`       varchar(255) DEFAULT NULL,
  `BB`       int(11)      DEFAULT NULL,
  `SO`       int(11)      DEFAULT NULL,
  `IBB`      int(11)      DEFAULT NULL,
  `HBP`      varchar(255) DEFAULT NULL,
  `SH`       varchar(255) DEFAULT NULL,
  `SF`       varchar(255) DEFAULT NULL,
  `GIDP`     varchar(255) DEFAULT NULL,
  primary key (`playerID`, `yearID`, `teamID`, `round`),
  foreign key (`playerID`)
	references Master(`playerID`)
    on delete cascade,
  foreign key (`teamID`, `yearID`)
	references Teams(`teamID`, `yearID`)
    on delete cascade
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `Schools` (
  `schoolID`  varchar(255) NOT NULL,
  `name_full` varchar(255) DEFAULT NULL,
  `city`      varchar(255) DEFAULT NULL,
  `state`     varchar(255) DEFAULT NULL,
  `country`   varchar(255) DEFAULT NULL,
  primary key (`schoolID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `CollegePlaying` (
  `playerID` varchar(255) NOT NULL,
  `schoolID` varchar(255) NOT NULL,
  `yearID`   int(11)      NOT NULL,
  primary key (`playerID`, `schoolID`, `yearID`),
  foreign key (`playerID`)
	references Master(`playerID`)
    on delete cascade
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `Fielding` (
  `playerID` varchar(255) NOT NULL,
  `yearID`   int(11)      NOT NULL,
  `stint`    int(11)      NOT NULL,
  `teamID`   varchar(255) NOT NULL,
  `lgID`     varchar(255) DEFAULT NULL,
  `POS`      varchar(255) NOT NULL,
  `G`        int(11)      DEFAULT NULL,
  `GS`       varchar(255) DEFAULT NULL,
  `InnOuts`  varchar(255) DEFAULT NULL,
  `PO`       int(11)      DEFAULT NULL,
  `A`        int(11)      DEFAULT NULL,
  `E`        int(11)      DEFAULT NULL,
  `DP`       int(11)      DEFAULT NULL,
  `PB`       varchar(255) DEFAULT NULL,
  `WP`       varchar(255) DEFAULT NULL,
  `SB`       varchar(255) DEFAULT NULL,
  `CS`       varchar(255) DEFAULT NULL,
  `ZR`       varchar(255) DEFAULT NULL,
  primary key (`playerID`, `yearID`, `teamID`, `stint`, `POS`),
  foreign key (`playerID`)
	references Master(`playerID`)
    on delete cascade,
  foreign key (`teamID`, `yearID`)
	references Teams(`teamID`, `yearID`)
    on delete cascade
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `FieldingOF` (
  `playerID` varchar(255) NOT NULL,
  `yearID`   int(11)      NOT NULL,
  `stint`    int(11)      NOT NULL,
  `Glf`      int(11)      DEFAULT NULL,
  `Gcf`      int(11)      DEFAULT NULL,
  `Grf`      int(11)      DEFAULT NULL,
  primary key (`playerID`, `yearID`, `stint`),
  foreign key (`playerID`)
	references Master(`playerID`)
    on delete cascade
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `FieldingOFsplit` (
  `playerID` varchar(255) NOT NULL,
  `yearID`   int(11)      NOT NULL,
  `stint`    int(11)      NOT NULL,
  `teamID`   varchar(255) NOT NULL,
  `lgID`     varchar(255) DEFAULT NULL,
  `POS`      varchar(255) NOT NULL,
  `G`        int(11)      DEFAULT NULL,
  `GS`       int(11)      DEFAULT NULL,
  `InnOuts`  int(11)      DEFAULT NULL,
  `PO`       int(11)      DEFAULT NULL,
  `A`        int(11)      DEFAULT NULL,
  `E`        int(11)      DEFAULT NULL,
  `DP`       int(11)      DEFAULT NULL,
  `PB`       varchar(255) DEFAULT NULL,
  `WP`       varchar(255) DEFAULT NULL,
  `SB`       varchar(255) DEFAULT NULL,
  `CS`       varchar(255) DEFAULT NULL,
  `ZR`       varchar(255) DEFAULT NULL,
  primary key (`playerID`, `yearID`, `teamID`, `stint`, `POS`),
  foreign key (`playerID`)
	references Master(`playerID`)
    on delete cascade,
  foreign key (`teamID`, `yearID`)
	references Teams(`teamID`, `yearID`)
    on delete cascade
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `FieldingPost` (
  `playerID` varchar(255) NOT NULL,
  `yearID`   int(11)      NOT NULL,
  `teamID`   varchar(255) NOT NULL,
  `lgID`     varchar(255) DEFAULT NULL,
  `round`    varchar(255) NOT NULL,
  `POS`      varchar(255) NOT NULL,
  `G`        int(11)      DEFAULT NULL,
  `GS`       int(11)      DEFAULT NULL,
  `InnOuts`  int(11)      DEFAULT NULL,
  `PO`       int(11)      DEFAULT NULL,
  `A`        int(11)      DEFAULT NULL,
  `E`        int(11)      DEFAULT NULL,
  `DP`       int(11)      DEFAULT NULL,
  `TP`       int(11)      DEFAULT NULL,
  `PB`       varchar(255) DEFAULT NULL,
  `SB`       varchar(255) DEFAULT NULL,
  `CS`       varchar(255) DEFAULT NULL,
  primary key (`playerID`, `yearID`, `teamID`, `POS`, `round`),
  foreign key (`playerID`)
	references Master(`playerID`)
    on delete cascade,
  foreign key (`teamID`, `yearID`)
	references Teams(`teamID`, `yearID`)
    on delete cascade
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `HallOfFame` (
  `playerID`    varchar(255) NOT NULL,
  `yearid`      int(11)      NOT NULL,
  `votedBy`     varchar(255) NOT NULL,
  `ballots`     int(11)      DEFAULT NULL,
  `needed`      int(11)      DEFAULT NULL,
  `votes`       int(11)      DEFAULT NULL,
  `inducted`    varchar(255) DEFAULT NULL,
  `category`    varchar(255) NOT NULL,
  `needed_note` varchar(255) DEFAULT NULL,
  primary key (`playerID`, `yearid`, `category`, `votedBy`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `Parks` (
  `park.key`   varchar(255) NOT NULL,
  `park.name`  varchar(255) DEFAULT NULL,
  `park.alias` varchar(255) DEFAULT NULL,
  `city`       varchar(255) DEFAULT NULL,
  `state`      varchar(255) DEFAULT NULL,
  `country`    varchar(255) DEFAULT NULL,
  primary key (`park.key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `HomeGames` (
  `year.key`   int(11)      NOT NULL,
  `league.key` varchar(255) DEFAULT NULL,
  `team.key`   varchar(255) NOT NULL,
  `park.key`   varchar(255) NOT NULL,
  `span.first` varchar(255) DEFAULT NULL,
  `span.last`  varchar(255) DEFAULT NULL,
  `games`      int(11)      DEFAULT NULL,
  `openings`   int(11)      DEFAULT NULL,
  `attendance` int(11)      DEFAULT NULL,
  primary key (`team.key`, `year.key`, `park.key`),
  foreign key (`team.key`, `year.key`)
	references Teams(`teamID`, `yearID`)
    on delete cascade,
  foreign key (`park.key`)
	references Parks(`park.key`)
    on delete cascade
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `Pitching` (
  `playerID` varchar(255) NOT NULL,
  `yearID`   int(11)      NOT NULL,
  `stint`    int(11)      NOT NULL,
  `teamID`   varchar(255) NOT NULL,
  `lgID`     varchar(255) DEFAULT NULL,
  `W`        int(11)      DEFAULT NULL,
  `L`        int(11)      DEFAULT NULL,
  `G`        int(11)      DEFAULT NULL,
  `GS`       int(11)      DEFAULT NULL,
  `CG`       int(11)      DEFAULT NULL,
  `SHO`      int(11)      DEFAULT NULL,
  `SV`       int(11)      DEFAULT NULL,
  `IPouts`   int(11)      DEFAULT NULL,
  `H`        int(11)      DEFAULT NULL,
  `ER`       int(11)      DEFAULT NULL,
  `HR`       int(11)      DEFAULT NULL,
  `BB`       int(11)      DEFAULT NULL,
  `SO`       int(11)      DEFAULT NULL,
  `BAOpp`    varchar(255) DEFAULT NULL,
  `ERA`      float        DEFAULT NULL,
  `IBB`      varchar(255) DEFAULT NULL,
  `WP`       varchar(255) DEFAULT NULL,
  `HBP`      varchar(255) DEFAULT NULL,
  `BK`       int(11)      DEFAULT NULL,
  `BFP`      varchar(255) DEFAULT NULL,
  `GF`       varchar(255) DEFAULT NULL,
  `R`        int(11)      DEFAULT NULL,
  `SH`       varchar(255) DEFAULT NULL,
  `SF`       varchar(255) DEFAULT NULL,
  `GIDP`     varchar(255) DEFAULT NULL,
  primary key (`playerID`, `yearID`, `teamID`, `stint`),
  foreign key (`playerID`)
	references Master(`playerID`)
    on delete cascade,
  foreign key (`teamID`, `yearID`)
	references Teams(`teamID`, `yearID`)
    on delete cascade
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `PitchingPost` (
  `playerID` varchar(255) NOT NULL,
  `yearID`   int(11)      NOT NULL,
  `round`    varchar(255) NOT NULL,
  `teamID`   varchar(255) NOT NULL,
  `lgID`     varchar(255) DEFAULT NULL,
  `W`        int(11)      DEFAULT NULL,
  `L`        int(11)      DEFAULT NULL,
  `G`        int(11)      DEFAULT NULL,
  `GS`       int(11)      DEFAULT NULL,
  `CG`       int(11)      DEFAULT NULL,
  `SHO`      int(11)      DEFAULT NULL,
  `SV`       int(11)      DEFAULT NULL,
  `IPouts`   int(11)      DEFAULT NULL,
  `H`        int(11)      DEFAULT NULL,
  `ER`       int(11)      DEFAULT NULL,
  `HR`       int(11)      DEFAULT NULL,
  `BB`       int(11)      DEFAULT NULL,
  `SO`       int(11)      DEFAULT NULL,
  `BAOpp`    float        DEFAULT NULL,
  `ERA`      varchar(255) DEFAULT NULL,
  `IBB`      int(11)      DEFAULT NULL,
  `WP`       int(11)      DEFAULT NULL,
  `HBP`      int(11)      DEFAULT NULL,
  `BK`       int(11)      DEFAULT NULL,
  `BFP`      int(11)      DEFAULT NULL,
  `GF`       int(11)      DEFAULT NULL,
  `R`        int(11)      DEFAULT NULL,
  `SH`       int(11)      DEFAULT NULL,
  `SF`       int(11)      DEFAULT NULL,
  `GIDP`     int(11)      DEFAULT NULL,
  primary key (`playerID`, `yearID`, `teamID`, `round`),
  foreign key (`playerID`)
	references Master(`playerID`)
    on delete cascade,
  foreign key (`teamID`, `yearID`)
	references Teams(`teamID`, `yearID`)
    on delete cascade
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `Salaries` (
  `yearID`   int(11)      NOT NULL,
  `teamID`   varchar(255) NOT NULL,
  `lgID`     varchar(255) DEFAULT NULL,
  `playerID` varchar(255) NOT NULL,
  `salary`   int(11)      DEFAULT NULL,
  primary key (`playerID`, `yearID`, `teamID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `SeriesPost` (
  `yearID`       int(11)      NOT NULL,
  `round`        varchar(255) NOT NULL,
  `teamIDwinner` varchar(255) DEFAULT NULL,
  `lgIDwinner`   varchar(255) DEFAULT NULL,
  `teamIDloser`  varchar(255) DEFAULT NULL,
  `lgIDloser`    varchar(255) DEFAULT NULL,
  `wins`         int(11)      DEFAULT NULL,
  `losses`       int(11)      DEFAULT NULL,
  `ties`         int(11)      DEFAULT NULL,
  primary key (`yearID`, `round`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `TeamsHalf` (
  `yearID` int(11)      NOT NULL,
  `lgID`   varchar(255) DEFAULT NULL,
  `teamID` varchar(255) NOT NULL,
  `Half`   int(11)      NOT NULL,
  `divID`  varchar(255) DEFAULT NULL,
  `DivWin` varchar(255) DEFAULT NULL,
  `Rank`   int(11)      DEFAULT NULL,
  `G`      int(11)      DEFAULT NULL,
  `W`      int(11)      DEFAULT NULL,
  `L`      decimal(11)  DEFAULT NULL,
  primary key (`teamID`, `yearID`, `Half`),
  foreign key (`teamID`, `yearID`)
	references Teams(`teamID`, `yearID`)
    on delete cascade
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
