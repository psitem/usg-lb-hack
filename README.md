# Hack to reset UniFi Security Gateway WAN2 interface when failing back to WAN1

**Problem:** When using a USG with failover load-balancing, when failing back to WAN1, sometimes traffic will continue to exit WAN2. Site-to-site VPNs may also fail to re-establish even after manually restarting the VPN service.

**Solution:** Temporarily disabling WAN2 after failing back to WAN1 will reset whatever condition(s) cause this.

**Instructions:** On the USG, place `postboot.sh` in `/config/scripts/post-config.d` and `wan-load-balance-hack.sh` in `/config/scripts/post-config.d`. Be sure to `chmod +x` both scripts.

On the UniFi Controller, add snipet from `config.gateway.json` to your site. Note that the modification to `transition-script` from `config.gateway.json` appears to be overridden by Ubiquiti's provisioning, hence also adding a `task-scheduler` item to re-run the `postboot.sh` script to update the `transition-script`.

Tested on a USG-PRO-4 but should work on any USG variant with a two-interface failover WAN configuration. 

With slight modification it should also work with an EdgeRouter -- ignore `config.gateway.json`, remove the line calling `wan-event-report.sh` from `wan-load-balance-hack.sh`, and from the CLI add something like `set load-balance group wan_failover transition-script /config/scripts/wan-load-balance-hack.sh` to your configuration (your `group` name is probably different).
