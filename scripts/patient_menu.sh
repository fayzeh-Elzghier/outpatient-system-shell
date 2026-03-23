#!/bin/bash
while true; do 
 echo "................................."
 echo "patient list:"
 echo "1. register patient."
 echo "2. book appointment."
 echo "3. view appointment."
 echo "4. cancel appointment."
 echo "5. go back to the main. "
 read op 
 case "$op" in 
   1) ./register_patient.sh
       ;;
   2) ./book_appointment.sh;;
   3) ./view_appointments.sh;;
   4) ./cancel_appointment.sh;;
   5)  ../main.sh 
       exit 1
        ;;
   *) echo "invalid input try again :( ";;
 esac
done
