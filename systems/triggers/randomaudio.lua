local system = {}
local notes = {}
system.name = "rotationaudio"
system.update = function(dt)
	for k,v in pairs(system.targets) do
		local c = get_actuals(v)
		if math.random()> dt * v.random.chance then
			core.entity.add(game.entity_definitions.sound(source))
			v.random.chance = v.random.chance * 0.7
		end
	end
end

system.register = function(entity)
end

system.unregister = function(entity)
end

system.requirements = {triggered=true, random=true}

return system
