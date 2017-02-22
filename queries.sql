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
    COUNT(*) as total,
    COUNT(CASE WHEN launch_status = 'S' THEN tag END) AS success,
    COUNT(CASE WHEN launch_status = 'F' THEN tag END) AS failure,
    COUNT(CASE WHEN launch_status = 'U' THEN tag END) AS unknown
FROM launches
GROUP BY year
ORDER BY year;

.output results/success_by_year.csv

SELECT
    year,
    COUNT(*) as total,
    COUNT(CASE WHEN launch_status = 'S' THEN tag END) AS success,
    COUNT(CASE WHEN launch_status = 'F' THEN tag END) AS failure,
    COUNT(CASE WHEN launch_status = 'U' THEN tag END) AS unknown
FROM launches
WHERE launch_type = 'O'
GROUP BY year
ORDER BY year;

.output results/class_by_year.csv

SELECT
    year,
    COUNT(*) as total,
    COUNT(CASE WHEN class = 'A' THEN tag END) AS academic,
    COUNT(CASE WHEN class = 'B' THEN tag END) AS business,
    COUNT(CASE WHEN class = 'C' THEN tag END) AS military,
    COUNT(CASE WHEN class = 'D' THEN tag END) AS government
FROM
    launches,
    orgs
WHERE launches.agency = orgs.code
GROUP BY year
ORDER BY year;

.output results/total_by_country_by_year.csv

SELECT
    year,
    COUNT(*) as total,
    COUNT(CASE WHEN state_code = 'US' THEN tag END) AS united_states,
    COUNT(CASE WHEN state_code = 'SU' OR state_code = 'RU' THEN tag END) AS russia,
    COUNT(CASE WHEN state_code = 'CN' THEN tag END) AS china,
    COUNT(CASE WHEN state_code = 'IN' THEN tag END) AS india
FROM
    launches,
    orgs
WHERE launches.agency = orgs.code
GROUP BY year
ORDER BY year;

.output stdout
