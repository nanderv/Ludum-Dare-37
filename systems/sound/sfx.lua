local system = {}
local notes = {}
system.playing_names = {}

system.sources = {}

system.name = "SFX"

	
system.update = function(dt)
	for k,v in pairs(system.targets) do
		system.playing_names[v.SFX.source] = system.playing_names[v.SFX.source]  - dt
		if system.playing_names[v.SFX.source]  < 0 then
			core.entity.remove(v)
			system.playing_names[v.SFX.source]  = nil
		end
	end

end

system.register = function(entity)
	
	if not system.playing_names[entity.SFX.source] then
		system.sources[entity.SFX.source]:stop()
		system.sources[entity.SFX.source]:play()
		system.playing_names[entity.SFX.source] = 3
	else
		core.entity.remove(entity)
	end
end

system.unregister = function(entity)
end

system.requirements = {SFX=true}

return system
