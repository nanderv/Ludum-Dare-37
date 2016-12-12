local id = 0

-- Chance in 1/ 2^10
return function(chance, source_name)
  local agent = {}
  id = id + 1
  agent.name ="random"
  agent.random = {chance = chance}
  agent.id = "random"..id
  agent.triggered = {source = source_name}
  return agent
end
