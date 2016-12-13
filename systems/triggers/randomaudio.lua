local system = {}
local notes = {}
system.name = "rotationaudio"
system.update = function(dt)
	for k,v in pairs(system.targets) do
		local c = get_actuals(v)
		if math.random()*2 < dt then
			print("FST")
		  if math.random()*2 < v.random.chance then
		  	print("HERE")
			add_effect(game.entity_definitions.sound(v.triggered.source))
			v.random.already = 0
		end
	end
	end
end

system.register = function(entity)
	entity.random.already = 0
end

system.unregister = function(entity)
end

system.requirements = {triggered=true, random=true}

return system
