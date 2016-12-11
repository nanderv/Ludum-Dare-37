local id = 0
return function(x,y, top, bottom, left, right, floor, entity)
 	local agent = {}
 	print(left,right)
 	id =  id + 1
 	agent.name       ="wall".. id
	agent.position   = {x=x, y=y}
	agent.walls = {top=top, bottom = bottom, left = left, right = right, floor = floor, entity = entity}
	return agent
end
