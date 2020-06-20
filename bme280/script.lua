--[[
	This will be called by init.lua
	OR
	will be called by wifi.lua if WiFi is enabled
]]

-- Constant
intI2cSda = 6 --IO12
intI2cScl = 5 --IO14
intBme280ReadMs = 5000 --5s

-- Timer for BME280 read callback
function onTimerBme280Read()
	T, P, H = bme280.read()
	local Tsgn = (T < 0 and -1 or 1); T = Tsgn*T
	print(string.format("T=%s%d.%02d", Tsgn<0 and "-" or "", T/100, T%100))
	print(string.format("QFE=%d.%03d", P/1000, P%1000))
	print(string.format("H=%d.%03d%%", H/1000, H%1000))
	print("----------")
end

-- I2C init
i2c.setup(0, intI2cSda, intI2cScl, i2c.SLOW)
objBme280Init = bme280.setup()
print("BME280 setup done")

-- Create timer for BME280 if init OK
if objBme280Init ~= nil then
	tmrBme280Read = tmr.create()
	tmrBme280Read:register(intBme280ReadMs, tmr.ALARM_AUTO, onTimerBme280Read)
	tmrBme280Read:start()
else
	print("BME280 init failed")
end