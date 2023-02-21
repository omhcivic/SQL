-- Ad Hoc analysis to find GSEARCH volume trends for online sales for MavenFuzzyFactory



SELECT
    MIN(DATE(created_at)) AS week_start_date,
    COUNT(DISTINCT website_session_id) AS sessions
FROM website_sessions
WHERE created_at < '2012-05-10'
AND utm_source = 'gsearch'
AND utm_campaign = 'nonbrand'
GROUP BY YEARWEEK(created_at);

-- Ad Hoc analysis to determine conversion rates from session to order by device type

SELECT 
	website_sessions.device_type,
    COUNT(DISTINCT website_sessions.website_session_id) AS sessions,
    COUNT(DISTINCT orders.order_id) AS orders,
    COUNT(DISTINCT orders.order_id)/COUNT(DISTINCT website_sessions.website_session_id) AS sessions_to_orders_conv_rt
FROM website_sessions
LEFT JOIN orders
ON orders.website_session_id=website_sessions.website_session_id
WHERE website_sessions.created_at < '2012-05-11'
AND website_sessions.utm_source = 'gsearch'
AND website_sessions.utm_campaign = 'nonbrand'
GROUP BY website_sessions.device_type;


-- The previous analysis shows desktop campaigns are doing well. Paid campaigns are directed towards desktop campaigns. Time to track weekly trends for both desktop and mobile to see impact on sales.

SELECT 
	 MIN(DATE(created_at)) AS week_start_date,
     COUNT(CASE WHEN device_type = 'desktop' THEN website_session_id  ELSE NULL END) AS dtop_sessions,
	 COUNT(CASE WHEN device_type = 'mobile' THEN website_session_id ELSE NULL END) AS mob_sessions
FROM website_sessions
WHERE created_at <  '2012-06-09'
	AND created_at > '2012-04-15'
    AND utm_source = 'gsearch'
    AND utm_campaign = 'nonbrand'
GROUP BY YEARWEEK(created_at)
;