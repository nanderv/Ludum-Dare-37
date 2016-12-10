-----------------------------------------------------------------------------------
--------Raycasting code written by Ben White (scutheotaku), 2012 ------------------
--------Based on code by Lode Vandevenne (http://lodev.org/cgtutor/raycasting.html)
-----------------------------------------------------------------------------------
-------
------
-----
----
---
--

--setup map
local map={}
local floor = {}
local ceiling = {}
local system = {}
system.name = "raycaster"
local posX = 1
local posY = 1
local dirX = -1
local dirY = 0
local planeX = 0
local planeY = 0.7
local w = 400
local h = 300
local brick = get_image("redbrick")
local brickHeight = brick:getHeight()
local brickWidth  = brick:getWidth()
<<<<<<< HEAD

local wood = love.graphics.newImage('assets/wood.png')
local woodHeight = wood:getHeight()
local woodWidth  = wood:getWidth()


=======
local image_per = {}
>>>>>>> 32f994d56a95832ca497338e1148e8b17b7a29dc
local drawScreenLineStart = {}
local drawScreenLineEnd = {}
local drawScreenLineColor = {}
local positions_found = {}
function system.hasWall(x,y)
	return not not map[x..":"..y]
end
function system.wall(x,y)

		return  get_image(map[x..":"..y])
end
function system.getCeiling(x,y)
	return get_image(ceiling[x..":"..y])
end
function system.getFloor(x,y)
	return get_image(floor[x..":"..y])
end
function system.update(dt)
if love.graphics.getWidth() then
		w = love.graphics.getWidth()
		h = love.graphics.getHeight()
end
for x = 0, w, 1 do


		local cameraX = 1.9 * x / w - 1
		local rayPosX = posX
		local rayPosY = posY
		local rayDirX = dirX + planeX * cameraX
		local rayDirY = dirY + planeY * cameraX

		local mapX = math.floor(rayPosX)
		local mapY = math.floor(rayPosY)

		local sideDistX
		local sideDistY

		local deltaDistX = math.sqrt(1 + (rayDirY ^ 2) / (rayDirX ^ 2))
		local deltaDistY = math.sqrt(1 + (rayDirX ^ 2) / (rayDirY ^ 2))
		local perWallDist

		local stepX
		local stepY

		local hit = 0
		local side = 0

		if (rayDirX < 0) then
			stepX = -1
			sideDistX = (rayPosX - mapX) * deltaDistX
		else
			stepX = 1
			sideDistX = (mapX + 1.0 - rayPosX) * deltaDistX
		end
		if (rayDirY < 0) then
			stepY = -1
			sideDistY = (rayPosY - mapY) * deltaDistY
		else
			stepY = 1
			sideDistY = (mapY + 1.0 - rayPosY) * deltaDistY
		end
		local count = 0
		while (hit == 0) do
<<<<<<< HEAD
=======
			count = count + 1
			if count > 20 then
			 	break
			 	end
>>>>>>> 32f994d56a95832ca497338e1148e8b17b7a29dc
			if (sideDistX < sideDistY) then
				sideDistX = sideDistX + deltaDistX
				mapX = mapX + stepX
				side = 0
			else
				sideDistY = sideDistY + deltaDistY
				mapY = mapY + stepY
				side = 1
			end

			if (map[mapX][mapY] > 0) then
				hit = 1
				image_per[x] = system.wall(mapX,mapY)
				positions_found[x]  = {mapX, mapY}
			end
			end
			if hit==0 then
					mapX = 1000000
					mapY = 1000000
			end
			if (side == 0)then
				perpWallDist = math.abs((mapX - rayPosX + (1 - stepX) / 2) / rayDirX)
			else
				perpWallDist = math.abs((mapY - rayPosY + (1 - stepY) / 2) / rayDirY)
			end

			lineHeight = math.abs(math.floor(h / perpWallDist))

			drawStart = -lineHeight / 2 + h / 2
			if (drawStart < 0) then drawStart = 0 end
			drawEnd = lineHeight / 2 + h / 2
			if (drawEnd >= h) then drawEnd = h - 1 end


			drawScreenLineStart[x] = drawStart
			drawScreenLineEnd[x] = drawEnd
		end

		moveSpeed = dt * 5.0
		rotSpeed = dt * 3.0
		strafeSpeed = dt * 5.0

		if love.keyboard.isDown("w") then
			if (map[math.floor(posX + dirX * moveSpeed)][math.floor(posY)] == 0) then
				posX = posX + dirX * moveSpeed
			end
			if (map[math.floor(posX)][math.floor(posY + dirY * moveSpeed)] == 0) then
				posY = posY + dirY * moveSpeed
			end
		end
		if love.keyboard.isDown("s") then
			if (map[math.floor(posX - dirX * moveSpeed)][math.floor(posY)] == 0) then
				posX = posX - dirX * moveSpeed
			end
			if (map[math.floor(posX)][math.floor(posY - dirY * moveSpeed)] == 0) then
				posY = posY - dirY * moveSpeed
			end
		end
		if love.keyboard.isDown("d") then
			if (map[math.floor(posX + planeX * moveSpeed)][math.floor(posY)] == 0) then
				posX = posX + planeX * strafeSpeed
			end
			if (map[math.floor(posX)][math.floor(posY + planeY * moveSpeed)] == 0) then
				posY = posY + planeY * strafeSpeed
			end
		end
		if love.keyboard.isDown("a") then
			if (map[math.floor(posX - planeX * moveSpeed)][math.floor(posY)] == 0) then
				posX = posX - planeX * strafeSpeed
			end
			if (map[math.floor(posX)][math.floor(posY - planeY * moveSpeed)] == 0) then
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
end

function system.register(entity)
	if entity.walls.top then
		map[entity.position.x..":"..entity.position.y+1] = entity.walls.top
	end
		if entity.walls.bottom then
		map[entity.position.x..":"..entity.position.y-1] = entity.walls.bottom
	end
	if entity.walls.left then
		map[(entity.position.x-1)..":"..entity.position.y] = entity.walls.left
	end
		if entity.walls.right then
		map[(entity.position.x+1)..":"..entity.position.y] = entity.walls.right
	end
end
function system.unregister(entity)
	if entity.walls.top then
		map[entity.position.x..":"..entity.position.y+1] = nil
	end
		if entity.walls.bottom then
		map[entity.position.x..":"..entity.position.y-1] = nil
	end
	if entity.walls.left then
		map[(entity.position.x-1)..":"..entity.position.y] = nil
	end
		if entity.walls.right then
		map[(entity.position.x+1)..":"..entity.position.y] = nil
	end
end
function system.draw()
	love.graphics.setColor(200, 200, 200);
	for x = 0, w, 1 do
		love.graphics.line(x, 0, x, drawScreenLineStart[x])
	end

	love.graphics.setColor(255, 255, 255);
	for x = 0, w, 1 do
			quad = love.graphics.newQuad((x)  % brickWidth, 0, 1, brickHeight, brickWidth, brickHeight)

		if image_per[x] then
			love.graphics.draw(image_per[x], quad, x, drawScreenLineStart[x], 0, 1, (drawScreenLineEnd[x] - drawScreenLineStart[x] + 1) / brickHeight,  0, 0)
		end
	end

	love.graphics.setColor(200, 200, 200);
	for x = 0, w, 1 do
		love.graphics.line(x, drawScreenLineEnd[x], x, h)
	end
	--love.graphics.draw(brick, quad, x, drawScreenLineStart[x], 45, 1, (drawScreenLineEnd[x] - drawScreenLineStart[x] + 1) / brickHeight,  0, 0)
	love.graphics.print("FPS: "..tostring(love.timer.getFPS( )), 10, 10, 0, 3)
end

function love.keypressed(key, unicode)
     if key == " " then love.graphics.toggleFullscreen() end

end
system.requirements = {position = true, walls= true}

return system
