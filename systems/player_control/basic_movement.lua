local system = {}

system.name = "basic_move"

system.update = function(dt)
	local player = game.entities.player
	local posX, posY = game.entities.player.position.posX, game.entities.player.position.posY
	local dirX, dirY = game.entities.player.position.dirX, game.entities.player.position.dirY
	local planeX, planeY = game.entities.player.position.planeX, game.entities.player.position.planeY
	moveSpeed = dt * 5.0

	rotSpeed = dt * 3.0
	strafeSpeed = dt * 5.0
	system.hasWall = game.systems.raycaster.hasWall
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
	if love.keyboard.isDown("right") then
		oldDirX = dirX
		dirX = dirX * math.cos(-rotSpeed) - dirY * math.sin(-rotSpeed)
		dirY = oldDirX * math.sin(-rotSpeed) + dirY * math.cos(-rotSpeed)
		oldPlaneX = planeX
		planeX = planeX * math.cos(-rotSpeed) - planeY * math.sin(-rotSpeed)
		planeY = oldPlaneX * math.sin(-rotSpeed) + planeY * math.cos(-rotSpeed)
	end
	if love.keyboard.isDown("left") then
		oldDirX = dirX
		dirX = dirX * math.cos(rotSpeed) - dirY * math.sin(rotSpeed)
		dirY = oldDirX * math.sin(rotSpeed) + dirY * math.cos(rotSpeed)
		oldPlaneX = planeX
		planeX = planeX * math.cos(rotSpeed) - planeY * math.sin(rotSpeed)
		planeY = oldPlaneX * math.sin(rotSpeed) + planeY * math.cos(rotSpeed)
	end

	game.entities.player.position.posX, game.entities.player.position.posY = posX, posY
	game.entities.player.position.dirX, game.entities.player.position.dirY = dirX, dirY
	game.entities.player.position.planeX, game.entities.player.position.planeY = planeX, planeY
end

system.requirements = {position=true,basic_move=true,speed=true}

return system
