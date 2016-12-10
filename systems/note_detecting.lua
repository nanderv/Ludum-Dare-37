local system = {}
local notes = {}
system.name = "note_detecting"
system.update = function(dt)
  local note =  notes[math.floor(game.entities.player.position.posX)..":"..math.floor(game.entities.player.position.posY)]
  if love.keyboard.isDown("e")  and  note then
    note_image = note.note.image
    GS.push(core.states.note)
  end
end

system.register = function(entity)
  notes[entity.position.x..":" .. entity.position.y] = entity
end

system.unregister = function(entity)
  notes[entity.position.x..":" .. entity.position.y] = nil
end

system.requirements = {note=true, position=true}

return system
