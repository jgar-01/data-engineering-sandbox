USE data_sandbox;

-- ============================================================================
-- Pipeline: Portland Airbnb Data Transformation & Normalization
-- Source Object: data_sandbox.raw_airbnb
-- Target Object: data_sandbox.clean_airbnb
-- Description: Cleans staging text fields, extracts numeric ratings from 
--              artifact-heavy strings, and materializes production tables.
-- ============================================================================

CREATE TABLE clean_airbnb AS
SELECT 
    listings_room_type,
    
    -- Cast price to standard decimal format
    CAST(NULLIF(listings_price, '') AS DECIMAL(10,2)) AS price,
    
    -- Extract numeric pattern for rating, fallback to NULL if non-numeric/artifact
    CASE 
        WHEN listings_rating REGEXP '[0-9]' THEN 
            CAST(REGEXP_REPLACE(listings_rating, '[^0-9.]', '') AS DECIMAL(3,2))
        ELSE NULL
    END AS rating

FROM raw_airbnb
WHERE listings_room_type IS NOT NULL 
  AND TRIM(listings_room_type) != '';


-- [VERIFICATION]: Confirm row counts and check if ratings successfully populated
SELECT COUNT(*) AS total_rows, COUNT(rating) AS valid_ratings_count FROM clean_airbnb;
SELECT * FROM clean_airbnb WHERE rating IS NOT NULL LIMIT 10;

-- [VERIFICATION]: Check that ratings are now populated correctly
SELECT COUNT(*) AS total_rows, COUNT(rating) AS non_null_ratings FROM clean_airbnb;
SELECT listings_rating, rating FROM clean_airbnb LIMIT 10;
