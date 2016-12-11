local ctx = GS.new()

function ctx:enter()
  ctx.quickie = require 'zz_lib.quickie'
  love.mouse.setVisible(true)
  love.mouse.setGrabbed(false)
  print('entering menu')
  ctx.MENU_BUTTONS = {
    {label = "Start Game", func = function () GS.switch(core.states.main)end },
    {label = "Settings", func = function() end },
    {label = "Quit Game", func = function () love.event.quit()end }
  }
end

function ctx:leave()
  package.loaded['zz_lib.quickie'] = nil
  print('leaving menu')
end

function ctx:update(dt)
  for i, v in ipairs(ctx.MENU_BUTTONS) do
    local x, y, dx, dy = ctx.getPosition(i)
    local button = ctx.quickie.Button(v.label, x,y,dx,dy)
    if button.hit then
      if v.label == "Settings" then
        v.label = "(please start Game first)"
      else
        v.func()
      end
    end
  end
end

function ctx:draw()
  ctx.quickie.draw()
end

function ctx.getPosition(index)
  local width = 340
  local height = 50
  local v_gap = 20
  local x = love.graphics.getWidth()/2 - width/2
  local y = 250 + (index * height) + (index * v_gap)
  return x, y, width, height
end

return ctx
