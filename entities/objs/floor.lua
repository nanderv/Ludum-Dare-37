local id = 0
return function(x,y, tex)
 	local agent = {}
 	id =  id + 1
 	agent.name       ="floor".. id
	agent.position   = {x=x, y=y}
	agent.floor = {tex=tex}
	return agent
end
