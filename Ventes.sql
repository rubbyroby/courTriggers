-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : jeu. 29 déc. 2022 à 15:56
-- Version du serveur : 5.7.36
-- Version de PHP : 7.4.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `tp_ps`
--

DELIMITER $$
--
-- Procédures
--
DROP PROCEDURE IF EXISTS `c10`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `c10` ()  BEGIN
DECLARE done INT DEFAULT FALSE;
DECLARE c int DEFAULT(0);
DECLARE d varchar(60) DEFAULT '';
DECLARE ligne varchar(100) DEFAULT '';
DECLARE tout varchar(6000) DEFAULT '';
DECLARE pr INT;
DECLARE st INT;
DECLARE stMin INT;
DECLARE stMax INT;
DECLARE c1 CURSOR FOR
SELECT
    *  
FROM
   article ;   
DECLARE
    CONTINUE HANDLER FOR NOT FOUND
SET done = TRUE;
OPEN c1;
debut:
LOOP
    FETCH c1 INTO c,d,pr,st,stMin, stMax;
    set ligne=concat(c,'	',d,'	',pr,'	',st,'	',stMin,'	', stMax);
    set tout=concat(tout,'
',ligne);
IF done THEN LEAVE debut;
END IF;
end LOOP;
select tout as 'code       des      prix     sto     smin     max';
CLOSE c1;
end$$

DROP PROCEDURE IF EXISTS `c100`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `c100` (IN `v` FLOAT)  BEGIN
DECLARE done INT DEFAULT FALSE;
DECLARE c int DEFAULT(0);
DECLARE d varchar(60) DEFAULT '';
DECLARE pr INT;
DECLARE st INT;
DECLARE stMin INT;
DECLARE stMax INT;
DECLARE c1 CURSOR FOR
SELECT
    *  
FROM
   article ;   
DECLARE
    CONTINUE HANDLER FOR NOT FOUND
SET done = TRUE;

OPEN c1;
debut:
LOOP
    FETCH c1 INTO c,d,pr,st,stMin, stMax;
    SELECT concat(c,'\t',d,'\t',pr,'\t',st,'\t',stMin,'\t', stMax);
    select'--------------------------------';
IF done THEN LEAVE debut;
END IF;
end LOOP ;

CLOSE c1;
end$$

DROP PROCEDURE IF EXISTS `Ex1`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Ex1` ()  BEGIN
select code_art, Desc_art
 from article;
end$$

DROP PROCEDURE IF EXISTS `Ex2`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Ex2` ()  BEGIN 
select code_cmd , count(code_art) as 'nombre_article'
from detail_cmd
group by code_cmd;
end$$

DROP PROCEDURE IF EXISTS `Ex3`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Ex3` ()  BEGIN 
select code_cmd , count(code_art) as 'nombre_article'
from detail_cmd
group by code_cmd;
end$$

DROP PROCEDURE IF EXISTS `Ex33`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Ex33` (IN `c` INT)  BEGIN 
select a.*
from article a,detail_cmd d
where a.code_art=d.code_art
and d.code_cmd=c;
end$$

DROP PROCEDURE IF EXISTS `Ex4`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Ex4` (`d1` DATE, `d2` DATE)  BEGIN 
select *
from commande
where date_cmd between d1 and d2;
end$$

DROP PROCEDURE IF EXISTS `Ex5`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Ex5` (`d1` DATE, `d2` DATE)  BEGIN
declare nbr int default 0;
select *
from commande
where date_cmd between d1 and d2;

select count(*)
into nbr 
from commande
where date_cmd between d1 and d2;

if nbr<50 THEN 
      select 'periode balnche';
ELSEIF nbr<100 THEN 
       select 'periode jaune';
else
select 'periode rouge';
end if;
end$$

DROP PROCEDURE IF EXISTS `Ex60`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Ex60` (IN `cmd` INT, IN `art` INT, IN `qt` INT)  BEGIN 
declare nbra int default 0;
declare nbrc int default 0;
declare x int default 0; 
select count(*) into nbra from article where code_art=art;
select Qte_stock into x from article where code_art=art;
select count(*) into nbrc from commande where code_cmd=cmd;
IF nbra=0 THEN
     select 'cet article n  existe pas';
ELSEIF x<qt THEN
     select ' stock  insuffisant';
ELSEIF nbrc=0 THEN
	begin
	insert into commande values(cmd, curdate());
    INSERT into detail_cmd values(cmd, art, qt);
    update article set qte_stock=qte_stock-qt WHERE code_art=art;
    end;
    
end if; 
end$$

DROP PROCEDURE IF EXISTS `Ex600`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Ex600` (`cmd` INT, `art` INT, `qt` INT)  BEGIN 
declare nbra int default 0;
declare nbrc int default 0;
declare x int default 0; 
select count(*) into nbra from article where code_art=art;
select Qte_stock into x from article where code_art=art;
select count(*) into nbrc from commande where code_cmd=cmd;
IF nbra=0 THEN
     select 'cet article n  existe pas';
ELSEIF x<qt THEN
     select ' stock  insuffisant';
ELSEIF nbrc=0 THEN
	insert into commande values(cmd, curdate());
 end if; 
end$$

DROP PROCEDURE IF EXISTS `ex7`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ex7` (OUT `nbr` INT)  begin
select count(*) 
into nbr 
from commande;
end$$

DROP PROCEDURE IF EXISTS `p10`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `p10` ()  BEGIN
create TEMPORARY table Listeclients(
codec int,
nomC varchar(60),
Adr varchar(60),
codev int,
email varchar(60));

insert INTO Listeclients select * from client;
select * from Listeclients;
drop table Listeclients;
end$$

DROP PROCEDURE IF EXISTS `p8`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `p8` (INOUT `x` INT)  BEGIN
SET @c =x;
select count(*) into x from livre where code_Livre=@c;
end$$

DROP PROCEDURE IF EXISTS `p9`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `p9` ()  BEGIN
create TEMPORARY table Listeclients(
codec int,
nomC varchar(60),
Adr varchar(60),
codev int,
email varchar(60));

insert INTO Listeclients select * from client;
select * from Listeclients;
end$$

DROP PROCEDURE IF EXISTS `sp1`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp1` (OUT `po_ErrMessage` VARCHAR(200))  BEGIN
 DECLARE EXIT HANDLER FOR SQLEXCEPTION
     BEGIN
         SET po_ErrMessage = 'Error in procedure sp1';
     END;
 SELECT * FROM article;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `article`
--

DROP TABLE IF EXISTS `article`;
CREATE TABLE IF NOT EXISTS `article` (
  `code_art` int(11) NOT NULL,
  `Desc_art` varchar(80) NOT NULL,
  `PU` float NOT NULL,
  `Qte_stock` int(11) NOT NULL,
  `Stock_Min` int(11) NOT NULL,
  `Stock_Max` int(11) NOT NULL,
  PRIMARY KEY (`code_art`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `article`
--

INSERT INTO `article` (`code_art`, `Desc_art`, `PU`, `Qte_stock`, `Stock_Min`, `Stock_Max`) VALUES
(1, 'clavier', 80, 60, 20, 100),
(2, 'ecran 17\'\'', 800, 3, 2, 10),
(3, 'souris', 80, 295, 20, 50),
(4, 'graveur', 300, 5, 2, 10);

-- --------------------------------------------------------

--
-- Structure de la table `client`
--

DROP TABLE IF EXISTS `client`;
CREATE TABLE IF NOT EXISTS `client` (
  `codeC` int(11) NOT NULL,
  `nomC` varchar(50) CHARACTER SET latin1 NOT NULL,
  `AdrC` varchar(50) CHARACTER SET latin1 DEFAULT NULL,
  `CodeV` int(11) DEFAULT NULL,
  `CIN` varchar(8) DEFAULT not NULL,
  `Email` varchar(50) CHARACTER SET latin1 DEFAULT NULL,
  PRIMARY KEY (`codeC`),
  KEY `CodeV` (`CodeV`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Déchargement des données de la table `client`
--

INSERT INTO `client` (`codeC`, `nomC`, `AdrC`, `CodeV`, `Email`) VALUES
(1, 'ysf', 'adr10', 10, 'ysf@'),
(2, 'smr', 'adr20', 20, 'smr@');

-- --------------------------------------------------------

--
-- Structure de la table `commande`
--

DROP TABLE IF EXISTS `commande`;
CREATE TABLE IF NOT EXISTS `commande` (
  `code_cmd` int(11) NOT NULL,
  `date_cmd` date NOT NULL,
  `codeC` int(11) NOT NULL,
  PRIMARY KEY (`code_cmd`),
  KEY `codeC` (`codeC`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `commande`
--

INSERT INTO `commande` (`code_cmd`, `date_cmd`, `codeC`) VALUES
(1, '2022-09-06', 1),
(2, '2017-09-05', 1),
(3, '2022-09-11', 1),
(4, '2022-09-11', 2),
(5, '2022-09-11', 2),
(6, '2022-09-11', 2);

-- --------------------------------------------------------

--
-- Structure de la table `detail_cmd`
--

DROP TABLE IF EXISTS `detail_cmd`;
CREATE TABLE IF NOT EXISTS `detail_cmd` (
  `code_cmd` int(11) NOT NULL,
  `code_art` int(11) NOT NULL,
  `Qté_comdé` int(11) NOT NULL,
  PRIMARY KEY (`code_cmd`,`code_art`),
  KEY `code_cmd` (`code_cmd`),
  KEY `code_art` (`code_art`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `detail_cmd`
--

INSERT INTO `detail_cmd` (`code_cmd`, `code_art`, `Qté_comdé`) VALUES
(1, 1, 2),
(1, 2, 10),
(1, 3, 2),
(1, 4, 5),
(2, 2, 2),
(2, 4, 5),
(5, 3, 5),
(6, 3, 5);

-- --------------------------------------------------------

--
-- Structure de la table `ville`
--

DROP TABLE IF EXISTS `ville`;
CREATE TABLE IF NOT EXISTS `ville` (
  `codev` int(11) NOT NULL,
  `nomv` varchar(50) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`codev`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Déchargement des données de la table `ville`
--

INSERT INTO `ville` (`codev`, `nomv`) VALUES
(10, 'agadir'),
(20, 'tanger');

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `client`
--
ALTER TABLE `client`
  ADD CONSTRAINT `client_ibfk_1` FOREIGN KEY (`CodeV`) REFERENCES `ville` (`codev`);

--
-- Contraintes pour la table `commande`
--
ALTER TABLE `commande`
  ADD CONSTRAINT `commande_ibfk_1` FOREIGN KEY (`codeC`) REFERENCES `client` (`codeC`);

--
-- Contraintes pour la table `detail_cmd`
--
ALTER TABLE `detail_cmd`
  ADD CONSTRAINT `detail_cmd_ibfk_1` FOREIGN KEY (`code_art`) REFERENCES `article` (`code_art`),
  ADD CONSTRAINT `detail_cmd_ibfk_2` FOREIGN KEY (`code_cmd`) REFERENCES `commande` (`code_cmd`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
