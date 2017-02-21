#!/bin/bash

echo "Orgs"
in2csv -e utf-8 -f fixed -s schemas/org_schema.csv lookups/orgs.txt > results/orgs.csv
