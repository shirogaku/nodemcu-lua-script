--[[
	This will call script.lua
]]

-- Flag
boolIsWifiRequired = false

-- Constant
strScriptFileName = "script.lua"
strWifiFileName = "wifi.lua"
intStartupMs = 5000
intWifiMs = 5000

--STARTUP CALLBACK
function onTimerStartup()
	print("trying to open script.lua")
	
	if file.open(strScriptFileName) ~= nil then
		collectgarbage()
		dofile(strScriptFileName)
	else
		print("script.lua not found")
	end
end

--WIFI CALLBACK
function onTimerWifi()
	print("trying to open "..strWifiFileName)
	
	if file.open(strWifiFileName) ~= nil then
		dofile(strWifiFileName)
	else
		print(strWifiFileName.." not found")
	end
end

--STARTUP/WIFI TIMER SETUP
tmrStartup = tmr.create()

if boolIsWifiRequired == true then
	tmrStartup:register(intWifiMs, tmr.ALARM_SINGLE, onTimerWifi)
	tmrStartup:start()
	print("setup wifi in 5s")
else
	tmrStartup:register(intStartupMs, tmr.ALARM_SINGLE, onTimerStartup)
	tmrStartup:start()
	print("startup in 5s")
end