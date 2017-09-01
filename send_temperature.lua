influxdb_server="http://192.168.31.221:8086/write?db=telegraf"
data_table="home_temperature"
location="office"


local tempData = require("mod_temp")

function Send2influxDB()
-- get data from temperature module
temp_C, humi = tempData.getTemperature()

-- send data to influxDB
http.post(influxdb_server,
  'Content-Type: plain/text\r\n',
  data_table..",location="..location.." temperature_C="..temp_C..",humidity="..humi,
  function(code, data)
    if (code < 0) then
      print("HTTP request failed")
    else
      print(code, data)
    end
  end)
end

Send2influxDB()

-- iteration counter for wifi reconnect
wifi_i=1

-- send data to influx every 60 seconds
tmr.alarm(1,60000, 1, function() Send2influxDB() wifi_i=wifi_i+1 if wifi_i==100 then wifi_i=0 wifi.sta.connect() print("Reconnect")end end)
