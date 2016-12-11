
local ctx = GS.new()

function ctx:enter(from)
  ctx.from = from
  ctx.quickie = require 'zz_lib.quickie'
  love.mouse.setVisible(true)
  love.mouse.setGrabbed(false)
  print('entering pause')
  ctx.MENU_BUTTONS = {
    {label = "Resume Game", func = ctx.exit },
    {label = "Settings", func = function () GS.push(core.states.settings) end },
    {label = "Restart Game", func = function () GS.switch(core.states.main)end },
    {label = "Quit Game", func = function () love.event.quit()end },
  }
end

function ctx:leave()
  love.mouse.setVisible(false)
  love.mouse.setGrabbed(true)
  package.loaded['zz_lib.quickie'] = nil
  print('leaving pause')
end

function ctx:update(dt)
  for i, v in ipairs(ctx.MENU_BUTTONS) do
    local x, y, dx, dy = ctx.getPosition(i)
    ctx.button = ctx.quickie.Button(v.label, x,y,dx,dy)
    if ctx.button.hit then
      v.func(ctx)
    end
  end
end

function ctx:draw()
  ctx.from:draw()
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

function ctx:exit()
  ctx.button.hit = false
  GS.pop()
end

return ctx
