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
ui_print "- Starting modify"
sed -i '/gChannelBondingMode24GHz=/d;/gChannelBondingMode5GHz=/d;/g11dSupportEnabled=/d;/gForce1x1Exception=/d;/sae_enabled=/d;/BandCapability=/d;/WmmIsEnabled=/d;/gEnableDFSChnlScan=/d;/gAllowDFSChannelRoam=/d;/g11hSupportEnabled=/d;/gEnableDFSMasterCap=/d;/gInitialScanNoDFSChnl=/d;/gEnableBypass11d=/d; /gSkipDfsChannelInP2pSearch=/d;/isP2pDeviceAddrAdministrated=/d;s/^END$/gChannelBondingMode24GHz=1\ngChannelBondingMode5GHz=1\ng11dSupportEnabled=0\ngForce1x1Exception=0\nsae_enabled=1\nBandCapability=0\nWmmIsEnabled=1\ngEnableDFSChnlScan=1\ngAllowDFSChannelRoam=1\ng11hSupportEnabled=1\ngEnableDFSMasterCap=1\ngInitialScanNoDFSChnl=0\ngEnableBypass11d=1\ngSkipDfsChannelInP2pSearch=0\nisP2pDeviceAddrAdministrated=0\nEND/g' $MODPATH$CFG
}
done
[[ -z $CFG ]] && abort "- Installation FAILED. Your device didn't support WCNSS_qcom_cfg.ini." || { mkdir -p $MODPATH/system; mv -f $MODPATH/vendor $MODPATH/system/vendor; mv -f $MODPATH/product $MODPATH/system/product; mv -f $MODPATH/system_ext $MODPATH/system/system_ext;}
