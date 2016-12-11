local quickie = require 'zz_lib.quickie'
local ctx = GS.new()

function ctx:enter()

end

function ctx:leave()

end

function ctx:update(dt)
  button = quickie.Button("TEST",{},10,10,50,50)
end

function ctx:draw()
  quickie.draw()
end

function ctx:textinput(t)
  quickie.textinput(t)
end

function ctx:keypressed(key)
  quickie.keypressed(key)
end

return ctx
