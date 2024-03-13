SELECT * FROM "Staging"."temp_tblproduct" order by product_id;

-- Populate Date_Dim Table
INSERT INTO Date_Dim (date, day, month, year)
SELECT DISTINCT date_sales, EXTRACT(day FROM date_sales), EXTRACT(month FROM date_sales), EXTRACT(year FROM date_sales)
FROM "Staging"."temp_tblproduct";

-- Populate Product_Dim Table
INSERT INTO Product_Dim (product_name, category)
SELECT DISTINCT product_name, category
FROM "Staging"."temp_tblproduct";

-- Populate Customer_Dim Table
INSERT INTO Customer_Dim (customer_name, city, country)
SELECT DISTINCT customer_name, city, country
FROM "Staging"."temp_tblproduct";

--Populate Fact Table
INSERT INTO Sales_Fact (date_id, product_id, customer_id, price)
SELECT d.date_id, 
	p.product_id, 
	c.customer_id, 
	s.price
FROM "Staging"."temp_tblproduct" s
JOIN Date_Dim d 
	ON s.date_sales = d.date
JOIN Product_Dim p 
	ON UPPER(s.product_name) = UPPER(p.product_name)
	AND UPPER(s.category) = UPPER(p.category)
JOIN Customer_Dim c 
	ON UPPER(s.customer_name) = UPPER(c.customer_name)
	AND UPPER(s.city) = UPPER(c.city) 
	AND UPPER(s.country) = UPPER(c.country);




