MODDIR=${0%/*}
until [[ "$(getprop sys.boot_completed)" == "1" ]]; do
  sleep 1
done
cat /system/etc/firmware/wlan/prima/WCNSS_qcom_cfg.ini &>/dev/null
cat "$MODDIR/system/etc/firmware/wlan/prima/WCNSS_qcom_cfg.ini" &>/dev/null
svc wifi disable
sleep 2
svc wifi enable
touch "$MODDIR/working"
