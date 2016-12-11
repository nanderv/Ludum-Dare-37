local system = {}
local notes = {}
system.name = "randomaudio"
system.update = function(dt)
  local note =  notes[math.floor(game.entities.player.position.posX)..":"..math.floor(game.entities.player.position.posY)]
  if love.keyboard.isDown(CONTROLS.ACTION_ONE)  and  note then
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
