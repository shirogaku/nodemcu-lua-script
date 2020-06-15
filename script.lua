--[[
	This will be called by init.lua
]]

-- Constant
I2C_SDA = 6 --IO12
I2C_SCL = 5 --IO14
BME_280_READ_MS = 5000 --5s

-- UART On DATA callback
function on_uart_data(data)
	UART_BUFF = data
	print(data)
	uart.on("data")
end

-- Timer for BME280 read callback
function on_timer_bme280_read()
	T, P, H = bme280.read()
	local Tsgn = (T < 0 and -1 or 1); T = Tsgn*T
	print(string.format("T=%s%d.%02d", Tsgn<0 and "-" or "", T/100, T%100))
	print(string.format("QFE=%d.%03d", P/1000, P%1000))
	print(string.format("H=%d.%03d%%", H/1000, H%1000))
	print("----------")
end

-- UART callback register
uart.on("data", 1, on_uart_data, 0)
print("UART on DATA registered")

-- I2C init
i2c.setup(0, I2C_SDA, I2C_SCL, i2c.SLOW)
bme280_init = bme280.setup()
print("BME280 setup done")

-- Create timer for BME280 if init OK
if bme280_init ~= nil then
	bme280_read_timer = tmr.create()
	bme280_read_timer:register(BME_280_READ_MS, tmr.ALARM_AUTO, on_timer_bme280_read)
	bme280_read_timer:start()
else
	print("BME280 init failed")
end