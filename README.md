# BraiinOS-Dynamic-Power-Scaling-based-on-Weather

ssh -l root 192.168.1.184


----
EDITOR=nano crontab -e
----
0 * * * * /usr/bin/lua /root/ajust_miner_power_based_on_weather.lua
----


