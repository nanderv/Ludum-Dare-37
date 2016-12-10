local ctx = GS.new()

function ctx:enter(dt)
  love.mouse.setGrabbed(true)
  print('entering pause')
  ctx.MENU_BUTTONS = {}
  ctx:addButton("Resume Game", function () GS.pop() end )
  ctx:addButton("Quit Game", function () love.event.quit()end )
end

function ctx:update(dt)
  local x, y = love.mouse.getPosition()
  for i, v in ipairs(ctx.MENU_BUTTONS) do
    if (ctx:mouseOverButton(x,y,v["x"],v["y"],v["width"],v["height"])) then
      v["opacity"] = 255
    else
      v["opacity"] = 180
    end
  end
end

function ctx:draw()
  -- love.graphics.setColor(50,50,50,200)
  -- love.graphics.rectangle("fill", 100,love.graphics.getHeight()/2,love.graphics.getWidth() - 200,love.graphics.getHeight()/2)
  for i,v in ipairs(ctx.MENU_BUTTONS) do
    love.graphics.setColor(200,100,100,v["opacity"])
    love.graphics.rectangle("fill", v["x"],v["y"],v["width"],v["height"])
    love.graphics.setColor(200,200,200,255)
    love.graphics.print(v["label"], v["x"]+130,v["y"]+15)
  end
end

function ctx:leave()
  print('leaving pause')
end

function ctx:mouseOverButton(pointX,pointY,rectX,rectY,rectWidth,rectHeight)
  return pointX > rectX and pointY > rectY and pointX < rectX + rectWidth and pointY < rectY + rectHeight
end

function ctx:addButton(label,func)
  ctx.MENU_BUTTONS[#ctx.MENU_BUTTONS + 1] = {
    label = label,
    x = love.graphics.getWidth()/2 - 340/2,
    y = 250 + (#ctx.MENU_BUTTONS * 50),
    width = 340,
    height = 40,
    opacity = 100,
    func = func
  }
end

function ctx:mousepressed()
  local x, y = love.mouse.getPosition()
  for i, v in ipairs(ctx.MENU_BUTTONS) do
    if (ctx:mouseOverButton(x,y,v["x"],v["y"],v["width"],v["height"])) then
      v["func"]()
    end
  end
end

return ctx
