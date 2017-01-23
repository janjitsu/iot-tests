--connect to wifi
wifi.setmode(wifi.STATION)
wifi.sta.config("antoniafreire2.0","2808193666")
print(wifi.sta.getip())

-- set port 7 as interruptor
gpio.mode(7, gpio.INT, gpio.PULLUP)
-- define trigger for interruptor
gpio.trig(7, "both", function(level)
    print(level)
end)
-- set gpios

-- a simple http server
srv=net.createServer(net.TCP, 2)
srv:listen(80,function(conn)
    conn:on("receive",function(conn,payload)
        print(payload)
        headers = "HTTP/1.0 200 OK\r\n"
        headers = headers.."Content-Type: application/json\r\n"

        body = "{\r\n"
        body = body.."'occupied': "..gpio.read(7)
        body = body.."\r\n}"

        conn:send(headers.."\r\n"..body,function(sk)
            sk:close()
        end)

        print("Going to sleep now...")
        node.dsleep(0)
    end)
end)
