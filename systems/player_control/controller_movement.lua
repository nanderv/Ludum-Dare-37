local system = {}

system.name = "controller_movement"

system.register = function(entity)
  if love.joystick.getJoystickCount() == 1 then
    system.joystick = love.joystick.getJoysticks()
  end
end

system.update = function(dt)
  if system.joystick then
    for k,stick in pairs(system.joystick) do
      guid = stick:getGUID()
      print("guid> " .. guid)
    end
  end
end

system.requirements = {position=true, basic_move=true, speed=true}

return system
