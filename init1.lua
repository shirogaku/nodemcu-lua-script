--[[
	This will call script.lua
]]

-- Constant
STARTUP_MS = 5000

-- DO NOT make IS_WIFI_REQUIRED true OR RE-FLASH NODEMCU RUNTIME!!!
IS_WIFI_REQUIRED = true
WIFI_MS = 5000

-- Flag
IS_WIFI_SCRIPT_DONE = false

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
	
	IS_WIFI_SCRIPT_DONE = true
end
print("UART")
--Setup UART for interperter
uart.on("data", 1, function() end, 1)

while true do 
	tmr.wdclr()
end

--WIFI TIMER SETUP
if IS_WIFI_REQUIRED == true then
	--WIFI TIMER SETUP
	startup = tmr.create()
	startup:register(WIFI_MS, tmr.ALARM_SINGLE, on_timer_wifi)
	startup:start()
	print("setup wifi in 5s")
	
	--Wait until wifi done
	--while IS_WIFI_REQUIRED and IS_WIFI_SCRIPT_DONE == false do end
	-- TODO: This "while" is blocking the flashing process. Must be done with something
	while IS_WIFI_SCRIPT_DONE == false do end
end

--STARTUP TIMER SETUP
startup = tmr.create()
startup:register(STARTUP_MS, tmr.ALARM_SINGLE, on_timer_startup)
startup:start()
print("startup in 5s")