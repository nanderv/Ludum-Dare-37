local system = {}

system.name = "basic_move"

system.update = function(dt)
  system.hasWall = game.systems.raycaster.hasWall
  for k,v in pairs(system.targets) do
    local posX, posY = v.position.posX, v.position.posY
    local dirX, dirY = v.position.dirX, v.position.dirY
    local planeX, planeY = v.position.planeX, v.position.planeY
    moveSpeed = dt * v.speed.movement

    strafeSpeed = dt * v.speed.strafe
    if love.keyboard.isDown("w") then
      if (not system.hasWall(math.floor(posX + dirX * moveSpeed),math.floor(posY))) then
        posX = posX + dirX * moveSpeed
      end
      if (not system.hasWall(math.floor(posX),math.floor(posY + dirY * moveSpeed))) then
        posY = posY + dirY * moveSpeed
      end
    end
    if love.keyboard.isDown("s") then
      if (not system.hasWall(math.floor(posX - dirX * moveSpeed),math.floor(posY))) then
        posX = posX - dirX * moveSpeed
      end
      if (not system.hasWall(math.floor(posX),math.floor(posY - dirY * moveSpeed))) then
        posY = posY - dirY * moveSpeed
      end
    end
    if love.keyboard.isDown("d") then
      if (not system.hasWall(math.floor(posX + planeX * moveSpeed),math.floor(posY))) then
        posX = posX + planeX * strafeSpeed
      end
      if (not system.hasWall(math.floor(posX),math.floor(posY + planeY * moveSpeed))) then
        posY = posY + planeY * strafeSpeed
      end
    end
    if love.keyboard.isDown("a") then
      if (not system.hasWall(math.floor(posX - planeX * moveSpeed),math.floor(posY))) then
        posX = posX - planeX * strafeSpeed
      end
      if (not system.hasWall(math.floor(posX),math.floor(posY - planeY * moveSpeed))) then
        posY = posY - planeY * strafeSpeed
      end
    end

    v.position.posX, v.position.posY = posX, posY
    v.position.dirX, v.position.dirY = dirX, dirY
    v.position.planeX, v.position.planeY = planeX, planeY
  end
end

system.requirements = {position=true,basic_move=true,speed=true}

return system
