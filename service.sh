#!/system/bin/sh
sleep 120
MODDIR=${0%/*}
cat /system/etc/firmware/wlan/prima/WCNSS_qcom_cfg.ini &>/dev/null
cat "$MODDIR/system/etc/firmware/wlan/prima/WCNSS_qcom_cfg.ini" &>/dev/null
( ifconfig wlan0 down && sleep 1 && ifconfig wlan0 up ) &
