

CREATE TABLE "Staging"."temp_transactionsales" AS
SELECT * FROM "Staging"."transaction_sales";

SELECT COUNT(1) 
FROM temp_transactionsales
WHERE customer_name is NULL or customer_name = 'NULL'

UPDATE "Staging"."temp_transactionsales"
SET unit_price = ABS(unit_price)
WHERE unit_price < 0;

UPDATE "Staging"."temp_transactionsales"
SET product_name = 'UNKNOWN'
WHERE product_name is NULL or product_name = 'NULL'

UPDATE "Staging"."temp_transactionsales"
SET customer_name = 'UNKNOWN'
WHERE customer_name is NULL or customer_name = 'NULL'


