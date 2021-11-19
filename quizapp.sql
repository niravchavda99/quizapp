-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 19, 2021 at 02:35 PM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 8.0.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `quizapp`
--

-- --------------------------------------------------------

--
-- Table structure for table `questions`
--

CREATE TABLE `questions` (
  `questionid` varchar(8) NOT NULL,
  `question` varchar(100) NOT NULL,
  `option1` varchar(50) NOT NULL,
  `option2` varchar(50) NOT NULL,
  `option3` varchar(50) NOT NULL,
  `option4` varchar(50) NOT NULL,
  `answer` varchar(1) NOT NULL,
  `quizid` varchar(6) NOT NULL,
  `timestamp` datetime NOT NULL DEFAULT current_timestamp(),
  `qno` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `questions`
--

INSERT INTO `questions` (`questionid`, `question`, `option1`, `option2`, `option3`, `option4`, `answer`, `quizid`, `timestamp`, `qno`) VALUES
('4vkuSjsy', 'Question 3', 'Option 1', 'Option 2', 'Option 3', 'Option 4', 'B', 'giDaey', '2021-11-08 22:48:42', 0),
('a1b2c3d4', 'Who Invented C?', 'Mr. A', 'Mr. B', 'Mr. C', 'Mr. D', 'a', 'a1b2c3', '2021-10-18 11:54:58', 0),
('a1b2c3d5', 'Who invented Java?', 'Mr. A', 'Mr. B', 'Mr. C', 'Mr. D', 'b', 'a1b2c3', '2021-10-18 11:55:33', 0),
('c2OaldqB', 'Question 1', 'Option 1', 'Option 2', 'Option 3', 'Option 4', 'A', 'J9jqRr', '2021-11-14 13:17:12', 0),
('ckMURn16', 'Question 4', 'Option 1', 'Option 2', 'Option 3', 'Option 4', 'A', 'giDaey', '2021-11-08 22:48:49', 0),
('GAqKq1mo', 'Question 2', 'Option 1', 'Option 2', 'Option 3', 'Option 4', 'C', 'giDaey', '2021-11-08 22:48:35', 0),
('LCnGAEds', 'Question 2', 'Option 1', 'Option 2', 'Option 3', 'Option 4', 'B', 'QSeaQU', '2021-11-19 10:13:30', 0),
('OCgzXGMV', 'Question 1', 'Option 1', 'Option 2', 'Option 3', 'Option 4', 'D', 'giDaey', '2021-11-08 22:48:28', 0),
('qqOnTvKm', 'Question 1', 'Option 1', 'Option 2', 'Option 3', 'Option 4', 'A', 'QSeaQU', '2021-11-19 10:13:21', 0),
('sGTDKgBK', 'Question 3', 'Option 1', 'Option 2', 'Option 3', 'Option 4', 'C', 'QSeaQU', '2021-11-19 10:13:40', 0),
('XENWcHBR', 'What is your name?', 'Nirav', 'Milind', 'Pradip', 'Ajinkya', 'B', 'a1b2c3', '2021-10-29 17:06:03', 0);

-- --------------------------------------------------------

--
-- Table structure for table `quizes`
--

CREATE TABLE `quizes` (
  `quizid` varchar(6) NOT NULL,
  `topic` varchar(100) NOT NULL,
  `email` varchar(50) NOT NULL,
  `timestamp` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `quizes`
--

INSERT INTO `quizes` (`quizid`, `topic`, `email`, `timestamp`) VALUES
('a1b2c3', 'Topic 1', 'rajinkya26@gmail.com', '2021-10-18 10:33:32'),
('giDaey', 'Random Quiz', 'nmchavda855@gmail.com', '2021-11-08 22:48:10'),
('J9jqRr', 'Quiz 3', 'nmchavda99@gmail.com', '2021-10-17 20:25:36'),
('QSeaQU', 'Second Round', 'rajinkya26@gmail.com', '2021-11-19 10:13:12'),
('YoTShJ', 'C programming', 'skpradip88.pk@gmail.com', '2021-10-18 10:54:55');

-- --------------------------------------------------------

--
-- Table structure for table `responses`
--

CREATE TABLE `responses` (
  `questionid` varchar(8) NOT NULL,
  `email` varchar(50) NOT NULL,
  `recordedAnswer` varchar(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `responses`
--

INSERT INTO `responses` (`questionid`, `email`, `recordedAnswer`) VALUES
('a1b2c3d4', 'nmchavda99@gmail.com', 'b'),
('a1b2c3d5', 'nmchavda99@gmail.com', 'd'),
('XENWcHBR', 'nmchavda99@gmail.com', 'a'),
('a1b2c3d4', 'nmchavda99@gmail.com', 'b'),
('a1b2c3d4', 'nmchavda99@gmail.com', 'd'),
('a1b2c3d4', 'nmchavda99@gmail.com', 'c');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `name` varchar(30) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(25) NOT NULL,
  `phone` varchar(13) NOT NULL,
  `isVerified` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`name`, `email`, `password`, `phone`, `isVerified`) VALUES
('Nirav', 'nmchavda855@gmail.com', 'nirav', '9879847768', 1),
('Nirav Chavda', 'nmchavda99@gmail.com', 'niravchavda', '9879847769', 1),
('Ajinkya Rathod', 'rajinkya26@gmail.com', 'ajinkya', '9638709499', 1),
('Pradip Karmakar', 'skpradip88.pk@gmail.com', 'pradip', '8238118848', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`questionid`),
  ADD KEY `quizid` (`quizid`);

--
-- Indexes for table `quizes`
--
ALTER TABLE `quizes`
  ADD PRIMARY KEY (`quizid`),
  ADD KEY `email` (`email`);

--
-- Indexes for table `responses`
--
ALTER TABLE `responses`
  ADD KEY `questionid` (`questionid`),
  ADD KEY `email` (`email`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`email`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `questions`
--
ALTER TABLE `questions`
  ADD CONSTRAINT `questions_ibfk_1` FOREIGN KEY (`quizid`) REFERENCES `quizes` (`quizid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `quizes`
--
ALTER TABLE `quizes`
  ADD CONSTRAINT `quizes_ibfk_1` FOREIGN KEY (`email`) REFERENCES `users` (`email`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `responses`
--
ALTER TABLE `responses`
  ADD CONSTRAINT `responses_ibfk_1` FOREIGN KEY (`questionid`) REFERENCES `questions` (`questionid`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `responses_ibfk_2` FOREIGN KEY (`email`) REFERENCES `users` (`email`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
