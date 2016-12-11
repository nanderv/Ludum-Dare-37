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
local entities = {}
local floors = {}
local ceiling = {}
local system = {}

system.name = "raycaster"

local w = love.graphics.getWidth()/2
local h = love.graphics.getHeight()/2
local image = get_image("redbrick")
local imageHeight = 128
local imageWidth  = 64
local image_per = {}
local drawScreenLineStart = {}
local drawScreenLineEnd = {}
local drawScreenLineColor = {}

local textureX = {}
local entityTextureX = {}
local floorTextureX = {}

local floorVariable = {}

local drawEntityLineStart = {}
local drawEntityLineEnd = {}
local drawFloorLineStart = {}
local drawFloorLineEnd = {}

local positions_found = {}
function system.hasWall(x,y)
	return not not map[x..":"..y] or not not floors[x..":"..y]
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
	return get_image(floors[x..":"..y])
end
function system.update(dt)
	local posX, posY = game.entities.player.position.posX, game.entities.player.position.posY
	local dirX, dirY = game.entities.player.position.dirX, game.entities.player.position.dirY
	local planeX, planeY = game.entities.player.position.planeX, game.entities.player.position.planeY
	for x = 0, w, 1 do
		entities[x] = {}
		drawEntityLineStart[x] = {}
		drawEntityLineEnd[x] = {}

		floors[x] = {}
		drawFloorLineStart[x] = {}
		drawFloorLineEnd[x] = {}

		floorTextureX[x]  = {}
		entityTextureX[x] = {}

		floorVariable[x] = {}

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
		local entityCounter = 0
		local floorCounter  = 0
		while (hit == 0) do
			count = count + 1
			if count > 10 then
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

				perpWallDist = math.sqrt((mapX - posX) ^ 2 + (mapY - posY) ^ 2 )

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

				local spriteX = mapX + 0.5 - posX;
				local spriteY = mapY + 0.5 - posY;

				---transform sprite with the inverse camera matrix
				-- [ planeX   dirX ] -1                                       [ dirY      -dirX ]
				-- [               ]       =  1/(planeX*dirY-dirX*planeY) *   [                 ]
				-- [ planeY   dirY ]                                          [ -planeY  planeX ]

				local invDet = 1.0 / (planeX * dirY - dirX * planeY) --required for correct matrix multiplication

				local transformX = invDet * (dirY * spriteX - dirX * spriteY)
				local transformY = invDet * (-planeY * spriteX + planeX * spriteY) --this is actually the depth inside the screen, that what Z is in 3D

				local spriteScreenX = math.floor((w / 2) * (1 + transformX / transformY))

				--calculate height of the sprite on screen
				local spriteHeight = math.abs(math.floor(h / (transformY))) --using "transformY" instead of the real distance prevents fisheye
				--calculate lowest and highest pixel to fill in current stripe
				local drawStartY = -spriteHeight / 2 + h / 2
				local drawEndY = spriteHeight / 2 + h / 2


				--calculate width of the sprite
				local spriteWidth = math.abs( math.floor (h / (transformY)))
				local drawStartX = -spriteWidth / 2 + spriteScreenX;
				local drawEndX = spriteWidth / 2 + spriteScreenX;


				if(side == 0 and rayDirX > 0) then texX = imageWidth - texX - 1 end
				if(side == 1 and rayDirY < 0) then texX = imageWidth - texX - 1 end
				drawEntityLineStart[x][entityCounter] = drawStartY
				drawEntityLineEnd[x][entityCounter] = drawEndY
				if x < drawStartX or x > drawEndX then
					texX = nil
				else
					texX = (x - (-spriteWidth / 2 + spriteScreenX)) * imageWidth / spriteWidth
				end

				entityTextureX[x][entityCounter] = texX

			end


			if system.getFloor(mapX, mapY) then
				floorCounter = floorCounter + 1

				floors[x][floorCounter] = system.getFloor(mapX, mapY)
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
				drawFloorLineStart[x][floorCounter] = drawStart
				drawFloorLineEnd[x][floorCounter] = drawEnd
				floorTextureX[x][floorCounter] = texX
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
		texX = math.floor(wallX * imageWidth);
		textureX[x] = texX
		if(side == 0 and rayDirX > 0) then texX = imageWidth - texX - 1 end
		if(side == 1 and rayDirY < 0) then texX = imageWidth - texX - 1 end
		drawScreenLineStart[x] = drawStart
		drawScreenLineEnd[x] = drawEnd

		--FLOOR CASTING
		local floorXWall, floorYWall --x, y position of the floor texel at the bottom of the wall

		--4 different wall directions possible
		if(side == 0 and rayDirX > 0) then
			floorXWall = mapX
			floorYWall = mapY + wallX
		elseif(side == 0 and rayDirX < 0) then
			floorXWall = mapX + 1.0
			floorYWall = mapY + wallX
		elseif(side == 1 and rayDirY > 0) then
			floorXWall = mapX + wallX
			floorYWall = mapY
		else
			floorXWall = mapX + wallX
			floorYWall = mapY + 1.0
		end

		local distWall, distPlayer

		distWall = perpWallDist
		distPlayer = 0.0

		if (drawEnd < 0) then
			drawEnd = h
		end
		floorVariable[x][0] = distWall
		floorVariable[x][1] = distPlayer
		floorVariable[x][2] = floorXWall
		floorVariable[x][3] = floorYWall
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
	entities[(entity.position.x)..":"..entity.position.y] = entity.walls.entity
	floors[(entity.position.x)..":"..entity.position.y] = entity.walls.floor
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
	entities[(entity.position.x)..":"..entity.position.y] = nil
	floors[(entity.position.x)..":"..entity.position.y] = nil

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
		quad = love.graphics.newQuad((textureX[x])  % imageWidth, 0, 1, imageHeight, imageWidth, imageHeight)
		if image_per[x] then
			love.graphics.draw(image_per[x], quad, x, drawScreenLineStart[x], 0, 1, (drawScreenLineEnd[x] - drawScreenLineStart[x] + 1) / imageHeight,  0, 0)
		end
	end
	local imageData = image:getData()
	for x = 0, w, 1 do
		for y = drawEnd + 1, h, 1 do
			local distWall = floorVariable[x][0]
			local distPlayer = floorVariable[x][1]
			local floorXWall = floorVariable[x][2]
			local floorYWall = floorVariable[x][3]
			local imageWidth = 64
			local imageHeight = 64
			local posX, posY = game.entities.player.position.posX, game.entities.player.position.posY
			currentDist = h / (2.0 * y - h) --you could make a small lookup table for this instead

			local weight = (currentDist - distPlayer) / (distWall - distPlayer);

			local currentFloorX = weight * floorXWall + (1.0 - weight) * posX;
			local currentFloorY = weight * floorYWall + (1.0 - weight) * posY;

			local floorTexX, floorTexY;
			floorTexX = math.floor(currentFloorX * imageWidth) % imageWidth;
			floorTexY = math.floor(currentFloorY * imageHeight) % imageHeight;

			--floor
			--buffer[y][x] = (texture[3][texWidth * floorTexY + floorTexX] >> 1) & 8355711;

			if floorTexX and floorTexY then
				print("tex",floorTexX, floorTexY)
				print(imageHeight, imageWidth)
				love.graphics.setColor(imageData:getPixel(floorTexX, floorTexY))
				love.graphics.points(x, y)
			end
			--ceiling (symmetrical!)
			--buffer[h - y][x] = texture[6][texWidth * floorTexY + floorTexX];
		end
	end

	for x = 0, w, 1 do
		for i = 20, 0, -1 do
			if  floors[x] and floors[x][i] then
				quad = love.graphics.newQuad(floorTextureX[x][i] % imageWidth, 0, 1, imageHeight, imageWidth, imageHeight)
				love.graphics.draw(floors[x][i], quad, x, drawFloorLineStart[x][i], 0, 1, (drawFloorLineEnd[x][i] - drawFloorLineStart[x][i] + 1) / imageHeight, 0, 0)
			end
		end
	end


	for x = 0, w, 1 do
		for i = 20, 0, -1 do
			if  entities[x] and entities[x][i] then
				if entityTextureX[x][i] then
					quad = love.graphics.newQuad(entityTextureX[x][i] % imageWidth, 0, 1, imageHeight, imageWidth, imageHeight)
					love.graphics.draw(entities[x][i], quad, x, drawEntityLineStart[x][i], 0, 1, (drawEntityLineEnd[x][i] - drawEntityLineStart[x][i] + 1) / imageHeight, 0, 0)
				end
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
