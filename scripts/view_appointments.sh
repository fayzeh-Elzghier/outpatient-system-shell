#!/bin/bash
appointment_file="/home/ubfayzeh/outpatient_system/data/appointments.txt"
doctor_file="/home/ubfayzeh/outpatient_system/data/doctors.txt"
echo "............................."
echo "view my  appointment "
echo "............................"
echo "Enter the patient ID's "
read patient_id
if ! grep -q "^.*|$patient_id|" "$appointment_file" 
then 
   echo "there is no appointments for that patient with this ID "
   exit 1
fi
echo "list of ur appointments :"
echo ".........................."
for line in $(grep "|$patient_id|" "$appointment_file");do
 appointment_id=$(echo "$line"  | cut -d'|' -f1) 
 doctor_id=$(echo "$line" | cut -d'|' -f3)
 date=$(echo "$line" | cut -d'|' -f4)
 time1=$(echo "$line" | cut -d'|' -f5)
 statuse=$(echo "$line" | cut -d'|' -f6)
 doctor_name=$(grep "^$doctor_id|" "$doctor_file" | cut -d'|' -f2)
 echo "The appointment id : "$appointment_id" "
 echo "with : "$doctor_name" "
 echo "Date : "$date""
 echo "At time :"$time1""
 echo "Status : "$statuse""
 echo "........................................"
done 
