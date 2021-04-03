# BraiinOS-Dynamic-Power-Scaling-based-on-Weather


Connect to BrainOS Miner
```
ssh -l root 192.168.1.184
```

Get Lua Script:
```
wget https://raw.githubusercontent.com/CLARENNE-Q/BraiinOS-Dynamic-Power-Scaling-based-on-Weather/main/ajust_miner_power_based_on_weather.lua -O /root/ajust_miner_power_based_on_weather.lua
```

Edit file:
```
nano /root/ajust_miner_power_based_on_weather.lua
```

Adjust thoses lines:
```
local openweathermapapikey = "305703100f01b46807205991806ecXXX"
local openweathermapcityname = "montreal"
```

Test it:
```lua ajust_miner_power_based_on_weather.lua```

Add to CRON:
```
EDITOR=nano crontab -e
```

Add this line:
```
0 * * * * /usr/bin/lua /root/ajust_miner_power_based_on_weather.lua
```


