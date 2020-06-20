--[[
	This will be called by init.lua
]]

-- Constant
WIFI_CFG = {}
WIFI_CFG.ssid = ""
WIFI_CFG.pwd = ""
WIFI_CFG.save = false

-- Jump to script
function do_script()
	print("trying to open script.lua")
	
	if file.open("script.lua") ~= nil then
		collectgarbage()
		dofile("script.lua")
	else
		print("script.lua not found")
	end
end

-- WIFI event monitor when connected
function on_wifi_connected(T)
	print("WIFI connected to "..T.SSID.." on channel "..T.channel)
end

-- WIFI event monitor when DHCP done
function on_ip_dhcp_done(T)
	print("IP address is "..T.IP)
	do_script()
end

-- Set as STATION
wifi.setmode(wifi.STATION)

-- WIFI event monitor
-- On wifi connected
wifi.eventmon.register(wifi.eventmon.STA_CONNECTED, on_wifi_connected)
-- On wifi dhcp received
wifi.eventmon.register(wifi.eventmon.STA_GOT_IP, on_ip_dhcp_done)

-- WIFI set config
wifi.sta.config(WIFI_CFG)

-- WIFI connect
wifi.sta.connect()
print("WIFI connecting")