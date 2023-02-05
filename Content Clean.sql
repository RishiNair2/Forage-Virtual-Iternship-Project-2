--- Cleaning Queries Of The Content, Reactions, and Reaction Types Table---
--- Cleaning Queries Of The Content Table ---
SELECT *
FROM content_raw

--- Drop the columns URL and User Id----
ALTER TABLE content_raw DROP COLUMN url;
ALTER TABLE content_raw DROP COLUMN user_id;

--Check if there are duplicate values---
SELECT content_id, content_type, category_type, COUNT(*) count
FROM content_raw
GROUP BY content_id, content_type, category_type
HAVING COUNT(*) > 1

--- Check if the columns have any null value ---
SELECT *
FROM content_raw
WHERE content_type IS NULL;

SELECT *
FROM content_raw
WHERE category_type IS NULL;

SELECT *
FROM content_raw
WHERE content_id IS NULL;

--- Change duplicate values into a singular value---
SELECT category_type, COUNT(content_id)
FROM content_raw
GROUP BY category_type;

UPDATE content_raw
SET category_type = 'Culture'
WHERE category_type = 'culture';

UPDATE content_raw
SET category_type = 'Animals'
WHERE category_type = 'animals' 

UPDATE content_raw
SET category_type = 'Cooking'
WHERE category_type = 'cooking'

UPDATE content_raw
SET category_type = 'Dogs'
WHERE category_type = 'dogs'

UPDATE content_raw
SET category_type = 'Education'
WHERE category_type = 'education'

UPDATE content_raw
SET category_type = 'Fitness'
WHERE category_type = 'fitness'

UPDATE content_raw
SET category_type = 'Food'
WHERE category_type = 'food'

UPDATE content_raw
SET category_type = 'Healthy Eating'
WHERE category_type = 'healthy eating'

UPDATE content_raw
SET category_type = 'Public Speaking'
WHERE category_type = 'public speaking'

UPDATE content_raw
SET category_type = 'Science'
WHERE category_type = 'science'

UPDATE content_raw
SET category_type = 'Soccer'
WHERE category_type = 'soccer'

UPDATE content_raw
SET category_type = 'Studying'
WHERE category_type = 'studying'

UPDATE content_raw
SET category_type = 'Technology'
WHERE category_type = 'technology'

UPDATE content_raw
SET category_type = 'Tennis'
WHERE category_type = 'tennis'

UPDATE content_raw
SET category_type = 'Travel'
WHERE category_type = 'travel'

UPDATE content_raw
SET category_type = 'Veganism'
WHERE category_type = 'veganism'
