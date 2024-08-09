#!/system/bin/sh
MODDIR=${0%/*}
( sleep 30 && cat /system/etc/firmware/wlan/prima/WCNSS_qcom_cfg.ini &>/dev/null && cat "$MODDIR/system/etc/firmware/wlan/prima/WCNSS_qcom_cfg.ini" &>/dev/null ) &
( sleep 120 && svc wifi disable && svc wifi enable ) &
