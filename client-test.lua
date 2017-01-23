--connect to wifi
wifi.setmode(wifi.STATION)
wifi.sta.config("antoniafreire2.0","2808193666")

-- a simple post request
function try_connect()
    if (wifi.sta.status() == 5) then
        print("Conectado!")
        print(wifi.sta.getip())
        http.post('http://192.168.0.3:5000',
          'Content-Type: application/json\r\n',
          '{"hello":"world"}',
          function(code, data)
            print("Posting...")
            if (code < 0) then
              print("HTTP request failed")
            else
              print(code, data)
            end
          end)
        tmr.stop(0)
    else
        print("Conectando...")
        print(wifi.sta.status())
        print(wifi.sta.getip())
    end
end

tmr.alarm(0,1000,1, function() try_connect() end )
