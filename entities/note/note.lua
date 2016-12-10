local id = 0
return function(x,y, image)
  local agent = {}
  id = id + 1
  agent.name ="note".. id
  agent.position ={x=x, y=y}
  agent.note = {image = image}
  return agent
end
