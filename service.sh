#!/system/bin/sh
sleep 30
MODDIR=${0%/*}
cat /system/etc/firmware/wlan/prima/WCNSS_qcom_cfg.ini &>/dev/null
cat "$MODDIR/system/etc/firmware/wlan/prima/WCNSS_qcom_cfg.ini" &>/dev/null
svc wifi disable
sleep 2
svc wifi enable
