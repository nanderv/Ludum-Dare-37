local system = {}

system.name = "controller_movement"

system.register = function(entity)

end

system.update = function(dt)
  -- print("stick")
  for k,stick in pairs(love.joystick.getJoysticks()) do
    -- print(stick:getName())
    -- guid = stick:getGUID()
    -- print(love.joystick.getJoystickCount() .. tostring(stick:isVibrationSupported()) .. " : " .. tostring(stick:setVibration(0.5,0.5)) .. " : ".. stick:getVibration())
    -- print("Axis: " .. stick:getAxis(1) .. " " .. stick:getAxis(2) .. " " .. stick:getAxis(3) .. " " .. stick:getAxis(4) .. " ".. stick:getAxis(5).. " ".. stick:getAxis(6))
    for i=1,stick:getButtonCount() do
      if stick:isDown(i) then
        print(i)
      end
    end
  end
end

system.requirements = {position=true, basic_move=true, speed=true}

return system
