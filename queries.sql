.headers on
.mode csv

.output results/count_by_year.csv

SELECT year, count(*) as launch_count FROM launches WHERE launch_type = "O" GROUP BY year ORDER BY year;

.output stdout
