local system = {}
local notes = {}
system.name = "locationaudio"
system.update = function(dt)
	for k,v in pairs(system.targets) do
		local c = get_actuals(v)
		if c.x == math.floor(game.entities.player.position.posX) and c.y == math.floor(game.entities.player.position.posY) then
			add_effect(game.entity_definitions.sound(v.triggered.source))
			core.entity.remove(v)
		end
	end
end

system.register = function(entity)
end

system.unregister = function(entity)
end

system.requirements = {triggered=true, position=true}

return system
