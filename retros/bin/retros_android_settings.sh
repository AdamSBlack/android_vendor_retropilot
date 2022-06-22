#!/usr/bin/bash
echo "Launching settings and observing status"

echo "firing settings/wifi intent"
am start -n com.android.settings/.wifi.WifiPickerActivity -a android.net.wifi.PICK_WIFI_NETWORK --activity-single-top --ez extra_prefs_show_button_bar true --es extra_prefs_set_next_text '' 

echo "monitoring current window"
while true
do
   sleep 0.5
   
   if ! dumpsys SurfaceFlinger --list | grep -F 'com.android.settings.wifi.WifiPickerActivity'; then
   	echo "Wifi settings closed"
   	break
   fi
done

echo "disabling android settings app"
pm disable com.android.settings
pm enable com.android.settings
