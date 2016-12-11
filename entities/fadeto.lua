local id = 0
return function(to, down, up, cross)
  local agent = {}
  id = id + 1
  agent.name ="player"
  agent.mix_effect = {to=to, down=down, up=up,cross=cross}
  return agent
end
