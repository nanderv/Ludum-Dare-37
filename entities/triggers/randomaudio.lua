local id = 0
return function(chance, source_name)
  local agent = {}
  id = id + 1
  agent.name ="random"
  agent.random = {chance = chance}
  agent.id = "random"..id
  agent.triggered = {source_name = source_name}
  return agent
end
