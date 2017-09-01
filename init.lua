-- Connect to router
wifi.setmode(wifi.STATION)
wifi.sta.config("YR_xiaomi","MikroTik321*!") -- WiFi 
wifi.sta.connect()
tmr.delay(5000000) -- wait in microseconds to receive an IP address

print(wifi.sta.getip()) -- Print your IP Address

-- connect modules
dofile("send_temperature.lua")
dofile("i2c_monochrome.lua")
