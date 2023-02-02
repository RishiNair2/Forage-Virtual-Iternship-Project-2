--- All queries for the content database ---
SELECT *
FROM content

-- Number of content produced for each content type ---
SELECT content_type, COUNT(content_id) num_content
FROM content
GROUP BY content_type
ORDER BY num_content DESC

--- Number of content produced for each category type---
SELECT category, COUNT(content_id) num_content
FROM content
GROUP BY category
ORDER BY num_content DESC

--- Top 5 Categories based on number of content produced---
SELECT category, COUNT(content_id) num_content
FROM content
GROUP BY category
ORDER BY num_content DESC
LIMIT 5

