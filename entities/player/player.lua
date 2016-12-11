local id = 0
return function(x,y, rot)
  local agent = {}
  id = id + 1
  agent.name ="player"
  agent.position = {posX=x, posY=y, planeX=0,planeY=0.66,dirX=-1,dirY=0}
  agent.id = "player"
  agent.basic_move = {true}
  agent.speed = {movement = 2.0, mouse_rotate = 0.7, keyboard_rotate = 10,  strafe = 2.0}
  return agent
end
