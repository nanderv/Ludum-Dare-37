local id = 0
return function(x,y, side, top)
 	local agent = {}
 	id =  id + 1
 	agent.name       ="floor".. id
	agent.position   = {x=x, y=y}
	agent.physical = {side=side, top=top}
	return agent
end
