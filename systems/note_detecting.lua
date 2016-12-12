local system = {}
local notes = {}
local aa = false
system.name = "note_detecting"
system.update = function(dt)

  local note =  notes[math.floor(game.entities.player.position.posX)..":"..math.floor(game.entities.player.position.posY)]
  if love.keyboard.isDown(CONTROLS.ACTION_ONE)  and  note then
    if aa then
      aa = false
      print(note.note.image)
      note_image = note.note.image
      GS.push(core.states.note)
    end
  else
    aa = true
  end
end

function system.draw()
  local note =  notes[math.floor(game.entities.player.position.posX)..":"..math.floor(game.entities.player.position.posY)]
  	if   note then
  		love.graphics.print("Open note (Press E)",200,400)
  	end

end

system.register = function(entity)
  entity.position.posX = entity.position.x
  entity.position.posY = entity.position.y
  print(entity.position.x,entity.position.y,"A", entity.name, entity.note.image)
  local c = get_actuals(entity)
  print(c, c.x, c.y)
  notes[c.x..":" .. c.y] = entity
end

system.unregister = function(entity)
  entity.position.posX = entity.position.x
  entity.position.posY = entity.position.y
  print(entity.position.x,entity.position.y,"A")
  local c = get_actuals(entity)
  print(c)
  notes[c.x..":" .. c.y] = nil
end

system.requirements = {note=true, position=true}

return system
