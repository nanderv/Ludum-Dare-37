local id = 0

function add_walls(ccs, list, zone)
	for k,v in pairs(ccs) do
		print("HOI")
			add_entity(game.entity_definitions.objs.wall(v[1], v[2], v[3]), list, zone)
	end
end
function add_floors_ceilings(ccs, list, zone)
	for k,v in pairs(ccs) do
		print("HOI")
			add_entity(game.entity_definitions.objs.floor(v[1], v[2], v[3]), list, zone)
			add_entity(game.entity_definitions.objs.ceiling(v[1], v[2], v[4]), list, zone)

	end
end



return function(x,y, tex)
 	local agent = {}
 	id =  id + 1
 	agent.name       ="wall".. id
	agent.position   = {x=x, y=y}
	agent.wall = {tex=tex}
	return agent
end
