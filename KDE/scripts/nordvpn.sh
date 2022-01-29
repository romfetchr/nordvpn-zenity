#!/bin/bash
#
# nordvpn.sh - BASIC NordVPN GUI (Zenity)
#
# IF YOU WANT TO KEEP THE GUI ON:
# - LEAVE the *parent* Terminal Window OPEN until you log out
# with any luck it should just be your ORIGINAL Terminal opened in the folder with the file
#
# Work in this order:
#    Status (Check) - LogIn - Connect - KillSwith ON - KillSwitch OFF -DISconnect - LogOut
#  Added Kill Switch Buttons because sometimes the computer had to be rebooted to reset it.
# (this NordVPN Zenity is modified from something I saw running a PiBot)


#### ADJUST ACCORDING TO YOUR NEEDS! ###
PATHNORD=/usr/bin/nordvpn #Path to nordvpn client binary file
DNS1=103.86.96.100 #Custom DNS server #1
DNS2=103.86.99.100 #Custom DNS server #1

## NO NEED TO CHANGE BELOW THIS LINE ###
#echo -ne '\033]0;DO NOT CLOSE ME - NordVPN Backend\007' #Works with konsole?!

rc=1 # OK button return code =0 , all others =1

while [ $rc -eq 1 ]; do
  ans=$(zenity --info --title 'NordVPN' \
  --ok-label Quit \
  --extra-button Status \
  --extra-button LOGIN \
  --extra-button DNS \
  --extra-button CHECK \
  --extra-button Connect \
  --extra-button Kill-Sw-ON \
  --extra-button Kill-Sw-OFF \
  --extra-button DISconnect \
  --extra-button LogOUT \
  --extra-button Spare \
  )
  rc=$?
  echo "${rc}-${ans}"
  echo $ans
  if [[ $ans = "Status" ]]
  then
    konsole --noclose -e "$PATHNORD status;"
  elif [[ $ans = "LOGIN" ]]
  then
    konsole --noclose -e "$PATHNORD login %U;"
  elif [[ $ans = "DNS" ]]
  then
    konsole --noclose -e "$PATHNORD set dns $DNS1 $DNS2;"
  elif [[ $ans = "Connect" ]]
  then
    konsole --noclose -e "$PATHNORD connect;"
  elif [[ $ans = "CHECK" ]]
  then
    konsole --noclose -e "$PATHNORD settings %U;"
  elif [[ $ans = "Kill-Sw-ON" ]]
  then
    konsole --noclose -e "$PATHNORD set killswitch on;"
  elif [[ $ans = "Kill-Sw-OFF" ]]
  then
    konsole --noclose -e "$PATHNORD set killswitch off;"
  elif [[ $ans = "DISconnect" ]]
  then
    konsole --noclose -e "$PATHNORD disconnect;"
  elif [[ $ans = "LogOUT" ]]
  then
    konsole --noclose -e "$PATHNORD logout;"
  fi
done
