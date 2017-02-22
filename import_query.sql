.mode csv
.import results/launches.csv launches
.import results/orgs.csv orgs

ALTER TABLE launches ADD COLUMN year INTEGER;
ALTER TABLE launches ADD COLUMN launch_type;
ALTER TABLE launches ADD COLUMN launch_status;

UPDATE launches SET year = CAST(SUBSTR(tag, 1, 4) AS INTEGER);
UPDATE launches SET launch_type = SUBSTR(launch_code, 1, 1);
UPDATE launches SET launch_status = SUBSTR(launch_code, 2, 1);

CREATE UNIQUE INDEX launch_tag_index ON launches(tag);
CREATE UNIQUE INDEX org_code ON orgs(code);
