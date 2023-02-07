--- Creating a temp table called customer data from some columns of the 3 datasets---
CREATE TEMPORARY TABLE customer_content(
content_id text,
reaction_type text,
reaction_date_time timestamp without time zone,
content_type text,
content_category text,
customer_sentiment text,
reaction_score integer)

insert into customer_content
SELECT t.content_id, r.reaction_type, r.reaction_date_time,
t.content_type, t.category,
w.sentiment, w.reaction_score
FROM content t
LEFT JOIN reactions r
ON t.content_id = r.content_id
LEFT JOIN reaction_types w
ON r.reaction_type = w.type;

--- Make sure all of our data was inserted properly---
SELECT *
FROM customer_content;

--- Top 5 Categories based on popularity score (reaction score)---
SELECT content_category, SUM(reaction_score) total_reaction_score
FROM customer_content
GROUP BY content_category
ORDER BY total_reaction_score DESC
LIMIT 5;

--- Popularity Percentage Share Based ON Top 5 Categories--- 
SELECT content_category, SUM(reaction_score) *100/(SELECT SUM(t1.total_score)
													FROM (
													SELECT content_category, SUM(reaction_score) total_score
													FROM customer_content
													GROUP BY content_category
													ORDER BY SUM(reaction_score) DESC
													LIMIT 5) t1) percent_of_total
FROM customer_content
GROUP BY content_category
ORDER BY percent_of_total DESC
LIMIT 5;

--- Number of unique content categories---
SELECT COUNT(DISTINCT content_category) unique_categories
FROM customer_content
GROUP BY content_category;

--- Number of reactions to animal posts--
SELECT content_category, COUNT(reaction_type) reaction_count
FROM customer_content
WHERE content_category = 'animals'
GROUP BY content_category;

--- Month with the most posts---
SELECT EXTRACT('month' FROM reaction_date_time) post_month, COUNT(content_id) num_posts
FROM customer_content
GROUP BY post_month
ORDER BY num_posts DESC
LIMIT 1;

--- In addition to month with the most posts, what was the common category posted
-- in the month of January---
SELECT content_category, COUNT(content_category) content_count
FROM customer_content
WHERE EXTRACT('month' FROM reaction_date_time) = 01
GROUP BY content_category
ORDER BY content_count DESC;


--- Determining if there are more positive or negative pieces of content---
SELECT customer_sentiment, COUNT(content_id) num_content
FROM customer_content
WHERE customer_sentiment IS NOT NULL
GROUP BY customer_sentiment
ORDER BY num_content DESC;

--- The customer sentiment for each type of category---
SELECT content_category, COUNT(CASE WHEN customer_sentiment = 'positive' THEN 1 END) AS positive_count,
COUNT(CASE WHEN customer_sentiment = 'negative' THEN 1 END) AS negative_count,
COUNT(CASE WHEN customer_sentiment = 'neutral' THEN 1  END) AS indifferent_count
FROM customer_content
GROUP BY content_category;

--- Using customer sentiment to determine which types of content customers would prefer--
SELECT content_type, COUNT(CASE WHEN customer_sentiment = 'positive' THEN 1 END) AS positive_count
FROM customer_content
GROUP BY content_type
ORDER BY positive_count DESC;

-- Which categories were popular in 2021 and 2020 ---
SELECT content_category, COUNT(content_category) content_count
FROM customer_content
WHERE EXTRACT('year' FROM reaction_date_time) = '2021'
GROUP BY content_category
ORDER BY content_count DESC;

SELECT content_category, COUNT(content_category) content_count
FROM customer_content
WHERE EXTRACT('year' FROM reaction_date_time) = '2020'
GROUP BY content_category
ORDER BY content_count DESC;