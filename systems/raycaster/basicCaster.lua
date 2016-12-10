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
local entities = {}
system.name = "raycaster"

local w = 0
local h = 0
local image = get_image("redbrick")
local imageHeight = 128
local imageWidth  = 64
local image_per = {}
local drawScreenLineStart = {}
local drawScreenLineEnd = {}
local drawScreenLineColor = {}

local drawEntityLineStart = {}
local drawEntityLineEnd = {}

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
function system.getEntity(x,y)
	return get_image(entities[x..":"..y])
end
function system.getFloor(x,y)
	return get_image(floor[x..":"..y])
end
function system.update(dt)
	local posX, posY = game.entities.player.position.posX, game.entities.player.position.posY
	local dirX, dirY = game.entities.player.position.dirX, game.entities.player.position.dirY
	local planeX, planeY = game.entities.player.position.planeX, game.entities.player.position.planeY
	if love.graphics.getWidth() then
		w = love.graphics.getWidth()/2
		h = love.graphics.getHeight()/2
	end
	for x = 0, w, 1 do
		entities[x] = {}
		drawEntityLineStart[x] = {}
		drawEntityLineEnd[x] = {}
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
		local entityCounter = 0;
		while (hit == 0) do
			count = count + 1
			if count > 20 then
				image_per[x] = nil
			 	break
			 	end
			if (sideDistX < sideDistY) then
				sideDistX = sideDistX + deltaDistX
				mapX = mapX + stepX
				side = 0
			else
				sideDistY = sideDistY + deltaDistY
				mapY = mapY + stepY
				side = 1
			end

			if (system.hasWall(mapX,mapY)) then
				hit = 1
				image_per[x] = system.wall(mapX,mapY)
				positions_found[x]  = {mapX, mapY}
			end

			if system.getEntity(mapX, mapY) then
				entityCounter = entityCounter + 1

				entities[x][entityCounter] = system.getEntity(mapX, mapY)
				if (side == 0) then
					perpWallDist = math.abs((mapX - rayPosX + (1 - stepX) / 2) / rayDirX)
				else
					perpWallDist = math.abs((mapY - rayPosY + (1 - stepY) / 2) / rayDirY)
				end

				lineHeight = math.abs(math.floor(h / perpWallDist))

				drawStart = -lineHeight / 2 + h / 2
				drawEnd = lineHeight / 2 + h / 2

				local wallX --where exactly the wall was hit
				if (side == 0) then
				 wallX = rayPosY + perpWallDist * rayDirY;
				else
				 wallX = rayPosX + perpWallDist * rayDirX;
				end
				wallX = wallX - math.floor((wallX));

				local texX = math.floor(wallX * imageWidth);
				if(side == 0 and rayDirX > 0) then texX = imageWidth - texX - 1 end
				if(side == 1 and rayDirY < 0) then texX = imageWidth - texX - 1 end
				drawEntityLineStart[x][entityCounter] = drawStart
				drawEntityLineEnd[x][entityCounter] = drawEnd
			end
		end
		if hit==0 then
				mapX = 1000000
				mapY = 1000000
		end
		if (side == 0) then
			perpWallDist = math.abs((mapX - rayPosX + (1 - stepX) / 2) / rayDirX)
		else
			perpWallDist = math.abs((mapY - rayPosY + (1 - stepY) / 2) / rayDirY)
		end

		lineHeight = math.abs(math.floor(h / perpWallDist))

		drawStart = -lineHeight / 2 + h / 2
		drawEnd = lineHeight / 2 + h / 2


		local wallX --where exactly the wall was hit
		if (side == 0) then
		 wallX = rayPosY + perpWallDist * rayDirY;
		else
		 wallX = rayPosX + perpWallDist * rayDirX;
		end
		wallX = wallX - math.floor((wallX));

		--x coordinate on the texture
		local texX = math.floor(wallX * imageWidth);
		if(side == 0 and rayDirX > 0) then texX = imageWidth - texX - 1 end
		if(side == 1 and rayDirY < 0) then texX = imageWidth - texX - 1 end
		drawScreenLineStart[x] = drawStart
		drawScreenLineEnd[x] = drawEnd
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
	entities[(entity.position.x+1)..":"..entity.position.y] = entity.walls.entity
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
	entities[(entity.position.x+1)..":"..entity.position.y] = nil

end
function system.draw()
	love.graphics.push()
	love.graphics.scale(2);
	love.graphics.setColor(200, 200, 200)
	for x = 0, w, 1 do
		love.graphics.line(x, 0, x, drawScreenLineStart[x])
	end


	love.graphics.setColor(100, 100, 100)
	for x = 0, w, 1 do
		love.graphics.line(x, drawScreenLineEnd[x], x, h)
		--love.graphics.line(x1, y1, x2, y2, ...)
	end
	love.graphics.setColor(255, 255, 255)

	for x = 0, w, 1 do
		quad = love.graphics.newQuad((x)  % imageWidth, 0, 1, imageHeight, imageWidth, imageHeight)
		if image_per[x] then
			love.graphics.draw(image_per[x], quad, x, drawScreenLineStart[x], 0, 1, (drawScreenLineEnd[x] - drawScreenLineStart[x] + 1) / imageHeight,  0, 0)
		end
	end
	for x = 0, w, 1 do
		for i = 20, 0, -1 do

			if  entities[x] and entities[x][i] then

				quad = love.graphics.newQuad((x) % imageWidth, 0, 1, imageHeight, imageWidth, imageHeight)
				love.graphics.draw(entities[x][i], quad, x, drawEntityLineStart[x][i], 0, 1, (drawEntityLineEnd[x][i] - drawEntityLineStart[x][i] + 1) / imageHeight, 0, 0)
			end
		end
	end
	love.graphics.pop()
	love.graphics.print("FPS: "..tostring(love.timer.getFPS( )), 10, 10, 0, 3)

end

function love.keypressed(key, unicode)
     if key == " " then love.graphics.toggleFullscreen() end

end
system.requirements = {position = true, walls= true}

return system
