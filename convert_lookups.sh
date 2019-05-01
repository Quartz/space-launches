#!/bin/bash

echo "Orgs"
in2csv -f fixed -s schemas/orgs_schema.csv lookups/orgs.txt > results/orgs.csv
