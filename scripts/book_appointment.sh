#!/bin/bash
doctor_file="/home/ubfayzeh/outpatient_system/data/doctors.txt"
patient_file="/home/ubfayzeh/outpatient_system/data/patients.txt"
appointment_file="/home/ubfayzeh/outpatient_system/data/appointments.txt"
echo ".........................."
echo "Book new appointment "
echo "..........................."
echo "Enter the patient IDs :"
read patient_id 
if  ! grep -q "^$patient_id|" "$patient_file" ;
then 
 echo "The id you entered is not exist "
 exit 1
fi
echo "Enter specialty u want: "
read specialty
echo "List of avalible doctors in thes spcialty :"
specialty_line=$(grep "|$specialty|" "$doctor_file")

if [ -z  "$specialty_line" ];
then 
   echo "there is no specialty like this "
   exit 1
fi
grep "|$specialty|" "$doctor_file" 
echo "enter the doctor IDs: "
read doctor_id 
doctor_line=$(grep "^$doctor_id|" "$doctor_file")
if [ -z "$doctor_line" ];
then 
  echo "this doctor is not exist"
  exit 1
fi
available_days=$(echo "$doctor_line" | cut -d'|' -f4)
start_time=$(echo "$doctor_line" | cut -d'|' -f5)
end_time=$(echo "$doctor_line" | cut -d'|'  -f6)
echo "enter  the dateif this form (YYYY-MM-DD) :"
read date 
if  ! echo "$date" | grep -E  '^[0-9]{4}-(0[1-9]|1[0-2])-([0-2][1-9]|3[0-1])$' > /dev/null ;
then 
  echo "wrong expression !"
  exit 1
fi
year=$(echo "$date" | cut -d'-' -f1)
month=$(echo "$date" | cut -d'-' -f2)
day=$(echo "$date" | cut -d'-' -f3)
case $month in 
04|06|09|11)
   if [ "$day" -gt 30 ];
   then 
     echo "this month have only 30 days !"
     exit 1
   fi
   ;;
02) if (( ($year % 4 == 0 && $year % 100 != 0) || ($year % 400 == 0) ))
    then 
     max_day=29
    else 
     max_day=28
    fi
    if [ "$day" -gt "$max_day" ];
    then
      echo "February month have only "$max_day" "
      exit 2 
    fi 
    ;;
esac 
echo "Enter day  (Sun, Mon, Tue, Wed, Thu, Fri, Sat): "
read day_week
if ! echo "$available_days" | grep -q "$day_week" > /dev/null ;
then 
  echo "the doctor is not avalible is this day "$day_week" "
  exit 2
fi
echo "Enter time as (HH:MM) :"
read time1
if ! echo "$time1" | grep -E '^([0-1][0-9]|2[0-3]):[0-5][0-9]$' > /dev/null ;
then 
   echo "wrong expression !"
   exit 2 
fi
time1_num=$(echo "$time1" | sed 's/://')
start_num=$(echo "$start_time" | sed 's/://')
end_num=$(echo "$end_time" | sed 's/://')
if [[ "$time1" < "$start_time"  ||  "$time1" > "$end_time" ]];
then 
  echo "Time outside the doctor's working hours ($start_time - $end_time)"
  exit 1
fi
if (grep -q "|$doctor_id|$date|$time1|" "$appointment_file"  )
then 
  
     echo "this appointment is booked in advance "
     exit 1
 
fi
if [ ! -s "$appointment_file" ];
then 
  new_idA="A001"
else 
  last_idA=$(tail -n 1 "$appointment_file" | cut -d'|' -f1 | sed 's/A//')
  new_idA1=$(($last_idA + 1))
  new_idA=$(printf "A%03d" "$new_idA1")
fi
echo "$new_idA|$patient_id|$doctor_id|$date|$time1|Confirmed" >> "$appointment_file"
echo "Ur appointment booked is done sucessfully with appointment ID "$new_idA" "
