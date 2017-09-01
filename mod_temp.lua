-- Temperature module for fast access to DHT sensor

-- usage:
-- local tempData = require("mod_temp")
-- Temp, Hum = tempData.getTemperature()

data_pin=4 -- DHT sensor pin

-- Initial values
humi=0
temp_C=0

local M = {}

--load DHT module and read sensor
function M.ReadDHT()
    status, temp_C, humi, temp_dec, humi_dec = dht.read(data_pin)
    if status == dht.OK then
        print("DHT Temperature:"..temp_C..";".."Humidity:"..humi)
    elseif status == dht.ERROR_CHECKSUM then
        print( "DHT Checksum error." )
    elseif status == dht.ERROR_TIMEOUT then
        print( "DHT timed out." )
    end

   -- release module
   dht = nil
   package.loaded["dht"]=nil
end

function M.getTemperature()
    M.ReadDHT()
    return temp_C, humi
end

return M;
