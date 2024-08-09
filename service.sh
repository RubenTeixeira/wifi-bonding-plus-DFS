#!/system/bin/sh
sleep 30
MODDIR=${0%/*}
cat /system/etc/firmware/wlan/prima/WCNSS_qcom_cfg.ini &>/dev/null
cat "$MODDIR/system/etc/firmware/wlan/prima/WCNSS_qcom_cfg.ini" &>/dev/null
sleep 120
svc wifi disable
sleep 6
svc wifi enable
