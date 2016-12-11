local id = 0
return function(x, y, to, down, cross)
  local agent = {}
  id = id + 1
  agent.name ="location_fade"
  agent.fade = {to = to, cross = cross, down = down}
  agent.id = "location_fade"..id
  agent.position = {x=x,y=y}
  return agent
end
