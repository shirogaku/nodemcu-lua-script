--[[
	This will be called by init.lua
]]

-- Constant
WIFI_CFG = {}
WIFI_CFG.ssid = ""
WIFI_CFG.pwd = ""
WIFI_CFG.save = false

-- WIFI event monitor when connected
function on_wifi_connected(T)
	print("WIFI connected to "..T.SSID.." on channel "..T.channel)
end

-- Set as STATION
wifi.setmode(wifi.STATION)

-- WIFI set config
wifi.sta.config(WIFI_CFG)

-- WIFI connect
wifi.sta.connect(on_wifi_connected)
print("WIFI CONNECTING")