local system = {}
--game___objs.wall = {}
--game___objs.ceiling = {}
--game___objs.floor = {}
--game___objs.entity = {}
--game___objs.physical_side = {}
--game___objs.physical_top = {}

system.name = "add_wall"
system.update = function(dt) end

system.register = function(e)
	game___objs.wall[e.position.x..":"..e.position.y] = e.wall.tex
end

system.unregister = function(e)
	game___objs.wall[e.position.x..":"..e.position.y] = nil
end

system.requirements = {position=true, wall=true}

return system
