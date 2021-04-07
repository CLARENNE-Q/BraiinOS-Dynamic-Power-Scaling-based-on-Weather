local cjson = require "cjson"
local http = require "socket.http"
-- Register free and get API key HERE: https://home.openweathermap.org/api_keys
local openweathermapapikey = "305703100f01b46807205991806ecXXX"
local lat = "45.5016889"
local lon = "-73.567256"
local data = ""

---- Get current power from bosminer.toml
local handle = io.popen("awk -F '= ' '/psu_power_limit/ {print $2}' /etc/bosminer.toml | tr -d '\r'| tr -d '\n'  ")
local currentpower = handle:read("*a")
handle:close()
print("Current Power: "..currentpower)

---- Get Weather from api.openweathermap.org
local function collect(chunk)
  if chunk ~= nil then
    data = data .. chunk
    end
  return true
end

local ok, statusCode, headers, statusText = http.request {
  method = "GET",
  url = "https://api.openweathermap.org/data/2.5/onecall?lat="..lat.."&lon="..lon.."&appid="..openweathermapapikey.."&units=metric",
  sink = collect
}

value = cjson.decode(data)
print("MTL Current TEMP: "..value.current.temp)

---- Determine needed Power
-->REAL HOT: --(1000W)-----20c---(1200W)----10c----(1400W)----0c---(1600)------ REALLY COOL
if value.current.temp > 20
then
	neededpower = '1000'
else
	if value.current.temp > 10
	then
		neededpower = '1100'
	else
		if value.current.temp > 0
		then
			neededpower = '1200'
		else
			neededpower = '1400'
		end
	end
end

if os.time(os.date("!*t")) > value.current.sunset
then
	if os.time(os.date("!*t")) > value.current.sunrise
	then
		print("Sunset")
		neededpower = neededpower + 200
	end
end


print("Needed: "..neededpower)

---- Check if needed power is good or not and set it
if (neededpower ~= currentpower)
then
	print("Set Power from "..currentpower.." to "..neededpower)
        os.execute("sed -i '/psu_power_limit/s/= .*/= "..neededpower.."/' /etc/bosminer.toml")
        os.execute("/etc/init.d/bosminer restart")
else
	print("Curent Power "..currentpower.." is OK")	
end
