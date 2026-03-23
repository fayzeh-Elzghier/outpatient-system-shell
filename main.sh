#!/bin/bash
while true; do
echo ".............................................."
echo "welcome to our Output Reservation System :"
echo "you can choose 1 or 2 or 3 :"
echo "1- Patient Services."
echo "2- Doctor and Admin Services"
echo "3-Exit"
read op
case "$op" in
  1) cd scripts
     ./patient_menu.sh;;
  2) cd scripts
     ./admin_menu.sh;;
  3) exit 1 
     exit 1 
     ;;
  *)echo "invalid input :( try again "
   
     ;;
 
 esac
done

