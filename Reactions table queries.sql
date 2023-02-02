---All database queries for reactions table ---
SELECT *
FROM reactions

-- Most common reaction types---
SELECT reaction_type, COUNT(content_id) num_content
FROM reactions
GROUP BY reaction_type
ORDER BY num_content DESC

--- Which year was the most contnent posted---
SELECT EXTRACT('year' FROM reaction_date_time) reaction_year, COUNT(content_id) num_content
FROM reactions
GROUP BY reaction_year 
ORDER BY num_content DESC

---Which month was the most contnent posted---
SELECT EXTRACT('month' FROM reaction_date_time) reaction_month, COUNT(content_id) num_content
FROM reactions
GROUP BY reaction_month 
ORDER BY num_content DESC

--- Most common reaction month ---
SELECT reaction_type, ROUND(AVG(t1.reaction_month)) avg_month
FROM(
SELECT reaction_type, EXTRACT('month' FROM reaction_date_time) reaction_month
FROM reactions) t1
GROUP BY reaction_type
ORDER BY avg_month DESC

--- Running total of the number content based on reaction type
SELECT reaction_type, EXTRACT('month' FROM reaction_date_time) reaction_month,
COUNT(content_id) OVER(PARTITION BY reaction_type ORDER BY content_id) reaction_window
FROM reactions


