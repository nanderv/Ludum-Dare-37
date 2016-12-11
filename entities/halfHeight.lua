local id = 0
return function(x,y, entity)
 	local agent = {}
 	id =  id + 1
 	agent.name       ="halfHeight".. id
	agent.position   = {x=x, y=y}
	agent.entity = entity
	return agent
end
