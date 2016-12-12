local id = 0
return function(x,y, tex)
 	local agent = {}
 	id =  id + 1
 	agent.name       ="ceiling".. id
	agent.position   = {x=x, y=y}
	agent.ceiling = {tex=tex}
	return agent
end
