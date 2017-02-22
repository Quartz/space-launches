.headers on
.mode csv

.output results/total_by_year.csv

SELECT
    year,
    COUNT(*) AS launch_count
FROM launches
WHERE launch_type = 'O'
GROUP BY year
ORDER BY year;

.output results/failures_by_year.csv

SELECT
    year,
    COUNT(CASE WHEN launch_status = 'S' THEN tag END) AS successful_launches,
    COUNT(CASE WHEN launch_status = 'F' THEN tag END) AS failed_launches
FROM launches
GROUP BY year
ORDER BY year;

.output results/orbital_failures_by_year.csv

SELECT
    year,
    COUNT(CASE WHEN launch_status = 'S' THEN tag END) AS successful_launches,
    COUNT(CASE WHEN launch_status = 'F' THEN tag END) AS failed_launches
FROM launches
WHERE launch_type = 'O'
GROUP BY year
ORDER BY year;

.output results/commercial_by_year.csv

SELECT
    year,
    COUNT(CASE WHEN class = 'B' THEN tag END) AS commercial_launches,
    COUNT(CASE WHEN class != 'B' THEN tag END) AS non_commercial_launches
FROM
    launches,
    orgs
WHERE launches.agency = orgs.code
GROUP BY year
ORDER BY year;

.output stdout
