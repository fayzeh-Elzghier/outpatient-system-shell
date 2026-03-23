#!/bin/bash
patient_file="/home/ubfayzeh/outpatient_system/data/patients.txt"
echo "....................."
echo "Register new patient "
echo "....................."
echo  "Enter name :"
read name
echo "Enter phone number :"
read   phone_number
#if [ "$phone_number" -eq  [0-9]\{10\} ];
if [ ${#phone_number} -eq 10  ];
then
   if echo "$phone_number" | grep -q '^[0-9]\{10\}$' ;
   then    
     echo "valid phone "
   else 
     echo "invalid [contains non digit characters] "
     exit 1
 fi
else 
 echo ":( invalid phone number"
 exit 1 
 
fi
if [ -e "$patient_file" ]
then 
   if [ ! -s "$patient_file" ]
   then
     new_id="p001"
   else
     last_id=$(tail -n 1 "$patient_file"| cut -d'|' -f1 | sed 's/p//')
     new_id1=$(($last_id + 1))
     new_id=$(printf "p%03d" "$new_id1")
     
    fi     
else 
 echo "the file is not exist "
 exit 2
fi
echo "$new_id|$name|$phone_number" >> "$patient_file"
echo "Register new patient done successfullly :) and new patient id is : $new_id "
