#!/bin/bash

# File: wan-event-report.sh
# Desc: Reports WAN transistion events to the controller. This script should be configured under the
#       "load-balance group <GROUP_NAME> transition-script" config node. If the controller reporting
#       script is not found, logs to syslog

GROUP=$1
IFACE=$2
STATE=$3

# Call Ubiquiti's script to report to UniFi Controller
/config/scripts/wan-event-report.sh $1 $2 $3

# Log execution
echo "$(date +'%h %e %T'): GROUP: $GROUP IFACE: $IFACE STATE: $STATE">>/tmp/wlb.log

if [[ "$STATE" == "failover" ]]
then

WRAPPER="/opt/vyatta/sbin/vyatta-cfg-cmd-wrapper"
$WRAPPER begin
$WRAPPER set interfaces ethernet $IFACE disable
$WRAPPER commit 
$WRAPPER end

$WRAPPER begin
$WRAPPER delete interfaces ethernet $IFACE disable
$WRAPPER commit 
$WRAPPER end

fi


