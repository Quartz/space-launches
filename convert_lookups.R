# === A script to replace:: === 

# #!/bin/bash
# 
# echo "Orgs"
# in2csv -f fixed -s schemas/org_schema.csv lookups/orgs.txt > results/orgs.csv

library(tidyverse)
setwd('/Users/yzhou/src/space-launches')


schema <- read_csv('schemas/orgs_schema.csv')
read_fwf('lookups/orgs.txt', fwf_widths(schema$length, schema$column)) %>%
  write_csv('results/orgs.csv')

schema_sites <- read_csv('schemas/site_schema.csv')
read_fwf('lookups/sites.txt', fwf_widths(schema_sites$length, schema_sites$column)) %>%
  write_csv('results/sites.csv')


