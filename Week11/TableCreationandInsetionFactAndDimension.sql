CREATE TABLE Date_Dim (
    date_id SERIAL PRIMARY KEY,
    date DATE,
    day INT,
    month INT,
    year INT
);

CREATE TABLE Product_Dim (
    product_pk SERIAL PRIMARY KEY,
	product_id VARCHAR(100),
    product_name VARCHAR(100)
);

-- Create Customer_Dim Table
CREATE TABLE Customer_Dim (
    customer_pk SERIAL PRIMARY KEY,
	customer_id VARCHAR(100),
    customer_name VARCHAR(100)
);


-- Create Sales_Fact Table
CREATE TABLE Sales_Fact (
    transaction_id INT PRIMARY KEY,
    date_id INT REFERENCES Date_Dim(date_id),
    product_pk INT REFERENCES Product_Dim(product_pk),
    customer_pk INT REFERENCES Customer_Dim(customer_pk),
    price NUMERIC(10, 2),
	quantity INT
);


INSERT INTO Date_Dim (date, day, month, year)
SELECT DISTINCT transaction_date, EXTRACT(day FROM transaction_date), EXTRACT(month FROM transaction_date), EXTRACT(year FROM transaction_date)
FROM "Staging"."temp_transactionsales";


INSERT INTO Product_Dim (product_id,product_name)
SELECT DISTINCT product_id,product_name
FROM "Staging"."temp_transactionsales";


INSERT INTO Customer_Dim (customer_id, customer_name)
SELECT DISTINCT customer_id, customer_name
FROM "Staging"."temp_transactionsales";

INSERT INTO Sales_Fact (transaction_id, date_id, product_pk, customer_pk, price, quantity)
SELECT d.date_id,
	p.product_id, 
	c.customer_id, 
	s.unit_price,
	s.quantity
FROM "Staging"."temp_transactionsales" s
JOIN Date_Dim d 
	ON s.transaction_date = d.date
JOIN Product_Dim p 
	ON UPPER(s.product_name) = UPPER(p.product_name)
JOIN Customer_Dim c 
	ON UPPER(s.customer_name) = UPPER(c.customer_name)
	