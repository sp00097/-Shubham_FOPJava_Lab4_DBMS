/*Display the total number of customers 
based on gender who have placed 
individual orders of worth at least Rs.3000*/

SELECT 
    CUS_GENDER, COUNT(CUS_NAME) AS 'No.of Customers'
FROM
    CUSTOMER
        JOIN
    ORDERS USING (CUS_ID)
WHERE ORD_AMOUNT >= 3000
GROUP BY CUS_GENDER;

/*Display all the orders along with product name ordered by a customer having Customer_Id=2.*/

SELECT 
    CUS_ID,ORD_ID, PRO_NAME,ORD_AMOUNT
FROM
    ORDERS
        JOIN
    CUSTOMER USING (CUS_ID)
        JOIN
    SUPPLIER_PRICING USING (PRICING_ID)
        JOIN
    PRODUCT USING (PRO_ID)
WHERE
    CUS_ID = 2;
   
   
   /*Display the Supplier details who can supply more than one product.*/
SELECT 
    SUPP_ID,SUPP_NAME,SUPP_CITY,SUPP_PHONE
FROM
    SUPPLIER
        JOIN
    SUPPLIER_PRICING USING (SUPP_ID)
    JOIN 
    PRODUCT USING (PRO_ID) GROUP BY SUPP_ID,SUPP_NAME HAVING COUNT(PRO_NAME)>1 ;
    
    /*Find the least expensive product from each category
 and print the table with category id, name, product name and price of the product*/
 
SELECT 
    CAT_ID, CAT_NAME, PRO_NAME, SUPP_PRICE
FROM
    CATEGORY
        JOIN
    PRODUCT USING (CAT_ID)
        JOIN
    SUPPLIER_PRICING USING (PRO_ID)
WHERE
    (CAT_ID , SUPP_PRICE) IN (SELECT 
            CAT_ID, MIN(SUPP_PRICE)
        FROM
            PRODUCT
                JOIN
            SUPPLIER_PRICING USING (PRO_ID)
            JOIN
            CATEGORY USING(CAT_ID)
        GROUP BY CAT_ID)
ORDER BY CAT_ID;

/*Display the Id and Name of the Product ordered after “2021-10-05”*/
SELECT 
    PRO_ID, PRO_NAME, ORD_DATE
FROM
    PRODUCT
        JOIN
    SUPPLIER_PRICING USING (PRO_ID)
        JOIN
    ORDERS USING (PRICING_ID)
WHERE
    ORD_DATE > '2021-10-05';
    
    
    /*Display customer name and gender whose names start or end with character 'A'*/

SELECT 
    CUS_NAME, CUS_GENDER
FROM
    CUSTOMER
WHERE
    CUS_NAME LIKE 'A%' OR '%A';
    
    
    /*Create a stored procedure to display supplier id, name, 
Rating(Average rating of all the products sold by every customer) and Type_of_Service.
 For Type_of_Service, If rating =5, print “Excellent Service”,If rating >4 print “Good Service”, 
 If rating >2 print “Average Service” else print “Poor Service”. 
 Note that there should be one rating per supplier.
*/
DELIMITER //
CREATE PROCEDURE GetSupplierDetailss()
BEGIN
 SELECT 
    SUPP_ID,
    SUPP_NAME,
    AVG(RAT_RATSTARS) AS 'RATING',
    CASE
        WHEN AVG(RAT_RATSTARS) = 5 THEN 'Excellent Service'
        WHEN AVG(RAT_RATSTARS) > 4 THEN 'Good Service'
        WHEN AVG(RAT_RATSTARS) > 2 THEN 'Average Service'
        ELSE 'Poor Service'
    END AS TYPE_OF_SERVICE
FROM
    SUPPLIER
        JOIN
    SUPPLIER_PRICING USING (SUPP_ID)
        JOIN
    ORDERS USING (PRICING_ID)
        JOIN
    RATING USING (ORD_ID) GROUP BY SUPP_ID ORDER BY SUPP_ID;
    END//
    
    CALL GetSupplierDetailss();