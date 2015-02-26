#!/usr/bin/lua
-- February 2015, Suxsem

mosq = require("mosquitto")
local mqtt = mosq.new(arg[1], true)
mqtt:login_set("***", "***")
mqtt:callback_set("ON_PUBLISH", function(mid)
        mqtt:disconnect()
end)
mqtt:connect("127.0.0.1", 1883, 999)
mqtt:publish(arg[2], arg[3], arg[4], arg[5])
mqtt:loop_forever()