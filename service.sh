MODDIR=${0%/*}
until [[ "$(getprop sys.boot_completed)" == "1" ]]; do
  /system/bin/sleep 1
done
rm "$MODDIR/working"
/system/bin/cat /system/etc/firmware/wlan/prima/WCNSS_qcom_cfg.ini &>/dev/null
/system/bin/cat "$MODDIR/system/etc/firmware/wlan/prima/WCNSS_qcom_cfg.ini" &>/dev/null
/system/bin/svc wifi disable
/system/bin/sleep 1
/system/bin/svc wifi enable
echo "Yes!" > "$MODDIR/working"
