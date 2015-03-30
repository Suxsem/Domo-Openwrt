#!/usr/bin/lua
-- February 2015, Suxsem

start_time = os.time()
mosq = require("mosquitto")
local mqtt = mosq.new(arg[1], true)
mqtt:login_set("***", "***")
mqtt:callback_set("ON_PUBLISH", function(mid)
        mqtt:disconnect()
        os.exit()
end)
mqtt:connect("127.0.0.1", 1883, 999)
mqtt:publish(arg[2], arg[3], arg[4], arg[5])
while true do
        mqtt:loop()
        if (os.difftime(os.time() - start_time) > 5) then
                break
        end
end
