-- top_regional_impact_assignments
WITH c1 AS(
	SELECT 
		assignment_id,
		COUNT(donation_id) AS num_total_donations
	FROM donations
	GROUP BY assignment_id
)
	
,c2 AS(
	SELECT
		a.assignment_name,
		a.region,
		a.impact_score,
		c1.num_total_donations,
		ROW_NUMBER() OVER(PARTITION BY a.region ORDER BY a.impact_score DESC) AS rank_in_region
	FROM assignments AS a
	JOIN c1 ON c1.assignment_id = a.assignment_id
	WHERE c1.num_total_donations  > 0
)

SELECT assignment_name,
	region,
	impact_score,
	num_total_donations
FROM c2
WHERE rank_in_region = 1
ORDER BY region ASC;