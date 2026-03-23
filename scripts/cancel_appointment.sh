#!/bin/bash
appointment_file="/home/ubfayzeh/outpatient_system/data/appointments.txt"
temp_file="/home/ubfayzeh/outpatient_system/data/temp_appointments.txt"
echo "..........................."
echo "Cancel Appointment "
echo ".........................."
echo "Enter patient ID :"
read patient_id
matches=$(grep "|$patient_id" "$appointment_file")
if [ -z "$matches" ];
then
 echo "there is no appointments found for this patients ID"
 exit 1
fi
echo "----------------------------"
echo "Ur appointments:"
echo ".........................."
for line in $(grep "|$patient_id|" "$appointment_file");do
 appointment_id=$(echo "$line"  | cut -d'|' -f1) 
 date=$(echo "$line" | cut -d'|' -f4)
 time1=$(echo "$line" | cut -d'|' -f5)
 statuse=$(echo "$line" | cut -d'|' -f6)
 echo "The appointment id : "$appointment_id" Date : "$date"At time :"$time1" Status : "$statuse""
 echo "........................................"
done 
echo "Enter appointment ID u want to cancel  (e.g. A002) "
read appo_id
if ! grep -q "^$appo_id|$patient_id|" "$appointment_file" > /dev/null ;
then
  echo "this appointment not found or dose not belong to u @.@ "
  exit 1 
fi
> "$temp_file"
for line in $(grep "|" "$appointment_file"); do
 current_id=$(echo "$line" | cut -d'|' -f1)
 current_patientid=$(echo "$line" | cut -d'|' -f2)
 if [[ "$current_id" == "$appo_id" && "$current_patientid" == "$patient_id" ]];
 then 
  part1=$(echo "$line" | cut -d'|' -f1-5)
  echo "$part1|Cancelled" >> "$temp_file"
 else 
  echo "$line" >> "$temp_file"
 fi
done  
mv "$temp_file" "$appointment_file"
echo "Appointment has been cancelled sucessfully :)"

