#!/system/bin/sh
cat /system/etc/firmware/wlan/prima/WCNSS_qcom_cfg.ini &>/dev/null
ifconfig wlan0 down
ifconfig wlan0 up
