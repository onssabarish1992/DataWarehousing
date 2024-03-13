-- Step 1: Dump all data from staging to temporary tables	
CREATE TABLE temp_tblproduct AS
SELECT * FROM "Staging"."tbl_ProductsData";

-- Verify of the data exists in the temporary table
SELECT * FROM temp_tblproduct ORDER BY customer_id;

-- UPDATE textual columns with value as 'UNKNOWN' in case of NULL values

--UPDATE THE product name to UNKNOWN where it is NULL
UPDATE temp_tblproduct
SET product_name = 'UNKNOWN'z
WHERE product_name IS NULL OR UPPER(product_name) = 'NULL';

--UPDATE THE customer_name to UNKNOWN where it is NULL
UPDATE temp_tblproduct
SET customer_name = 'UNKNOWN'
WHERE customer_name IS NULL OR UPPER(customer_name) = 'NULL';

--UPDATE THE country to UNKNOWN where it is NULL
UPDATE temp_tblproduct
SET country = 'UNKNOWN'
WHERE country IS NULL OR UPPER(country) = 'NULL';

-- Correcting negative price values by taking absolute values
UPDATE temp_tblproduct
SET price = ABS(price)
WHERE price < 0;

-- Set price as 0 where it is NULL
UPDATE temp_tblproduct
SET price = 0
WHERE price IS NULL;
















