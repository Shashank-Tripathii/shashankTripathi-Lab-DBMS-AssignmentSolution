/* create database */
CREATE database E_commerce;

use E_commerce; /* use databse */
SET FOREIGN_KEY_CHECKS = 0;

/* creating all the table as instructed in quert */

create table supplier(SUPP_ID int primary key, SUPP_NAME varchar(50) not null, SUPP_CITY varchar(50) not null, SUPP_PHONE varchar(50));
create table customer(CUS_ID int primary key, CUS_NAME varchar(20) not null, CUS_PHONE varchar(10) not null, CUS_CITY varchar(30), CUS_GENDER char);
create table category(CAT_ID int primary key, CAT_NAME varchar(20) not null);
create table product(PRO_ID int primary key, PRO_NAME varchar(20) DEFAULT "Dummy", PRO_DESC varchar(60), CAT_ID int, foreign key(CAT_ID) references category(CAT_ID));
create table supplier_pricing(PRICING_ID int primary key, PRO_ID int, foreign key(PRO_ID) references product(PRO_ID), SUPP_ID int, foreign key(SUPP_ID) references supplier(SUPP_ID), SUPP_PRICE int default 0);
create table orders(ORD_ID int primary key, ORD_AMOUNT int not null, ORD_DATE date not null, CUS_ID int, foreign key(CUS_ID) references customer(CUS_ID), PRICING_ID int, foreign key(PRICING_ID) references supplier_pricing(PRICING_ID));
create table rating(RAT_ID int primary key, ORD_ID int, foreign key(ORD_ID) references orders(ORD_ID), RAT_RATSTARS int not null);

/* insertion into supplier table */
insert into supplier values(1, "Rajesh Retails", "Delhi", 1234567890);
insert into supplier values(2, "Appario Ltd.", "Mumbai", 2589631470);
insert into supplier values(3, "Knome products ", "Bangalore", 9785462315);
insert into supplier values(4, "Bansal Retails", "Kochi", 8975463285);
insert into supplier values(5, "Mittal Ltd.", "Lucknow", 7898456532);

/* insertion into customer table */
insert into customer values(1, "AAKASH", 9999999999, "DELHI", "M");
insert into customer values(2, "AMAN", 9785463215, "NOIDA", "M");
insert into customer values(3, "NEHA", 9999999999, "MUMBAI", "F");
insert into customer values(4, "MEGHA", 9994562399, "KOLKATA", "F");
insert into customer values(5, "PULKIT", 7895999999, "LUCKNOW", "M");

/* insertion into category table */
insert into category values(1, "BOOKS");
insert into category values(2, "GAMES");
insert into category values(3, "GROCERIES");
insert into category values(4, "ELECTRONICS");
insert into category values(5, "CLOTHES");

/* insertion into product table */
insert into product values(1, "GTA V", "Windows 7 and above with i5 processor and 8GB RAM", 2);
insert into product values(2, "TSHIRT", "SIZE-L with Black, Blue and White variations", 5);
insert into product values(3, "ROG LAPTOP", "Windows 10 with 15inch screen, i7 processor, 1TB SSD", 4);
insert into product values(4, "OATS", "Highly Nutritious from Nestle", 3);
insert into product values(5, "HARRY POTTER", "Best Collection of all time by J.K Rowling", 1);
insert into product values(6, "MILK", "1L Toned MIlk", 3);
insert into product values(7, "Boat Earphones", "1.5Meter long Dolby Atmos", 4);
insert into product values(8, "Jeans", "Stretchable Denim Jeans with various sizes and color", 5);
insert into product values(9, "Project IGI", "compatible with windows 7 and above", 2);
insert into product values(10, "Hoodie", "Black GUCCI for 13 yrs and above", 5);
insert into product values(11, "Rich Dad Poor Dad", "Written by RObert Kiyosaki", 1);
insert into product values(12, "Train Your Brain", "By Shireen Stephen", 1);

/* insertion into supplier_pricing table */
insert into supplier_pricing values(1, 1, 2, 1500);
insert into supplier_pricing values(2, 3, 5, 30000);
insert into supplier_pricing values(3, 5, 1, 3000);
insert into supplier_pricing values(4, 2, 3, 2500);
insert into supplier_pricing values(5, 4, 1, 1000);

/* insertion into orders table */
insert into orders values(101, 1500, '2021-10-06', 2, 1);
insert into orders values(102, 1000, '2021-10-12', 3, 5);
insert into orders values(103, 30000, '2021-09-16', 5, 2);
insert into orders values(104, 1500, '2021-10-05', 1, 1);
insert into orders values(105, 3000, '2021-08-16', 4, 3);
insert into orders values(106, 1450, '2021-08-18', 1, 9);
insert into orders values(107, 789, '2021-09-01', 3, 7);
insert into orders values(108, 780, '2021-09-07', 5, 6);
insert into orders values(109, 3000, '2021-00-10', 5, 3);
insert into orders values(110, 2500, '2021-09-10', 2, 4);
insert into orders values(111, 1000, '2021-09-15', 4, 5);
insert into orders values(112, 789, '2021-09-16', 4, 7);
insert into orders values(113, 31000, '2021-09-16', 1, 8);
insert into orders values(114, 1000, '2021-09-16', 3, 5);
insert into orders values(115, 3000, '2021-09-16', 5, 3);
insert into orders values(116, 99, '2021-09-17', 2, 14);

