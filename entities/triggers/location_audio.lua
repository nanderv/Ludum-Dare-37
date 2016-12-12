local id = 0
return function(x,y, source_name)
  local agent = {}
  id = id + 1
  agent.name ="location"
  agent.position = {x=x, y=y}
  agent.id = "location"..id
  agent.triggered = {source = source_name}
  return agent
end
