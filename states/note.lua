local minfps = 1000
local ctx = GS.new()
local aa = false
function ctx:enter(from)
  ctx.from = from -- record previous state
  aa = false

end
function ctx:update(dt)
  if love.keyboard.isDown(CONTROLS.ACTION_ONE) then
    if aa then
      aa = false
      GS.pop()
    end
  else
    aa = true
  end
end


function ctx:draw()
  ctx.from:draw()
  local width = love.graphics.getWidth()
  local height = love.graphics.getHeight()
  love.graphics.setColor(5, 5, 5,180)
  love.graphics.rectangle("fill",0,0,width,height)
  love.graphics.setColor(255,255,255,255)
  love.graphics.draw(get_image(note_image),width/2-(get_image(note_image):getWidth()/2),height/2-(get_image(note_image):getHeight()/1.8))
end


return ctx
