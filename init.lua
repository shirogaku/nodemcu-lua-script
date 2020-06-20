--[[
	This will call script.lua
]]

-- Flag
IS_WIFI_REQUIRED = true

-- Constant
STARTUP_MS = 5000
WIFI_MS = 5000

--STARTUP CALLBACK
function on_timer_startup()
	print("trying to open script.lua")
	
	if file.open("script.lua") ~= nil then
		collectgarbage()
		dofile("script.lua")
	else
		print("script.lua not found")
	end
end

--WIFI CALLBACK
function on_timer_wifi()
	print("trying to open wifi.lua")
	
	if file.open("wifi.lua") ~= nil then
		dofile("wifi.lua")
	else
		print("wifi.lua not found")
	end
end

--STARTUP/WIFI TIMER SETUP
startup = tmr.create()

if IS_WIFI_REQUIRED == true then
	startup:register(WIFI_MS, tmr.ALARM_SINGLE, on_timer_wifi)
	startup:start()
	print("setup wifi in 5s")
else
	startup:register(STARTUP_MS, tmr.ALARM_SINGLE, on_timer_startup)
	startup:start()
	print("startup in 5s")
end