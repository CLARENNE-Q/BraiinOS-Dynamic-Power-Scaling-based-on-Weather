# README

Connect to BrainOS Miner
```
ssh -l root 192.168.1.X
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
You can have a free API Key here: https://home.openweathermap.org/api_keys


Also if you need to modify temperature/power you can change this bloc:
```
if value.main.temp > 20
then
	neededpower = '1000'
else
	if value.main.temp > 10
	then
		neededpower = '1200'
	else
		if value.main.temp > 0
		then
			neededpower = '1400'
		else
			neededpower = '1600'
		end
	end
end
```
You can also switch from celsius to fahrenheit: `&units=metric` by `&units=imperial` Cf: https://openweathermap.org/current#data


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

Tadam, It's works !
