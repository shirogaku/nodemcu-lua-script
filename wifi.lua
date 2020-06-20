--[[
	This will be called by init.lua
]]

-- Constant
strScriptFileName = "script.lua"
strWifiFileName = "wifi.lua"

tblWifiCfg = {}
tblWifiCfg.ssid = ""
tblWifiCfg.pwd = ""
tblWifiCfg.save = false

-- Jump to script
function doScript()
	print("trying to open "..strScriptFileName)
	
	if file.open(strScriptFileName) ~= nil then
		collectgarbage()
		dofile(strScriptFileName)
	else
		print(strScriptFileName.." not found")
	end
end

-- WIFI event monitor when connected
function onWifiConnected(T)
	print("WIFI connected to "..T.SSID.." on channel "..T.channel)
end

-- WIFI event monitor when DHCP done
function onIpDhcpDone(T)
	print("IP address is "..T.IP)
	doScript()
end

-- Set as STATION
wifi.setmode(wifi.STATION)

-- WIFI event monitor
-- On wifi connected
wifi.eventmon.register(wifi.eventmon.STA_CONNECTED, onWifiConnected)
-- On wifi dhcp received
wifi.eventmon.register(wifi.eventmon.STA_GOT_IP, onIpDhcpDone)

-- WIFI set config
wifi.sta.config(tblWifiCfg)

-- WIFI connect
wifi.sta.connect()
print("WIFI connecting")