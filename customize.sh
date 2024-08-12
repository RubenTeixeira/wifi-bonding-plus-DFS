[ -x `which magisk` ] && {
if magisk --denylist ls &>/dev/null; then
CMDPREFIX="magisk --denylist exec"
elif magisk magiskhide ls &>/dev/null; then
CMDPREFIX="magisk magiskhide exec"
fi
} || unset CMDPREFIX
CHECK_DIRS="/system /vendor /product /system_ext"
EXISTING_DIRS=""
for dir in $CHECK_DIRS; do
[[ -d "$dir" ]] && EXISTING_DIRS="$EXISTING_DIRS $dir"
done
CFGS=$($CMDPREFIX find $EXISTING_DIRS -type f -name WCNSS_qcom_cfg.ini)
for CFG in $CFGS
do
[[ -f $CFG ]] && {
mkdir -p `dirname $MODPATH$CFG`
ui_print "- Migrating $CFG"
$CMDPREFIX cp -af $CFG $MODPATH$CFG
ui_print "- Starting modifiy"
sed -i '/gChannelBondingMode24GHz=/d;/g11dSupportEnabled=/d;/gChannelBondingMode5GHz=/d;/gForce1x1Exception=/d;/sae_enabled=/d;/BandCapability=/d;/gEnablefwlog=/d;/gEnablePacketLog=/d;/gEnableNUDTracking=/d;/gEnableLogp=/d;/gFwDebugLogLevel=/d;/gFwDebugModuleLoglevel=/d;s/^END$/gChannelBondingMode24GHz=1\ngChannelBondingMode5GHz=1\ngForce1x1Exception=0\nsae_enabled=1\nBandCapability=0\nWmmIsEnabled=1\ngEnableDFSChnlScan=1\ngAllowDFSChannelRoam=2\ng11hSupportEnabled=1\ngEnableDFSMasterCap=1\ngInitialScanNoDFSChnl=0\ng11dSupportEnabled=0\ngEnableBypass11d=1\ngEnablefwlog=0\ngEnablePacketLog=0\ngEnableNUDTracking=0\ngEnableLogp=0\ngFwDebugLogLevel=0\ngFwDebugModuleLoglevel=0\nEND/g' $MODPATH$CFG
}
done
[[ -z $CFG ]] && abort "- Installation FAILED. Your device didn't support WCNSS_qcom_cfg.ini." || { mkdir -p $MODPATH/system; mv -f $MODPATH/vendor $MODPATH/system/vendor; mv -f $MODPATH/product $MODPATH/system/product; mv -f $MODPATH/system_ext $MODPATH/system/system_ext; set_perm_recursive $MODPATH 0 0 0755 0644}
