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
map={
  {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,2,2,2,2,2,0,0,0,0,3,0,3,0,3,0,0,0,1},
  {1,0,0,0,0,0,2,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,2,0,0,0,2,0,0,0,0,3,0,0,0,3,0,0,0,1},
  {1,0,0,0,0,0,2,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,2,2,0,2,2,0,0,0,0,3,0,3,0,3,0,0,0,1},
  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,4,4,4,4,4,4,4,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,4,0,4,0,0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,4,0,0,0,0,5,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,4,0,4,0,0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,4,0,4,4,4,4,4,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,4,4,4,4,4,4,4,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}
};
local system = {}
system.name = "raycaster"
local posX = -100
local posY = 12
local dirX = -1
local dirY = 0
local planeX = 0
local planeY = 0.66
local w = 800
local h = 600
local brick = love.graphics.newImage('assets/redbrick.png')
local brickHeight = brick:getHeight()
local brickWidth  = brick:getWidth()

local drawScreenLineStart = {}
local drawScreenLineEnd = {}
local drawScreenLineColor = {}

function system.hasWall(x,y)
	return not map[x] or not map[x][y] or map[x][y] > 0
end
function system.update(dt)
for x = 0, w, 1 do
		local cameraX = 2 * x / w - 1
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
		while (hit == 0) do
	
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
			end
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
	end

function system.draw()
	for x = 0, w, 1 do
		quad = love.graphics.newQuad(x % brickWidth, 0, 1, brickHeight, brickWidth, brickHeight)
		love.graphics.draw(brick, quad, x, drawScreenLineStart[x], 0, 1, (drawScreenLineEnd[x] - drawScreenLineStart[x] + 1) / brickHeight,  0, 0)
	end
	love.graphics.print("FPS: "..tostring(love.timer.getFPS( )), 10, 10, 0, 3)
end

function love.keypressed(key, unicode)
     if key == " " then love.graphics.toggleFullscreen() end

end
system.requirements = {position = true, image = true, isWall = true}

return system
