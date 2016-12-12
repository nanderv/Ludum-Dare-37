local id = 0

function get_data(x,y)
	return {floor=nil,ceiling=nil,entity=nil}
end
return function(x,y, top)
 	local agent = {}
 	print(left,right)
 	id =  id + 1
 	agent.name       ="wallhack".. id
	agent.position   = {x=x, y=y-1}
	agent.walls = get_data(x,y-1)
	agent.walls.top = top
	return agent
end
