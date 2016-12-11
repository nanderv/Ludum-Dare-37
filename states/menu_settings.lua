local ctx = GS.new()

ctx.shown = false
ctx.res43 = {'640×480', '800×600', '960×720', '1024×768'}
ctx.res169 = {'1024×576', '1152×648', '1280×720', '1366×768', '1600×900', '1920×1080'}

function ctx:enter(from)
  ctx.from = from
  ctx.quickie = require 'zz_lib.quickie'
  love.mouse.setVisible(true)
  love.mouse.setGrabbed(false)
  ctx.keyboard_sensitivity_slider = {value = 5, min = 1, max =10, step = 1}
  ctx.mouse_sensitivity_slider = {value = game.entities.player.speed.keyboard_rotate, min = 1, max = 15, step = 1}
  ctx.fov = {value = 90, min = 65, max = 120, step = 5}
  print('entering settings')
end

function ctx:leave()
  package.loaded['zz_lib.quickie'] = nil
  print('leaving settings')
end

function ctx:update(dt)
  -- Add Things

  -- Screen Resolution
  -- local x, y, dx, dy = ctx.getValuePosition(1)
  -- local resolution = quickie.Button({value = 5, min = 1, max =10, step = 1}, x, y, dx, dy)

  -- Keyboard Rotation
  local x, y, dx, dy = ctx.getKeyPosition(2)
  ctx.quickie.Label("Keyboard turning speed", x, y, dx, dy)
  local x, y, dx, dy = ctx.getValuePosition(2)
  local keyboard_sensitivity = ctx.quickie.Slider(ctx.keyboard_sensitivity_slider, x, y, dx, dy)

  -- Mouse Rotation
  local x, y, dx, dy = ctx.getKeyPosition(3)
  ctx.quickie.Label("Mouse turning speed", x, y, dx, dy)
  local x, y, dx, dy = ctx.getValuePosition(3)
  local mouse_sensitivity = ctx.quickie.Slider(ctx.mouse_sensitivity_slider, x, y, dx, dy)

  -- FOV (joke)
  local x, y, dx, dy = ctx.getKeyPosition(4)
  ctx.quickie.Label("FOV", x, y, dx, dy)
  local x, y, dx, dy = ctx.getValuePosition(4)
  local fov
  if not ctx.shown then
    fov = ctx.quickie.Slider(ctx.fov, x, y, dx, dy)
  else
    ctx.quickie.Label("Sorry TB, not today", x, y, dx, dy)
  end

  -- Back Button
  local x, y, dx, dy = ctx.getValuePosition(5)
  local back = ctx.quickie.Button("Back", x, y, dx, dy)

  -- React to them
  if mouse_sensitivity.changed then
    game.entities.player.speed.keyboard_rotate = ctx.keyboard_sensitivity_slider.value
  end
  if keyboard_sensitivity.changed then
    game.entities.player.speed.mouse_rotate = ctx.mouse_sensitivity_slider.value
  end
  if fov and fov.changed then
    ctx.shown = true
  end
  if back.hit then
    GS.pop()
  end
end

function ctx:draw()
  ctx.from.from:draw()
  ctx.quickie.draw()
end

function ctx.getKeyPosition(index)
  local width = 340
  local height = 50
  local v_gap = 20
  local x = -150 + love.graphics.getWidth()/2 - width/2
  local y = 100 + (index * height) + (index * v_gap)
  return x, y, width, height
end

function ctx.getValuePosition(index)
  local width = 340
  local height = 50
  local v_gap = 20
  local x = 150 + love.graphics.getWidth()/2 - width/2
  local y = 100 + (index * height) + (index * v_gap)
  return x, y, width, height
end

return ctx
