-- 1. CTR by channel (Click-Through Rate)
SELECT channel,
       SUM(clicks) AS total_clicks,
       SUM(impressions) AS total_impressions,
       ROUND( (SUM(clicks)*1.0 / NULLIF(SUM(impressions),0)) * 100, 3) AS ctr_percent
FROM marketing
GROUP BY channel
ORDER BY ctr_percent DESC;

-- 2. Conversion rate by campaign
SELECT campaign_id,
       SUM(conversions) AS total_conversions,
       SUM(clicks) AS total_clicks,
       ROUND( (SUM(conversions)*1.0 / NULLIF(SUM(clicks),0)) * 100, 3) AS conversion_rate_percent
FROM marketing
GROUP BY campaign_id
ORDER BY conversion_rate_percent DESC;

-- 3. CPA (Cost per Acquisition) by campaign
SELECT campaign_id,
       SUM(cost) AS total_cost,
       SUM(conversions) AS total_conversions,
       ROUND( (SUM(cost)*1.0 / NULLIF(SUM(conversions),0)), 2) AS cpa
FROM marketing
GROUP BY campaign_id
ORDER BY cpa ASC;

-- 4. ROI by campaign (simple) = (revenue - cost) / cost
SELECT campaign_id,
       SUM(revenue) AS revenue,
       SUM(cost) AS cost,
       ROUND( (SUM(revenue) - SUM(cost)) * 1.0 / NULLIF(SUM(cost),0), 3) AS roi
FROM marketing
GROUP BY campaign_id
ORDER BY roi DESC;

-- 5. Weekly cohort: users by signup week and week offset (example outline)
-- Implementation depends on SQL dialect; consider using date_trunc or strftime / julianday in SQLite.