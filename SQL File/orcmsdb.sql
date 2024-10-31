-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 02, 2023 at 03:34 AM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `orcmsdb`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbladmin`
--

CREATE TABLE `tbladmin` (
  `ID` int(11) NOT NULL,
  `AdminName` varchar(45) DEFAULT NULL,
  `UserName` varchar(45) DEFAULT NULL,
  `MobileNumber` bigint(11) DEFAULT NULL,
  `Email` varchar(120) DEFAULT NULL,
  `Password` varchar(120) DEFAULT NULL,
  `AdminRegdate` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tbladmin`
--

INSERT INTO `tbladmin` (`ID`, `AdminName`, `UserName`, `MobileNumber`, `Email`, `Password`, `AdminRegdate`) VALUES
(1, 'Admin', 'admin', 7894561239, 'test@gmail.com', 'f925916e2754e5e03f75dd58a5733251', '2023-04-18 18:30:00');

-- --------------------------------------------------------

--
-- Table structure for table `tblcategory`
--

CREATE TABLE `tblcategory` (
  `ID` int(5) NOT NULL,
  `CategoryName` varchar(120) DEFAULT NULL,
  `CreationDate` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tblcategory`
--

INSERT INTO `tblcategory` (`ID`, `CategoryName`, `CreationDate`) VALUES
(3, 'Itallian', '2023-04-16 18:30:00'),
(4, 'Thai', '2023-04-16 18:30:00'),
(5, 'South Indian', '2023-04-16 18:30:00'),
(6, 'North Indian', '2023-04-16 18:30:00'),
(7, 'Desserts', '2023-04-16 18:30:00'),
(8, 'Starters', '2023-04-16 18:30:00'),
(9, 'Chinease', '2023-04-16 18:30:00'),
(12, 'Continental Food', '2023-04-17 13:22:45');

-- --------------------------------------------------------

--
-- Table structure for table `tblfood`
--

CREATE TABLE `tblfood` (
  `ID` int(10) NOT NULL,
  `CategoryName` varchar(120) DEFAULT NULL,
  `ItemName` varchar(120) DEFAULT NULL,
  `ItemPrice` varchar(120) DEFAULT NULL,
  `ItemDes` varchar(500) DEFAULT NULL,
  `Image` varchar(120) DEFAULT NULL,
  `ItemQty` varchar(120) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tblfood`
--

INSERT INTO `tblfood` (`ID`, `CategoryName`, `ItemName`, `ItemPrice`, `ItemDes`, `Image`, `ItemQty`) VALUES
(1, 'Itallian', 'Polenta', '256', 'polenta, a porridge or mush usually made of ground corn (maize) cooked in salted water. Cheese and butter or oil are often added. Polenta can be eaten hot or cold as a porridge, or it can be cooled until firm, cut into shapes, and then baked, toasted, panfried, or deep-fried. It is a traditional food of northern Italy, especially the Piedmont region, and of Corsica, where chestnut flour is used in place of cornmeal. Polenta is also sometimes made from barley meal.                                ', '838bbb95d27c9240cab0bbc2ea14f78c.jpg', '1 Bowl'),
(2, 'Itallian', 'Lasagna', '156', ' Lasagna is a wide, flat sheet of pasta. Lasagna can refer to either the type of noodle or to the typical lasagna dish which is a dish made with several layers of lasagna sheets with sauce and other ingredients, such as meats and cheese, in between the lasagna noodles.                                          	', '96199470625de385775151cf45708ec5.jpg', '1'),
(3, 'Thai', 'Pad Kra Prao', '196', 'Pad krapow is one of the most popular and easy to prepare dishes from Thai cuisine. Holy basil (called bai krapow) is stir-fried along with a source of protein (stuffed meat, fried fish or tofu), garlic, chilli peppers and other typical Thai flavourings. Sometimes green beans or spring onions are also added.                                               	', '063ea38b99022c22708b03dfc477ea91.jpg', '1'),
(4, 'Thai', 'Khao Soi', '150', ' Khao Soi is a deliciously rich, creamy, slightly spicy yellow curry dish originating in Northern Thailand. This classic Northern Thai soup will satisfy your craving for a Thai curry dish combined with tender braised meat (chicken, beef are favorites) in a coconut curry broth with boiled and fried noodles.                                         	', 'fdd923a9015cd896b4610d47b251b6a9.jpg', '1'),
(5, 'South Indian', 'Idli', '50', '     Idli is a steamed dish made with a batter of rice and urad. Wholesome and satiating, idlis can be had for breakfast, dinner, or as an evening snack. Served with sambhar and chutneys, it is one of the most favourite snacks in South India                                         	', '751363a5c24f438bfbef2b26455d3ad7.jpg', '1 Plate(4 Idli)'),
(6, 'South Indian', 'Dosa', '120', 'A dosa, also called dosai, is a thin pancake in South Indian cuisine made from a fermented batter of ground black lentils and ric                        	', 'bb5e3d3cff477ef0ac3e8bedf2b68f58.jpg', '1 Plate'),
(7, 'North Indian', 'Chole Bhature', '85', '          Chole bhature (Hindi: à¤›à¥‹à¤²à¥‡ à¤­à¤Ÿà¥‚à¤°à¥‡) is a food dish popular in the Northern areas of the Indian subcontinent. It is a combination of chana masala (spicy white chickpeas) and bhatura/puri, a deep-fried bread made from maida.                                       	', '85ebab7c2b1232c1d9688251c9f123ce.jpg', '1 Plate'),
(8, 'North Indian', 'Dal Makhani', '60', 'Dal Makhani is one of the most popular lentil recipes from the North Indian Punjabi cuisine made with Whole Black Lentils                                                 	', 'ed012399adc1445122c97003a2f8e496.jpg', '1 bowl'),
(9, 'North Indian', 'Kadhi Chawal', '100', 'Kadhi chawal is sour dahi kadhi prepared with curd, besan, masalas and given a tadka of dried red chilly and served with besan pakodas.                                                 	', 'd29dcc71d1e33f7f5c1acc991bcf88b5.jpg', '1 Plate'),
(10, 'Chinease', 'Dumplings', '126', '    In Asian cuisines, dumplings are delicate, bite-sized treats of different fillings wrapped in a thin layer of dough. They can be both savoury and sweet, and may be boiled, steamed and fried - the choice is yours!                                             	', 'dbe8c1faa78c87fb239983a94a896792.jpg', '1 Plate(6 pcs)'),
(11, 'Chinease', 'Sweet and Sour Pork.', '250', '   A classic Chinese sweet and sour pork stir-fry recipe made with juicy pieces of pork tenderloin, bell peppers, onion, and pineapple.                                              	', '8ca7771b8453f042b71b695e640bc1ea.jpg', '1 plate'),
(12, 'Chinease', 'Dim Sum', '250', 'Dim sum is a traditional Chinese meal made up of small plates of dumplings and other snack dishes and is usually accompanied by tea. Similar to the way that the Spanish eat tapas, the dishes are shared among family and friends. Typically dim sum is consumed during brunch hours                                             	', '0dab6fe960109559ff3c6302a914eb1e.jpg', '1 Plate'),
(13, 'Continental Food', 'Crispy Calamari Rings', '150', 'About Crispy Calamari Rings Recipe: A quick and easy snack recipe, calamari rings are basically squid rings deep fried in tempura batter and served hot.                                                 	', '93dc0c806fa6c148de84125f26f689f4.jpg', '1 Plate'),
(14, 'Continental Food', 'Stuffed Jacket Potatoes', '200', ' Stuffed Jacket Potatoes is a very popular dish in Australia which requires very minimal cooking and is best served with dips.                                                	', '819a960d94c2fca1b091350ac65e110d.jpg', '1 plate(8pcs)'),
(15, 'Continental Food', 'Stuffed Jacket Potatoes', '200', ' Stuffed Jacket Potatoes is a very popular dish in Australia which requires very minimal cooking and is best served with dips.                                                	', '819a960d94c2fca1b091350ac65e110d.jpg', '1 plate(8pcs)');

-- --------------------------------------------------------

--
-- Table structure for table `tblfoodtracking`
--

CREATE TABLE `tblfoodtracking` (
  `ID` int(10) NOT NULL,
  `OrderId` char(50) DEFAULT NULL,
  `remark` varchar(200) DEFAULT NULL,
  `status` char(50) DEFAULT NULL,
  `StatusDate` timestamp NULL DEFAULT current_timestamp(),
  `OrderCanclledByUser` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tblfoodtracking`
--

INSERT INTO `tblfoodtracking` (`ID`, `OrderId`, `remark`, `status`, `StatusDate`, `OrderCanclledByUser`) VALUES
(1, '406738481', 'Order Confirmed', 'Order Confirmed', '2023-04-20 05:46:25', NULL),
(2, '406738481', 'Food Being Prepared', 'Food being Prepared', '2023-04-20 05:46:55', NULL),
(3, '406738481', 'Food has been taken from resturent', 'Food Pickup', '2023-04-20 05:47:28', NULL),
(4, '406738481', 'Food has been delivered', 'Food Delivered', '2023-04-20 05:47:54', NULL),
(5, '846328328', 'Order Cancelled', 'Order Cancelled', '2023-04-20 05:48:26', NULL),
(6, '217126320', 'Cancel', 'Order Cancelled', '2023-04-20 05:49:31', 1),
(7, '514273677', 'order Confirmed', 'Order Confirmed', '2023-04-30 17:36:54', NULL),
(8, '107201891', 'Order confirmed', 'Order Confirmed', '2023-05-01 06:45:05', NULL),
(9, '107201891', 'Food preparing', 'Food being Prepared', '2023-05-01 06:45:41', NULL),
(10, '107201891', 'Food picked up for delivery', 'Food Pickup', '2023-05-01 06:45:57', NULL),
(11, '107201891', 'Delivered successfully', 'Food Delivered', '2023-05-01 06:46:09', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tblorderaddresses`
--

CREATE TABLE `tblorderaddresses` (
  `ID` int(11) NOT NULL,
  `UserId` char(100) DEFAULT NULL,
  `Ordernumber` char(100) DEFAULT NULL,
  `PNRNumber` varchar(255) DEFAULT NULL,
  `TrainName` varchar(255) DEFAULT NULL,
  `TrainNumber` varchar(255) DEFAULT NULL,
  `Coach` varchar(50) DEFAULT NULL,
  `Berth` varchar(255) DEFAULT NULL,
  `Station` varchar(250) DEFAULT NULL,
  `FoodType` varchar(250) DEFAULT NULL,
  `OrderTime` timestamp NOT NULL DEFAULT current_timestamp(),
  `OrderFinalStatus` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tblorderaddresses`
--

INSERT INTO `tblorderaddresses` (`ID`, `UserId`, `Ordernumber`, `PNRNumber`, `TrainName`, `TrainNumber`, `Coach`, `Berth`, `Station`, `FoodType`, `OrderTime`, `OrderFinalStatus`) VALUES
(1, '5', '406738481', 'KL098765432', 'Satabdi Express', 'STB-67996', 'C1', '45', 'Kannauj', 'Lunch', '2023-04-20 05:44:02', 'Food Delivered'),
(2, '5', '846328328', 'PNR798987', 'Kashi Viswanath', 'KV908753', 'B1', '52', 'Varanasi', 'Dinner', '2023-04-20 05:45:40', 'Order Cancelled'),
(3, '5', '217126320', 'PNR354456', 'ggh', 'hghg', 'jhgg', 'ghjg', 'jhgjh', 'Lunch', '2023-04-20 05:49:11', 'Order Cancelled'),
(4, '1', '514273677', '6345456', 'Shiv Ganga', '12559', 'A2', '45', 'Kanpur', 'Breakfast', '2023-04-30 13:30:53', 'Order Confirmed'),
(5, '6', '107201891', '34634666', 'Vande Bharat', '54646', 'A5', '56', 'Ghaziabad', 'Dinner', '2023-05-01 06:43:43', 'Food Delivered');

-- --------------------------------------------------------

--
-- Table structure for table `tblorders`
--

CREATE TABLE `tblorders` (
  `ID` int(11) NOT NULL,
  `UserId` char(10) DEFAULT NULL,
  `FoodId` char(10) DEFAULT NULL,
  `FoodQty` int(11) DEFAULT NULL,
  `IsOrderPlaced` int(11) DEFAULT NULL,
  `OrderNumber` char(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tblorders`
--

INSERT INTO `tblorders` (`ID`, `UserId`, `FoodId`, `FoodQty`, `IsOrderPlaced`, `OrderNumber`) VALUES
(1, '5', '2', 2, 1, '406738481'),
(2, '5', '5', 5, 1, '406738481'),
(3, '5', '1', 1, 1, '406738481'),
(4, '', '14', 1, NULL, NULL),
(5, '5', '7', 1, 1, '846328328'),
(6, '5', '1', 10, 1, '217126320'),
(7, '1', '1', 1, 1, '514273677'),
(8, '1', '2', 1, NULL, NULL),
(9, '6', '1', 1, 1, '107201891'),
(10, '6', '2', 2, 1, '107201891');

-- --------------------------------------------------------

--
-- Table structure for table `tbluser`
--

CREATE TABLE `tbluser` (
  `ID` int(10) NOT NULL,
  `FirstName` varchar(45) DEFAULT NULL,
  `LastName` varchar(50) DEFAULT NULL,
  `Email` varchar(120) DEFAULT NULL,
  `MobileNumber` bigint(11) DEFAULT NULL,
  `Password` varchar(120) DEFAULT NULL,
  `RegDate` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tbluser`
--

INSERT INTO `tbluser` (`ID`, `FirstName`, `LastName`, `Email`, `MobileNumber`, `Password`, `RegDate`) VALUES
(1, 'Anuj', 'Kumar', 'test@gmail.com', 1234567890, 'f925916e2754e5e03f75dd58a5733251', '2023-04-04 04:31:04'),
(3, 'Test', 'User', 'testuser@gmail.com', 1236547890, 'f925916e2754e5e03f75dd58a5733251', '2023-04-05 12:28:41'),
(4, 'Mahesh', 'Singh', 'mah@gmail.com', 8686876876, '202cb962ac59075b964b07152d234b70', '2023-04-17 06:20:17'),
(5, 'Kinjal', 'Singh', 'kinjal@gmail.com', 7797987987, '202cb962ac59075b964b07152d234b70', '2023-04-19 06:47:43'),
(6, 'John', 'Doe', 'john@test.com', 1425632541, 'f925916e2754e5e03f75dd58a5733251', '2023-05-01 06:42:31');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbladmin`
--
ALTER TABLE `tbladmin`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `tblcategory`
--
ALTER TABLE `tblcategory`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `CategoryName` (`CategoryName`);

--
-- Indexes for table `tblfood`
--
ALTER TABLE `tblfood`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `tblfoodtracking`
--
ALTER TABLE `tblfoodtracking`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `tblorderaddresses`
--
ALTER TABLE `tblorderaddresses`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `UserId` (`UserId`,`Ordernumber`);

--
-- Indexes for table `tblorders`
--
ALTER TABLE `tblorders`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `UserId` (`UserId`,`FoodId`,`OrderNumber`);

--
-- Indexes for table `tbluser`
--
ALTER TABLE `tbluser`
  ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbladmin`
--
ALTER TABLE `tbladmin`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tblcategory`
--
ALTER TABLE `tblcategory`
  MODIFY `ID` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `tblfood`
--
ALTER TABLE `tblfood`
  MODIFY `ID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `tblfoodtracking`
--
ALTER TABLE `tblfoodtracking`
  MODIFY `ID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `tblorderaddresses`
--
ALTER TABLE `tblorderaddresses`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `tblorders`
--
ALTER TABLE `tblorders`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `tbluser`
--
ALTER TABLE `tbluser`
  MODIFY `ID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
