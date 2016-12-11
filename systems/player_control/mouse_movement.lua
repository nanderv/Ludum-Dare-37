local system = {}

system.name = "mouse_movement"

system.update = function(dt)
  for k,v in pairs(system.targets) do
    local dx, dy = love.mouse.getPosition()

    dx = dx - love.graphics.getWidth()/2
    -- dy = dy - love.graphics.getHeight()/2
    -- print("mouse " .. dx .. " " .. dy)

    -- dirX = v.position.dirX + dx*v.speed.rotate * dt
    -- dirY = v.position.dirY + dy*v.speed.rotate * dt

    dirX = v.position.dirX
    dirY = v.position.dirY
    planeX = v.position.planeX
    planeY = v.position.planeY

    rotSpeed = dt * v.speed.rotate * math.abs(dx)
    -- right
    if dx > 0 then
      local oldDirX = dirX
      dirX = dirX * math.cos(-rotSpeed) - dirY * math.sin(-rotSpeed)
      dirY = oldDirX * math.sin(-rotSpeed) + dirY * math.cos(-rotSpeed)
      local oldPlaneX = planeX
      planeX = planeX * math.cos(-rotSpeed) - planeY * math.sin(-rotSpeed)
      planeY = oldPlaneX * math.sin(-rotSpeed) + planeY * math.cos(-rotSpeed)
    end
    -- left
    if dx < 0 then
      local oldDirX = dirX
      dirX = dirX * math.cos(rotSpeed) - dirY * math.sin(rotSpeed)
      dirY = oldDirX * math.sin(rotSpeed) + dirY * math.cos(rotSpeed)
      local oldPlaneX = planeX
      planeX = planeX * math.cos(rotSpeed) - planeY * math.sin(rotSpeed)
      planeY = oldPlaneX * math.sin(rotSpeed) + planeY * math.cos(rotSpeed)
    end

    v.position.dirX = dirX
    v.position.dirY = dirY
    v.position.planeX =planeX
    v.position.planeY = planeY

    love.mouse.setX(love.graphics.getWidth()/2)
    love.mouse.setY(love.graphics.getHeight()/2)
  end
end

system.requirements = {position=true,basic_move=true,speed=true}

return system
