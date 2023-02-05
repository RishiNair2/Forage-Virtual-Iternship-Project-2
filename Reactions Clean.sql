--- Cleaning Queries Of The Content, Reactions, and Reaction Types Table---
--- Cleaning Queries Of The Reactions Table ---
SELECT *
FROM reactions_raw;

------ Drop the column user_id---
ALTER TABLE reactions_raw DROP COLUMN user_id;

--Check if there are duplicate values---
SELECT content_id, reaction_type, reaction_date_time, COUNT(*) count
FROM reactions_raw
GROUP BY content_id, reaction_type, reaction_date_time
HAVING COUNT(*) > 1;

--- Check if the columns have any null value ---
SELECT *
FROM reactions_raw
WHERE reaction_type IS NULL;

SELECT *
FROM reactions_raw
WHERE reaction_date_time IS NULL;

--- Drop all null values ---
DELETE FROM reactions_raw WHERE reaction_type IS NULL;