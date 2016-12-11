local system = {}
local notes = {}
system.name = "musicmixer"
system.tracks = {}
system.tracks[1] = love.audio.newSource("assets/music/room base.ogg")
system.tracks[1]:setLooping(true)
system.tracks[2] = love.audio.newSource("assets/music/hallway base.ogg")
system.tracks[2]:setVolume(0)
system.tracks[2]:setLooping(true)
system.tracks[3] = nil
--system.tracks[3]:setVolume(0)
system.tracks[4] = nil
--system.tracks[4]:setVolume(0)
system.tracks[5] = nil
--system.tracks[5]:setVolume(0)


	
local playing = false
local current_track = 1
local volume = 1
local up_or_down = "down"
system.update = function(dt)
	if not playing then
		system.tracks[1]:play()
		system.tracks[2]:play()
		playing = true
	end
	for k,v in pairs(system.targets) do

		if up_or_down == "down" then
			volume = volume - dt / v.mix_effect.down
			print(volume)
			if volume <= -v.mix_effect.cross then
				volume = 0
				system.tracks[current_track]:setVolume(0)
				system.tracks[v.mix_effect.to]:setVolume(1)

				up_or_down = "up"
				--system.tracks[current_track]:stop()
				current_track = v.mix_effect.to
				--system.tracks[current_track]:play()
				core.entity.remove(v)


			else
				system.tracks[current_track]:setVolume(math.min(volume,1))
				system.tracks[v.mix_effect.to]:setVolume(math.max(0,(1-v.mix_effect.cross)-volume))
			end



		end

	end
end

system.register = function(entity)
	if current_track == entity.mix_effect.to then
		core.entity.remove(entity)
		return
	end
	-- assumes only one effect is in use
	for k,v in pairs(system.targets) do
		core.entity.remove(v)
	end
end

system.unregister = function(entity)
end

system.requirements = {mix_effect=true}

return system
