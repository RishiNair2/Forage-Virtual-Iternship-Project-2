--- All database queries relating to the reaction_types dataset---
SELECT *
FROM reaction_types

-- Average reaction score for each reaction type--
SELECT type, ROUND(AVG(reaction_score)) avg_reaction_score
FROM reaction_types
GROUP BY type
ORDER BY avg_reaction_score DESC

SELECT type, AVG(reaction_score) OVER (PARTITION BY type) avg_reaction_score
FROM reaction_types
ORDER BY avg_reaction_score DESC

--- Sentiment with the highest reaction score ---
SELECT sentiment, AVG(reaction_score) avg_reaction_score
FROM reaction_types
GROUP BY sentiment
ORDER BY avg_reaction_score DESC

--- How many people expressed a positive, neutral, or negative sentiment ---
SELECT sentiment, COUNT(sentiment) num_people
FROM reaction_types
GROUP BY sentiment
ORDER BY num_people DESC