/* insertion into rating table */
insert into rating values(1, 101, 4);
insert into rating values(2, 102, 3);
insert into rating values(3, 103, 1);
insert into rating values(4, 104, 2);
insert into rating values(5, 105, 4);
insert into rating values(6, 106, 3);
insert into rating values(7, 107, 4);
insert into rating values(8, 108, 4);
insert into rating values(9, 109, 3);
insert into rating values(10, 110, 5);
insert into rating values(11, 111, 3);
insert into rating values(12, 112, 4);
insert into rating values(13, 113, 2);
insert into rating values(14, 114, 1);
insert into rating values(15, 115, 1);
insert into rating values(16, 116, 0);

/* Ques 3 - Display the total number of customers based on gender who have placed orders of worth at least Rs.3000. */
SELECT CUS_GENDER, count(CUS_GENDER) as Total_Customer from customer where CUS_ID IN (select CUS_ID from orders where ORD_AMOUNT >=3000) group by CUS_GENDER;

/* Ques 4 - Display all the orders along with product name ordered by a customer having Customer_Id=2 */
SELECT *, (SELECT (SELECT p.PRO_NAME FROM product AS p WHERE p.PRO_ID = sp.PRO_ID) FROM supplier_pricing AS sp WHERE sp.PRICING_ID = o.PRICING_ID) AS product FROM orders AS o WHERE o.cus_id = 2;

/* Ques 5 - Display the Supplier details who can supply more than one product. */
SELECT *, (SELECT count(DISTINCT sp.PRO_ID) FROM supplier_pricing AS sp WHERE sp.SUPP_ID = s.SUPP_ID) AS products FROM supplier AS s HAVING products > 1;

/* Ques 6 - Find the least expensive product from each category and print the table with category id, name, product name and price of the product */
SELECT (SELECT (SELECT c.CAT_ID FROM category c WHERE c.CAT_ID = p.CAT_ID) FROM product p WHERE p.PRO_ID = sp.PRO_ID) AS CAT_ID,
    (SELECT (SELECT c.cat_name FROM category c WHERE c.CAT_ID = p.CAT_ID) FROM product p WHERE p.PRO_ID = sp.PRO_ID) AS category,
    (SELECT p.pro_name FROM product p WHERE p.PRO_ID = sp.PRO_ID) AS product, MIN(SUPP_PRICE) AS product_price FROM supplier_pricing AS sp GROUP BY category order by cat_id ASC;
    
/* Ques 7 - Display the Id and Name of the Product ordered after “2021-10-05” */
SELECT (SELECT sp.pro_id FROM supplier_pricing AS sp WHERE sp.PRICING_ID = o.PRICING_ID) as prod_id,
(SELECT (SELECT p.pro_name FROM product AS p WHERE p.PRO_ID = sp.PRO_ID) FROM supplier_pricing AS sp WHERE sp.PRICING_ID = o.PRICING_ID) AS product_name FROM orders AS o WHERE date(o.ord_date) > '2021-10-05';

/* Ques 8 - Display customer name and gender whose names start or end with character 'A'. */
SELECT CUS_NAME, CUS_GENDER FROM customer WHERE CUS_NAME LIKE '%a' OR CUS_NAME LIKE 'a%';

/* Ques 9 - Create a stored procedure to display supplier id, name, rating and Type_of_Service. For Type_of_Service, If rating =5, print “Excellent 
Service”,If rating >4 print “Good Service”, If rating >2 print “Average Service” else print “Poor Service” */

DELIMITER &&
CREATE PROCEDURE GetSupplierRatings ()
BEGIN
SELECT sp.SUPP_ID, (SELECT s.SUPP_NAME FROM supplier as s where s.SUPP_ID = sp.SUPP_ID) as Supplier_Name, 
(sum(r.RAT_RATSTARS)/count(r.RAT_RATSTARS) ) as Rating, (CASE
         WHEN (sum(r.RAT_RATSTARS)/count(r.RAT_RATSTARS) ) = 5 THEN "Excellent Service"
         WHEN (sum(r.RAT_RATSTARS)/count(r.RAT_RATSTARS) ) > 4 THEN "Good Service"
         WHEN (sum(r.RAT_RATSTARS)/count(r.RAT_RATSTARS) ) > 2 THEN "Average Service"
         ELSE "Poor Service" END) as type_of_service FROM rating AS r
        INNER JOIN orders as o ON r.ORD_ID = o.ORD_ID INNER JOIN supplier_pricing as sp ON sp.PRICING_ID = o.PRICING_ID group by sp.SUPP_ID order by SUPP_ID ASC;
END &&
DELIMITER ;

CALL GetSupplierRatings();




