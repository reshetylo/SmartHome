-- Module for I2C monochrome 0.96" 128x64 OLED graphic display with SSD1306 controller

-- Requirements:
-- i2c
-- u2g with ssd1306_128x64_i2c, font_chikita, font_freedoomr25n

-- Variables
sda = 1 -- SDA Pin
scl = 2 -- SCL Pin
count = 0

function init_OLED(sda,scl) --Set up the u8glib lib
     sla = 0x3C
     i2c.setup(0, sda, scl, i2c.SLOW)
     disp = u8g.ssd1306_128x64_i2c(sla)
     disp:setFont(u8g.font_chikita)
     disp:setFontRefHeightExtendedText()
     disp:setDefaultForegroundColor()
     disp:setFontPosTop()
     --disp:setRot180()           -- Rotate Display if needed
end

function print_OLED()
   disp:firstPage()
   repeat
     ---disp:drawFrame(2,2,126,62)
     if count > 20 then
      count = 0
     end
     disp:setFont(u8g.font_chikita)
     disp:drawStr(0, 5, "Temperature")
     disp:drawStr(0, 60, "Humidity")
     disp:setFont(u8g.font_freedoomr25n)
     disp:drawStr(0+count, 35, str1)
     disp:drawStr(40+count, 65, str2)
     ---disp:drawCircle(18, 47, 14)
   until disp:nextPage() == false
end

-- Main Program code
local tempData = require("mod_temp")

function updateData()
T, H = tempData.getTemperature()
str1=string.format("%.01f", T)
str2=string.format("%.01f", H)
print_OLED()
end

init_OLED(sda,scl)
updateData()
tmr.alarm(0,6000,1,function()
   updateData()
   count = count + 1
end)
