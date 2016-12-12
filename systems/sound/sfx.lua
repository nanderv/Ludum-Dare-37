local system = {}
local notes = {}
system.playing_names = {}

system.sources = {}
system.sources["notanywhere1"] = "assets/whispers/notanywhere1.ogg"
system.sources["staywithus1"]  = "assets/whispers/staywithus1.ogg"

system.name = "SFX"

function add_effect(entity)
		if entity.SFX.source and (not system.playing_names[v] or  system.playing_names[v] == 0 ) then
			print("PLAYING")
			core.entity.add(entity)
		else
			print("FAILED")
		end
end

system.update = function(dt)
	for k,v in pairs(system.targets) do
		system.playing_names[v] = system.playing_names[v]  - dt
		if system.playing_names[v]  < 0 then
			core.entity.remove(v)
			system.playing_names[v]  = 0
		end

	end

end

system.register = function(entity)
		print(entity.SFX.source)
		love.audio.newSource(system.sources[entity.SFX.source],  "static"):play()
		system.playing_names[entity] = 6

end

system.unregister = function(entity)
end

system.requirements = {SFX=true}

return system
