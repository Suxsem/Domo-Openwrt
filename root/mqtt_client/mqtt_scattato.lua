#!/usr/bin/lua
-- February 2015, Suxsem

require("socket")

mosq = require("mosquitto")
local mqtt = mosq.new("sonny_lua_scattato", true)
mqtt:login_set("***", "***")

local disattivato = false

local timer = function (time)
        local init = os.time()
        local diff = os.difftime(os.time(),init)
        while diff < time do
                coroutine.yield(diff)
        diff = os.difftime(os.time(),init)
        end
        if disattivato == false then
                mqtt:publish("Suxsem/Allarme", "Allarme!", 2)
        end
end

local callback = function (mid, topic, message)
        print("Received: " .. topic .. ": " .. message)
        if topic == "DomoOne/Scattato" then
                disattivato = false
                co = coroutine.create(timer)
                coroutine.resume(co, 20)
        end
        if topic == "DomoOne/Allarme" and message == "0" then
                disattivato = true
        end
end

mqtt:callback_set("ON_MESSAGE", callback)

local connected = false

mqtt:callback_set("ON_CONNECT", function ()
        print("Connected")
        connected = true
        mqtt:subscribe("DomoOne/Scattato", 2)
        mqtt:subscribe("DomoOne/Allarme", 2)
end)
mqtt:callback_set("ON_DISCONNECT", function ()
        print("Disconnected")
        connected = false
end)

mqtt:connect("127.0.0.1", 1883, 60)

while true do
        mqtt:loop()
        if connected then
                if co ~= nil and coroutine.status(co) ~= "dead" then
                        coroutine.resume(co)
                end
                socket.sleep(1.0) -- seconds
        else
                socket.sleep(5.0)
                mqtt:reconnect()
        end
end
