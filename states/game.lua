local minfps = 1000
local ctx = GS.new()


function ctx:enter(dt)
    GS.push(core.states.loading)
    love.mouse.setGrabbed(true)
end


function get_nil()
    return "nil"
end


function ctx:update(dt)
  --GS.push(core.states.note)
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
    love.graphics.print("Current FPS: "..tostring(fps).. "MIN".. minfps, 10, 10)
end


function ctx:leave()
    love.mouse.setGrabbed(false)
    print('leaving')
end
return ctx
