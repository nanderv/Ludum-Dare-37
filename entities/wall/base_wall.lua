local id = 0
return function(x,y, url)
 	local agent = {}
 	id =  id + 1
 	agent.name       ="wall".. id
	agent.position   = {x=x, y=y, rotation=rot,speed = 100}
	agent.image = {url=""}
	return agent
end