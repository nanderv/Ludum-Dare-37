local id = 0
return function(x,y, side, top, height)
 	local agent = {}
 	id =  id + 1
 	agent.name       ="physical_object".. id
	agent.position   = {x=x, y=y}
	agent.physical = {side=side, top=top, height=height}
	return agent
end
