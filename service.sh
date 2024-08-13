MODDIR=${0%/*}
( sleep 300 ; { cat /system/etc/firmware/wlan/prima/WCNSS_qcom_cfg.ini &>/dev/null ; cat "$MODDIR/system/etc/firmware/wlan/prima/WCNSS_qcom_cfg.ini" &>/dev/null ; } ; svc wifi disable && svc wifi enable ) &
