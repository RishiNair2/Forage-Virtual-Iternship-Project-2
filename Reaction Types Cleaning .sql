--- Cleaning Queries Of The Content, Reactions, and Reaction Types Table---
--- Cleaning Queries Of The Reaction Types Table ---
SELECT *
FROM reaction_types_raw;


--Check if there are duplicate values---
SELECT sentiment, reaction_type, reaction_type_score, COUNT(*) count
FROM reaction_types_raw
GROUP BY sentiment, reaction_type, reaction_type_score
HAVING COUNT(*) > 1;

--- Check if the columns have any null value ---
SELECT *
FROM reaction_types_raw
WHERE reaction_type IS NULL;

SELECT *
FROM reaction_types_raw
WHERE sentiment IS NULL;

SELECT *
FROM reaction_types_raw
WHERE reaction_type_score IS NULL;