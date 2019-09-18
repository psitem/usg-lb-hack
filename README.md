# Hack to reset UniFi Security Gateway WAN2 interface when failing back to WAN1

**Problem:** When using a USG with failover load-balancing, when failing back to WAN1, sometimes traffic will continue to exit WAN2. Site-to-site VPNs may also fail to re-establish even after manually restarting the VPN service.

**Solution:** Temporarily disabling WAN2 after failing back to WAN1 will reset whatever condition(s) cause this.

**Instructions:** On the USG, place \*.sh files in /config/scripts/ and `chmod +x /config/scripts/*.sh`

On the UniFi Controller, add snipet from `config.gateway.json` to your site. Note that the modification to `transition-script` from `config.gateway.json` appears to be overridden by Ubiquiti's configuration, hence also adding a `task-scheduler` item to run the script.
