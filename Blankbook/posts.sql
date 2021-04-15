-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Apr 15, 2021 at 07:32 PM
-- Server version: 5.7.31
-- PHP Version: 7.3.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `posts`
--

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
CREATE TABLE IF NOT EXISTS `posts` (
  `PostId` int(11) NOT NULL AUTO_INCREMENT,
  `Title` varchar(255) NOT NULL,
  `Content` varchar(500) NOT NULL,
  `Author` varchar(50) NOT NULL,
  PRIMARY KEY (`PostId`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`PostId`, `Title`, `Content`, `Author`) VALUES
(1, 'Test', 'Lorem ipsum dolor sit amet.', 'Unkown'),
(2, 'test', 'testSQL', 'USER100'),
(3, 'apa', 'ananas', 'test123'),
(4, '12345121423312', 'ananas', 'test123'),
(5, 'testtest', 'teasdadsfadsfqasdf', 'Unkown'),
(6, 'aaaaaaaaaaaaaaaaaaaaaaaaaa', 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa', 'Unkown'),
(7, 'olivia', 'hej hej', 'Unkown'),
(8, 'hepp', 'hopp', 'Unkown'),
(9, 'emma', 'hepp hopp', 'Unkown'),
(10, 'first test with tags on create post', 'Lorem ipsum jhasdkfhasd f', 'Unkown'),
(11, 'marcus', 'redovisning', 'Unkown'),
(12, '1111', '1111', 'Unkown'),
(13, '78uihjnk', '87uihjkn', 'Unkown'),
(14, '78uihjnk', '87uihjkn', 'Unkown'),
(15, '134543435435', '435435453435', 'Unkown'),
(16, 'hsgdfhhdf', 'sfhhfddfhshdfs', 'Unkown'),
(17, '7iyky8ukyk', 'i6777', 'Unkown');

-- --------------------------------------------------------

--
-- Table structure for table `posttags`
--

DROP TABLE IF EXISTS `posttags`;
CREATE TABLE IF NOT EXISTS `posttags` (
  `PostId` int(11) NOT NULL,
  `TagId` int(11) NOT NULL,
  KEY `FK_PostId` (`PostId`),
  KEY `FK_TagId` (`TagId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `posttags`
--

INSERT INTO `posttags` (`PostId`, `TagId`) VALUES
(1, 1),
(2, 2),
(1, 12),
(1, 13),
(2, 14),
(3, 15),
(10, 16),
(10, 17),
(1, 18),
(11, 19),
(1, 20),
(12, 21),
(17, 22),
(2, 23),
(3, 24);

-- --------------------------------------------------------

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
CREATE TABLE IF NOT EXISTS `tags` (
  `TagId` int(11) NOT NULL AUTO_INCREMENT,
  `TagName` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`TagId`)
) ENGINE=MyISAM AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tags`
--

INSERT INTO `tags` (`TagId`, `TagName`) VALUES
(1, 'test'),
(2, 'nice'),
(3, 'amazing'),
(4, 'monkey'),
(5, 'asd'),
(6, 'asdsdfg'),
(7, '2345'),
(8, '6798'),
(9, '13280497'),
(10, '4861346'),
(11, 'asd'),
(12, '2357468'),
(13, 'ghghfaag'),
(14, 'test'),
(15, 'ananas'),
(16, 'ananas'),
(17, 'bugsEverywhere'),
(18, '3456'),
(19, 'redovisning'),
(20, '7777'),
(21, '1111'),
(22, '7k7ki77'),
(23, 'asd'),
(24, 'search');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
