-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 17, 2024 at 07:44 AM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `courts`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `AdminID` int(250) NOT NULL,
  `Username` varchar(250) NOT NULL,
  `Password` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`AdminID`, `Username`, `Password`) VALUES
(1, 'Adreeta', '123456');

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `CustomerID` int(250) NOT NULL,
  `Username` varchar(250) NOT NULL,
  `Password` varchar(250) NOT NULL,
  `Address` varchar(1000) DEFAULT NULL,
  `Email` varchar(250) DEFAULT NULL,
  `PhoneNumber` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`CustomerID`, `Username`, `Password`, `Address`, `Email`, `PhoneNumber`) VALUES
(1, 'Semonty', '456789', 'ABC', 'abc@gmail.com', '+601222335566'),
(2, 'Sefina', '22233344', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `Id` int(4) NOT NULL,
  `proName` varchar(250) NOT NULL,
  `proDesc` varchar(500) NOT NULL,
  `price` int(11) NOT NULL,
  `imageName` varchar(1000) DEFAULT 'pinkCouch.png'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`Id`, `proName`, `proDesc`, `price`, `imageName`) VALUES
(1, 'bed', 'A cozy bedroom with soft lighting, plush bedding, and tranquil decor invites relaxation.', 11000, 'bed.png'),
(2, 'Pink Couch', 'A pink couch with fluffy cushions, inviting curves, and vibrant hue adds charm to any room.', 12000, 'pinkCouch.png'),
(3, 'Green Couch', 'A green couch with sleek lines, plush cushions, and earthy tones exudes comfort and style.', 12444, 'greenCouch.png'),
(6, 'table', 'circular wooden table with sleek modern design.', 12333, 'table.jpg'),
(8, 'Chandelier Lamp', 'Elegant crystal chandelier lamp, hanging gracefully, illuminating the room with brilliance', 52000, 'chandelierLamp.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `purchase`
--

CREATE TABLE `purchase` (
  `purchaseId` int(4) NOT NULL,
  `Username` varchar(250) DEFAULT NULL,
  `ProductId` varchar(4) DEFAULT NULL,
  `quantity` int(2) NOT NULL,
  `status` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `purchase`
--

INSERT INTO `purchase` (`purchaseId`, `Username`, `ProductId`, `quantity`, `status`) VALUES
(1, 'Semonty', '3', 6, 'Purchased'),
(2, 'Semonty', '1', 6, 'Purchased'),
(3, 'Semonty', '1', 6, 'Purchased'),
(4, 'Semonty', '7', 6, 'Purchased'),
(5, 'semonty', '8', 4, 'Purchased'),
(6, 'semonty', '8', 4, 'Purchased'),
(7, 'semonty', '8', 4, 'Purchased'),
(8, 'semonty', '6', 6, 'Purchased'),
(9, 'semonty', '1', 4, 'Purchased'),
(10, 'semonty', '1', 5, 'Purchased'),
(11, 'semonty', '6', 5, 'Purchased'),
(12, 'semonty', '3', 5, 'Purchased'),
(13, 'semonty', '2', 3, 'Purchased'),
(14, 'semonty', '3', 4, 'Purchased'),
(15, 'semonty', '6', 4, 'Purchased'),
(16, 'semonty', '1', 1, 'Purchased');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`AdminID`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`CustomerID`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `purchase`
--
ALTER TABLE `purchase`
  ADD PRIMARY KEY (`purchaseId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `AdminID` int(250) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `CustomerID` int(250) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `Id` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `purchase`
--
ALTER TABLE `purchase`
  MODIFY `purchaseId` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
