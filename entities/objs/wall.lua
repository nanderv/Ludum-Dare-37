local id = 0
return function(x,y, tex)
 	local agent = {}
 	id =  id + 1
 	agent.name       ="wall".. id
	agent.position   = {x=x, y=y}
	agent.wall = {tex=tex}
	return agent
end
