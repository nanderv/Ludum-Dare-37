local minfps = 1000
local ctx = GS.new()
local LightWorld = require "zz_lib.light_world" --the path to where light_world is (in this repo "lib")
lightWorld = LightWorld({
    ambient = {30,30,30}, --the general ambient light in the environment
  })

function ctx:enter(dt)
  GS.push(core.states.loading)
  love.mouse.setVisible(false)
  love.mouse.setGrabbed(true)
  print('entering game')
end

function ctx:update(dt)
  if love.keyboard.isDown(CONTROLS.PAUSE) or love.keyboard.isDown(CONTROLS.ESCAPE) then
    GS.push(core.states.pause)
  end

  for k,v in core.system.orderedPairs(game.system_categories.update) do
    v.update(dt)
  end
end

function ctx:draw()
  love.graphics.push()
  for k,v in core.system.orderedPairs(game.system_categories.draw) do
    v.draw()
  end
  love.graphics.pop()
  for k,v in core.system.orderedPairs(game.system_categories.draw_ui) do
    v.draw_ui()
  end
  -- love.graphics.print("Current FPS: "..tostring(fps).. "MIN".. minfps, 10, 10)
end

function ctx:leave()
  print('leaving game')
end
return ctx
