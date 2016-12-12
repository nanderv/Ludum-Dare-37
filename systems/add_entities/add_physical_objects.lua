local system = {}
--game___objs.wall = {}
--game___objs.ceiling = {}
--game___objs.floor = {}
--game___objs.entity = {}
--game___objs.physical_side = {}
--game___objs.physical_top = {}

system.name = "add_floor"
system.update = function(dt) end

system.register = function(e)
	game___objs.physical_side[e.position.x..":"..e.position.y] = e.physical.side
	game___objs.physical_top[e.position.x..":"..e.position.y] = e.physical.top
end

system.unregister = function(e)
	game___objs.physical_side[e.position.x..":"..e.position.y] = nil
	game___objs.physical_top[e.position.x..":"..e.position.y] = nil

end

system.requirements = {position=true, physical=true}

return system
