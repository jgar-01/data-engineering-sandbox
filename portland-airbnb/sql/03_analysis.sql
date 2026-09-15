USE data_sandbox;

-- ============================================================================
-- Pipeline: Portland Airbnb Analytical Layer
-- Source Object: data_sandbox.clean_airbnb
-- Description: Aggregates clean data to generate portfolio-ready market insights.
-- ============================================================================

-- [ANALYTIC_01]: Average price and rating by room type
SELECT 
    listings_room_type,
    COUNT(*) AS total_listings,
    ROUND(AVG(price), 2) AS avg_price,
    ROUND(AVG(rating), 2) AS avg_rating
FROM clean_airbnb
GROUP BY listings_room_type
ORDER BY avg_price DESC;

-- [ANALYTIC_02]: Price distribution brackets (Affordable vs. Premium)
SELECT 
    CASE 
        WHEN price < 100 THEN 'Budget (< $100)'
        WHEN price BETWEEN 100 AND 250 THEN 'Mid-Tier ($100 - $250)'
        ELSE 'Luxury (> $250)'
    END AS price_tier,
    COUNT(*) AS listing_count,
    ROUND(AVG(rating), 2) AS avg_tier_rating
FROM clean_airbnb
WHERE price IS NOT NULL
GROUP BY price_tier
ORDER BY listing_count DESC;