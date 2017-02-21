#!/bin/bash

DB="launches.db"

rm $DB
sqlite3 $DB < import_query.sql
