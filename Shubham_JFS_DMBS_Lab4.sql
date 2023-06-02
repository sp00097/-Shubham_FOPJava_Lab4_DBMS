create database if not exists ecommerce;
USE ECOMMERCE;

--
-- Table structure for table `category`
--

CREATE TABLE IF NOT EXISTS CATEGORY(
CAT_ID INT,
CAT_NAME VARCHAR(20) NOT NULL,
PRIMARY KEY(CAT_ID));

--
-- Dumping data for table `category`
--

INSERT INTO CATEGORY(CAT_ID,CAT_NAME) VALUES
(1,'BOOKS'),
(2,'GAMES'),
(3,'GROCERIES'),
(4,'ELECTRONICS'),
(5,'CLOTHES');

-- --------------------------------------------------------

--
-- Table structure for table `product`
--


CREATE TABLE IF NOT EXISTS PRODUCT(
PRO_ID INT,
PRO_NAME VARCHAR(20) NOT NULL DEFAULT 'DUMMY',
PRO_DESC VARCHAR(60),
CAT_ID INT,
PRIMARY KEY(PRO_ID),
foreign key(CAT_ID) references CATEGORY(CAT_ID));


--
-- Dumping data for table `product`
--

INSERT INTO PRODUCT(PRO_ID,PRO_NAME,PRO_DESC,CAT_ID) VALUES
(1,'GTA V','Windows7 and above with i5 processor and 8GB RAM',2),
(2,'TSHIRT','SIZE-L with Black Blue and White variations',5),
(3,'ROG LAPTOP','Windows10 with 15inch screen i7 processor 1TB SSD',4),
(4,'OATS','Highly Nutritious from Nestle',3),
(5,'HARRY POTTER','Best Collection of all time by J.K Rowling',1),
(6,'MILK','1L Toned MIlk',3),
(7,'Boat Earphones','1.5Meter long Dolby Atmos',4),
(8,'Jeans','Stretchable Denim Jeans with various sizes and color',5),
(9,'Project IGI','compatible with windows 7 and above',2),
(10,'Hoodie','Black GUCCI for 13 yrs and above',5),
(11,'Rich Dad Poor Dad','Written by RObertKiyosaki',1),
(12,'Train Your Brain','ByShireen Stephen',1);

-- --------------------------------------------------------

--
-- Table structure for table `supplier`
--

CREATE TABLE IF NOT EXISTS SUPPLIER(
SUPP_ID INT PRIMARY KEY,
SUPP_NAME VARCHAR(50) NOT NULL,
SUPP_CITY VARCHAR(50) NOT NULL,
SUPP_PHONE VARCHAR(50) NOT NULL);

--
-- Dumping data for table `supplier`
--



INSERT INTO SUPPLIER(SUPP_ID,SUPP_NAME,SUPP_CITY,SUPP_PHONE) VALUES
(1,'Rajesh Retails','Delhi',1234567890),
(2,'Appario Ltd.','Mumbai',2589631470),
(3,'Knome products','Banglore',9785462315),
(4,'Bansal Retails','Kochi',8975463285),
(5,'Mittal Ltd.','Lucknow',7898456532);

-- --------------------------------------------------------

--
-- Table structure for table `supplier_pricing`
--


CREATE TABLE IF NOT EXISTS SUPPLIER_PRICING(
PRICING_ID INT PRIMARY KEY,
PRO_ID INT,
SUPP_ID INT,
SUPP_PRICE INT DEFAULT 0,
foreign key(PRO_ID) references PRODUCT(PRO_ID),
foreign key(SUPP_ID) references SUPPLIER(SUPP_ID));

--
-- Dumping data for table `supplier_pricing`
--

