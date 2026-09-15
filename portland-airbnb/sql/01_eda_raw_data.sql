USE data_sandbox;

-- ============================================================================
-- Pipeline: Portland Airbnb Staging Ingestion & EDA
-- Target Object: data_sandbox.raw_airbnb
-- Author: Data Engineering Sandbox
-- Description: Initial exploratory queries to profile source text anomalies 
--              prior to type-casting and schema normalization.
-- ============================================================================

-- [CHECK_01]: Validate total ingestion volume against source (Expect: ~486k)
SELECT 
    COUNT(*) AS total_rows 
FROM raw_airbnb;

-- [CHECK_02]: Smoke test dataset schema and structural integrity
SELECT 
    * 
FROM raw_airbnb 
LIMIT 5;

-- [CHECK_03]: Audit 'listings_price' formatting anomalies 
-- Note: Expecting currency symbols, commas, or empty strings inherent to raw extractions.
SELECT 
    listings_price, 
    COUNT(*) AS frequency
FROM raw_airbnb
GROUP BY listings_price
ORDER BY frequency DESC
LIMIT 20;

-- [CHECK_04]: Audit 'listings_rating' for placeholder tokens (e.g., '?', 'N/A')
-- Note: Required to determine casting strategy for numeric conversion.
SELECT 
    listings_rating, 
    COUNT(*) AS frequency
FROM raw_airbnb
GROUP BY listings_rating
ORDER BY frequency DESC
LIMIT 20;

-- [CHECK_05]: Validate categorical cardinality for room types
SELECT 
    listings_room_type, 
    COUNT(*) AS frequency
FROM raw_airbnb
GROUP BY listings_room_type
ORDER BY frequency DESC;