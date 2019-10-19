#!/bin/bash
# Place in /config/scripts/post-config.d/

WRAPPER="/opt/vyatta/sbin/vyatta-cfg-cmd-wrapper"
$WRAPPER begin
$WRAPPER set load-balance group wan_failover transition-script /config/scripts/wan-load-balance-hack.sh
$WRAPPER commit 
$WRAPPER end
