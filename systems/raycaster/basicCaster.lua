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
local posX = 22
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

local wood  = love.graphics.newImage('assets/wood.png')
local woodHeight = wood:getHeight()
local woodWidth  = wood:getWidth()

local drawScreenLineStart = {}
local drawScreenLineEnd = {}
local drawScreenLineColor = {}

local drawBuffer = {}

for y = 0, h, 1 do
	drawBuffer[y] = {}
end

function system.hasWall(x,y)
	return map[x][y]
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

			if (map[mapX][mapY] > 0) then
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

function system.draw()
	for x = 0, w, 1 do
		quad = love.graphics.newQuad(x % brickWidth, 0, 1, brickHeight, brickWidth, brickHeight)
		love.graphics.draw(brick, quad, x, drawScreenLineStart[x], 0, 1, (drawScreenLineEnd[x] - drawScreenLineStart[x] + 1) / brickHeight,  0, 0)
	end
	--FLOOR
	local floorXWall, floorYWall --x, y position of the floor texel at the bottom of the wall

	--4 different wall directions possible
 	if side == 0 and rayDirX > 0 then
	   floorXWall = mapX;
	   floorYWall = mapY + wallX
	else if(side == 0 and rayDirX < 0) then

	   floorXWall = mapX + 1.0;
	   floorYWall = mapY + wallX;
   	else if(side == 1 and rayDirY > 0) then
	   floorXWall = mapX + wallX;
	   floorYWall = mapY;
	 else
	   floorXWall = mapX + wallX;
	   floorYWall = mapY + 1.0;
   	end
	local distWall, distPlayer, currentDist;

	distWall = perpWallDist;
	distPlayer = 0.0;

	 if (drawEnd < 0) then
		  drawEnd = h; --becomes < 0 when the integer overflows
	  end

	 --draw the floor from drawEnd to the bottom of the screen
	 for y = drawEnd + 1, h, y++ do
	   currentDist = h / (2.0 * y - h); //you could make a small lookup table for this instead

	   local weight = (currentDist - distPlayer) / (distWall - distPlayer);

	   local currentFloorX = weight * floorXWall + (1.0 - weight) * posX;
	   local currentFloorY = weight * floorYWall + (1.0 - weight) * posY;

	   local floorTexX, floorTexY;
	   floorTexX = math.floor(currentFloorX * texWidth) % texWidth;
	   floorTexY = math.floor(currentFloorY * texHeight) % texHeight;

	   --floor
	   buffer[y][x] = (texture[3][texWidth * floorTexY + floorTexX] >> 1) & 8355711;

	   --ceiling (symmetrical!)
	   buffer[h - y][x] = texture[6][texWidth * floorTexY + floorTexX];
   	end
	love.graphics.print("FPS: "..tostring(love.timer.getFPS( )), 10, 10, 0, 3)
end

function love.keypressed(key, unicode)
     if key == " " then love.graphics.toggleFullscreen() end

end
system.requirements = {position = true, image = true, isWall = true}

return system
