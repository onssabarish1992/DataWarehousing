-- Create Date_Dim Table
CREATE TABLE Date_Dim (
    date_id SERIAL PRIMARY KEY,
    date DATE,
    day INT,
    month INT,
    year INT
);

-- Create Product_Dim Table
CREATE TABLE Product_Dim (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50)
);

-- Create Customer_Dim Table
CREATE TABLE Customer_Dim (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(100),
    country VARCHAR(100)
);

-- Create Sales_Fact Table
CREATE TABLE Sales_Fact (
    sales_id SERIAL PRIMARY KEY,
    date_id INT REFERENCES Date_Dim(date_id),
    product_id INT REFERENCES Product_Dim(product_id),
    customer_id INT REFERENCES Customer_Dim(customer_id),
    price NUMERIC(10, 2)
);


