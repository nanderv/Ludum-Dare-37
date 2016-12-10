local minfps = 1000
local ctx = GS.new()

function ctx:enter(from)
  self.from = from -- record previous state

end
function ctx:update(dt)
  if love.keyboard.isDown("f") then
    print(" HOI" )
    GS.pop()
  end
end


function ctx:draw()
  self.from:draw()
  local width = love.graphics.getWidth()
  local height = love.graphics.getHeight()
  love.graphics.setColor(5, 5, 5,180)
  love.graphics.rectangle("fill",0,0,width,height)
  love.graphics.setColor(255,255,255,255)
  love.graphics.draw(get_image("videogame_note1"),width/2-(get_image("videogame_note1"):getWidth()/2),height/2-(get_image("videogame_note1"):getHeight()/1.8))
  love.graphics.print("HOIHOIHOI",1,1)
  love.graphics.draw(get_image("wood"),width/2-(get_image("wood"):getWidth()/2),height/1.14)
end


return ctx
