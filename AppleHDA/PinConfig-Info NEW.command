#!/bin/sh

PinConfigurations=$(ioreg -rw 0 -p IODeviceTree -n HDEF | grep PinConfigurations | awk '{ print $3 }' | sed -e 's/.*<//' -e 's/>//' | awk '{for(i=1;i<length;i+=8) print substr($0,i,8)}' )
printf '\n'
#echo $PinConfigurations
#echo
printf '%-8s: %-2s %-10s %-15s %-12s %-8s %-8s %s\n' Pin Gr Device Connector Port Location Color Misc
printf '\n'

for Pin in $PinConfigurations
do

Group=${Pin:0:2}


case ${Pin:4:1} in
"0")
Device="Line Out"
;;
"1")
Device="Speaker"
;;
"2")
Device="HP Out"
;;
"3")
Device="CD"
;;
"4")
Device="SPDIF Out"
;;
"5")
Device="Digital Other Out"
;;
"6")
Device="Modem Line Side"
;;
"7")
Device="Modem Handset Side"
;;
"8")
Device="Line In"
;;
"9")
Device="AUX"
;;
"a")
Device="Mic In"
;;
"b")
Device="Telephony"
;;
"c")
Device="SPDIF In"
;;
"d")
Device="Digital Other In"
;;
"e")
Device="Reserved"
;;
"f")
Device="Other"
;;
"")
Device="N.A."
;;
*)
Device="Other"
;;
esac

case ${Pin:2:1} in
"0")
Color="Unknown"
#printf "\x1b[30m"
;;
"1")
Color="Black"
#printf "\x1b[30m"
;;
"2")
Color="Grey"
#printf "\x1b[90m"
;;
"3")
Color="Blue"
#printf "\x1b[94m"
;;
"4")
Color="Green"
#printf "\x1b[32m"
;;
"5")
Color="Red"
#printf "\x1b[31m"
;;
"6")
Color="Orange"
#printf "\x1b[93m"
;;
"7")
Color="Yellow"
#printf "\x1b[93m"
;;
"8")
Color="Purple"
#printf "\x1b[35m"
;;
"9")
Color="Pink"
#printf "\x1b[95m"
;;
"e")
Color="White"
#printf "\x1b[90m"
;;
"f")
Color="Other"
#printf "\x1b[30m"
;;
*)
Color="Reserved"
#printf "\x1b[30m"
;;
esac

case ${Pin:7:1} in
"0")
Location="N/A"
;;
"1")
Location="Rear"
;;
"2")
Location="Front"
;;
"3")
Location="Left"
;;
"4")
Location="Right"
;;
"5")
Location="Top"
;;
"6")
Location="Bottom"
;;
"7")
Location="Special"
;;
"8")
Location="Special"
;;
"9")
Location="Special"
;;
*)
Location="Reserved"
;;
esac

case ${Pin:5:1} in
"0")
Connector="Unknown"
;;
"1")
Connector="1/8\" "
;;
"2")
Connector="1/4\" "
;;
"3")
Connector="ATAPI internal"
;;
"4")
Connector="RCA"
;;
"5")
Connector="Optical"
;;
"6")
Connector="Other Digital"
;;
"7")
Connector="Other Analog"
;;
"8")
Connector="Multichannel Analog (DIN)"
;;
"9")
Connector="XLR/Professional"
;;
"a")
Connector="RJ-11 (Modem)"
;;
"b")
Connector="Combination"
;;
"f")
Connector="Other"
;;
esac

case ${Pin:6:1} in
"0")
Port="Jack"
;;
"1")
Port="No Conn."
;;
"2")
Port="Fixed Func."
;;
*)
Port="Int.& Jack"
;;
esac
case ${Pin:3:1} in
"0")
Misc="0"
;;
*)
Misc="1"
;;
esac
#echo  "$Pin $Group $Color\t$Misc $Device\t$Connector\t$Port\t$Location"

printf '%8s: %2s %-10s %-15s %-12s %-8s %-8s %s\n' $Pin $Group "$Device"  "$Connector"  "$Port"  "$Location" "$Color" "$Misc"
#printf "\x1b[30m"

done

#echo "Main Output must be Speaker, not Line Out"
#echo "Mic must be Unknown Int.& Jack"
#echo "2nd Mic must be Line In"








