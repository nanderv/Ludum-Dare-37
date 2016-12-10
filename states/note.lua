local minfps = 1000
local ctx = GS.new()

function ctx:enter(from)
  self.from = from -- record previous state

end
function ctx:update(dt)
  
  if love.keyboard.isDown("e") then
    print(" HOI" )
    GS.pop()
  end
end


function ctx:draw()
  self.from:draw()
  love.graphics.print("HOIHOIHOI",1,1)
end


return ctx