INSERT INTO SUPPLIER_PRICING(PRICING_ID,PRO_ID,SUPP_ID,SUPP_PRICE) VALUES
(1, 1, 2, 1500),
(2, 3, 5, 30000),
(3, 5, 1, 3000),
(4, 2, 3, 2500),
(5, 4, 1, 1000),
(6, 12, 2, 780),
(7, 12, 4, 789),
(8, 3, 1, 31000),
(9, 1, 5, 1450),
(10, 4, 2, 999),
(11, 7, 3, 549),
(12, 7, 4, 529),
(13, 6, 2, 105),
(14, 6, 1, 99),
(15, 2, 5, 2999),
(16, 5, 2, 2999);

--
-- Table structure for table `customer`
--


CREATE TABLE IF NOT EXISTS CUSTOMER(
CUS_ID INT PRIMARY KEY,
CUS_NAME VARCHAR(20) NOT NULL,
CUS_PHONE VARCHAR(10) NOT NULL,
CUS_CITY VARCHAR(30) NOT NULL,
CUS_GENDER CHAR);

--
-- Dumping data for table `customer`
--


INSERT INTO CUSTOMER(CUS_ID,CUS_NAME,CUS_PHONE,CUS_CITY,CUS_GENDER) VALUES
(1,'AAKASH',9999999999,'DELHI','M'),
(2,'AMAN',9785463215,'NOIDA','M'),
(3,'NEHA',9999999999,'MUMBAI','F'),
(4,'MEGHA',9994562399,'KOLKATA','F'),
(5,'PULKIT',7895999999,'LUCKNOW','M');


-- --------------------------------------------------------

--
-- Table structure for table `orders`
--


CREATE TABLE IF NOT EXISTS ORDERS(
ORD_ID INT PRIMARY KEY,
ORD_AMOUNT INT NOT NULL,
ORD_DATE DATE NOT NULL,
CUS_ID INT,
PRICING_ID INT,
FOREIGN KEY (CUS_ID) REFERENCES CUSTOMER(CUS_ID),
FOREIGN KEY (PRICING_ID) REFERENCES SUPPLIER_PRICING(PRICING_ID));

--
-- Dumping data for table `orders`
--


INSERT INTO `orders` (`ord_id`, `ord_date`, `cus_id`, `pricing_id`, `ord_amount`) VALUES
(101, '2021-10-06', 2, 1, 1500),
(102, '2021-10-12', 3, 5, 1000),
(103, '2021-09-16', 5, 2, 30000),
(104, '2021-10-05', 1, 1, 1500),
(105, '2021-08-16', 4, 3, 3000),
(106, '2021-08-18', 1, 9, 1450),
(107, '2021-09-01', 3, 7, 789),
(108, '2021-09-07', 5, 6, 780),
(109, '2021-09-10', 5, 3, 3000),
(110, '2021-09-10', 2, 4, 2500),
(111, '2021-09-15', 4, 5, 1000),
(112, '2021-09-16', 4, 7, 789),
(113, '2021-09-16', 1, 8, 31000),
(114, '2021-09-16', 3, 5, 1000),
(115, '2021-09-16', 5, 3,3000),
(116, '2021-09-17', 2, 14,99);

-- --------------------------------------------------------

--
-- Table structure for table `rating`
--

CREATE TABLE IF NOT EXISTS RATING(
RAT_ID INT PRIMARY KEY,
ORD_ID INT,
RAT_RATSTARS INT NOT NULL,
foreign key(ORD_ID) references ORDERS(ORD_ID));

--
-- Dumping data for table `rating`
--

INSERT INTO RATING(RAT_ID,ORD_ID,RAT_RATSTARS) VALUES
(1, 101, 4),
(2, 102, 3),
(3, 103, 1),
(4, 104, 2),
(5, 105, 4),
(6, 106, 3),
(7, 107, 4),
(8, 108, 4),
(9, 109, 3),
(10, 110, 5),
(11, 111, 3),
(12, 112, 4),
(13, 113, 2),
(14, 114, 1),
(15, 115, 1),
(16, 116, 0);
