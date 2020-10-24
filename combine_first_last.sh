#!/bin/bash


UNDERSCORE='_'

for fname in $(cat "Spray-master/name-lists/english-first-1000.txt")
do
  for lname in $(cat "Spray-master/name-lists/english-last-1000.txt")
  do
     echo "$fname$UNDERSCORE$lname" >> first_last_list.txt
  done
done
