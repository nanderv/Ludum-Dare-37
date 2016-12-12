local id = 0
return function(source)
  local agent = {}
  id = id + 1
  agent.name ="player"
  agent.SFX = {source = source}
  return agent
end
