--[[
	This will be called by init.lua
]]

-- Constant
WIFI_CFG = {}
WIFI_CFG.ssid = "shirok"
WIFI_CFG.pwd = "Ek@lOst1"
WIFI_CFG.save = false
WIFI_IS_AUTOCONNECT = 1

-- Flag
IS_CONNECTION_OK = false

-- WIFI event monitor when connected
function on_wifi_connected(T)
	print("WIFI connected to "..T.SSID.." on channel "..T.channel)
	IS_CONNECTION_OK = true
end

-- WIFI do autoconnect
wifi.sta.autoconnect(WIFI_IS_AUTOCONNECT)

-- WIFI set config
wifi.sta.config(WIFI_CFG)

-- WIFI connect
wifi.sta.connect(on_wifi_connected)
print("WIFI CONNECTING")

-- Wait until get ip
while IS_CONNECTION_OK == false do end