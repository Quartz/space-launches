#!/bin/bash

for filename in launches/*; do
      echo $filename
      in2csv -f fixed -s schemas/launch_schema.csv $filename > $filename.csv
done

for filename in launches/*.csv; do
      echo $filename
      sed '2 d' $filename > ${filename%.*}_stripped.csv
done

mkdir clean_launch

for filename in launches/*_stripped.csv; do
      echo $filename
      mv $filename clean_launch/
done

csvstack clean_launch/*.csv > results/launch_database.csv

rm launches/*.csv

rm clean_launch/*.csv

rmdir clean_launch
