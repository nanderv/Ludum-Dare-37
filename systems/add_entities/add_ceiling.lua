local system = {}
--game___objs.wall = {}
--game___objs.ceiling = {}
--game___objs.floor = {}
--game___objs.entity = {}
--game___objs.physical_side = {}
--game___objs.physical_top = {}

system.name = "add_ceiling"
system.update = function(dt) end

system.register = function(e)
	game___objs.ceiling[e.position.x..":"..e.position.y] = e.ceiling.tex
end

system.unregister = function(e)
	game___objs.ceiling[e.position.x..":"..e.position.y] = nil
end

system.requirements = {position=true, ceiling=true}

return system
