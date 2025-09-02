-- highest_donation_assignments
SELECT a.assignment_name,
    a.region,
    ROUND(SUM(d.amount), 2) AS rounded_total_donation_amount,
    donors.donor_type
FROM donations AS d
JOIN assignments AS a
ON a.assignment_id = d.assignment_id
JOIN donors
ON donors.donor_id = d.donor_id
GROUP BY a.assignment_name, a.region, donors.donor_type
ORDER BY rounded_total_donation_amount DESC
LIMIT 5;