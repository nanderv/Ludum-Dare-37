local id = 0
return function(x,y, rot)
 	local agent = {}
 	id =  id + 1
 	agent.name       ="player"
	agent.position   = {x=x, y=y, rotation=rot,speed = 100}

	agent.basic_move = {true}
	agent.speed   = {speed = 100}

	return agent
end