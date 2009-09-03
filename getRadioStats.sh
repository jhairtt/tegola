#!/bin/sh
# --------------------------------------------------------------------------------------
# getRadioStats
#       Gathers a bunch of madWLANDEV-related stats and makes them available via snmpd.conf
# --------------------------------------------------------------------------------- mino

# To debug script to stdout, set this to one:
DEBUG=0

# Check command line parameter:
if [ $# -ne 1 ]; then
	echo 1>&2 "Usage: ./getRadioStats.sh <interface>"
	echo 1>&2 "For example: './getRadioStats.sh ath0'"
	exit 127
fi
			
# Check that the specified interface exists:
if [ ! -e "/proc/sys/net/$1" ]; then
	echo 1>&2 "Interface '$1' does not exists."
	exit 127
fi

# Finds which physical interface corresponds to this ath:
ATH=$1
WLANDEV=`/bin/cat /proc/sys/net/$ATH/%parent`
			
# Gather data:
FREQUENCY=`/usr/sbin/iwconfig $ATH | /bin/grep Frequency | /usr/bin/cut -d":" -f 3 | /usr/bin/cut -d" " -f 1 | /bin/grep "[-.0-9]"`
RSSI=`/bin/cat /proc/net/wireless | /bin/grep $ATH | /usr/bin/awk '{print substr($3, 0, length($3)-1)}' | /bin/grep "[-.0-9]"`
SNR=`/bin/cat /proc/net/wireless | /bin/grep $ATH | /usr/bin/awk '{print substr($4, 0, length($4)-1)}' | /bin/grep "[-.0-9]"`
NOISE=`/bin/cat /proc/net/wireless | /bin/grep $ATH | /usr/bin/awk '{print substr($5, 0, length($5)-1)}' | /bin/grep "[-.0-9]"`
RXBADCRC=`/usr/sbin/athstats -i $WLANDEV | /usr/bin/awk '/rx failed due to bad CRC/ {print $1}' | /bin/grep "[-.0-9]"`
TXNOACK=`/usr/sbin/athstats -i $WLANDEV | /usr/bin/awk '/tx frames with no ack marked/ {print $1}' | /bin/grep "[-.0-9]"`
TXFAILED=`/usr/sbin/athstats -i $WLANDEV | /usr/bin/awk '/tx failed due to too many retries/ {print $1}' | /bin/grep "[-.0-9]"`
NUMPEERS=`/bin/cat /proc/net/madwifi/$ATH/associated_sta  | /bin/grep "macaddr" | /usr/bin/wc -l | /bin/grep "[-.0-9]"`

# Sanitize input:
if [ -z $FREQUENCY ]; then FREQUENCY=-1; fi
if [ -z $RSSI ]; then RSSI=-1; fi
if [ -z $SNR ]; then SNR=-1; fi 
if [ -z $NOISE ]; then NOISE=-1; fi 
if [ -z $RXBADCRC ]; then RXBADCRC=-1; fi 
if [ -z $TXNOACK ]; then TXNOACK=-1; fi  
if [ -z $TXFAILED ]; then TXFAILED=-1; fi  
if [ -z $NUMPEERS ]; then NUMPEERS=-1; fi

# Print to stdout according to debug mode:
if [ $DEBUG -eq 1 ]; then
	echo "====== DEBUG ======"
	echo "Device parameters:"
	echo "  Ath: $ATH"
	echo "  Wlandev: $WLANDEV"
	echo 
	echo "Layer 1 stats:"
	echo "  Frequency: $FREQUENCY"
	echo "  RSSI: $RSSI"
	echo "  SNR: $SNR"
	echo "  Noise: $NOISE"
	echo 
	echo "Layer 2 stats:"
	echo "  RxBadCrc: $RXBADCRC"
	echo "  TxNoAck: $TXNOACK"
	echo "  TxFailed: $TXFAILED"
	echo "  NumPeers: $NUMPEERS"
	echo 
else
	echo $FREQUENCY $RSSI $SNR $NOISE $RXBADCRC $TXNOACK $TXFAILED $NUMPEERS
fi
