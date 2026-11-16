-- 1. Cache hit ratio: how often the edge served from cache
SELECT x_edge_result_type, COUNT(*) AS requests
FROM cloudfront_logs
GROUP BY x_edge_result_type
ORDER BY requests DESC;

-- 2. Errors and what was requested (scanners show up here)
SELECT sc_status, cs_uri_stem, COUNT(*) AS requests
FROM cloudfront_logs
WHERE sc_status >= 400
GROUP BY sc_status, cs_uri_stem
ORDER BY requests DESC
LIMIT 20;

-- 3. Which edge locations serve your visitors
SELECT x_edge_location, COUNT(*) AS requests
FROM cloudfront_logs
GROUP BY x_edge_location
ORDER BY requests DESC;

-- 4. Most requested files and average time to serve them
SELECT cs_uri_stem, COUNT(*) AS requests, ROUND(AVG(time_taken), 4) AS avg_seconds
FROM cloudfront_logs
GROUP BY cs_uri_stem
ORDER BY requests DESC
LIMIT 10;

-- 5. Requests per day
SELECT "date", COUNT(*) AS requests
FROM cloudfront_logs
GROUP BY "date"
ORDER BY "date";
