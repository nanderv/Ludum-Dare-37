local system = {}
local notes = {}
system.name = "musicmixer"
system.tracks = {}
system.tracks[1] = love.audio.newSource("assets/music/room base.ogg")
system.tracks[1]:setLooping(true)
system.tracks[2] = love.audio.newSource("assets/music/hallway base.ogg")
system.tracks[2]:setVolume(0)
system.tracks[2]:setLooping(true)
system.tracks[3] = love.audio.newSource("assets/music/hallway 1.ogg")
system.tracks[3]:setVolume(0)
system.tracks[3]:setLooping(true)
--system.tracks[3]:setVolume(0)
system.tracks[4] = love.audio.newSource("assets/music/hallway 2.ogg")
system.tracks[4]:setVolume(0)
system.tracks[4]:setLooping(true)
--system.tracks[4]:setVolume(0)
system.tracks[5] = love.audio.newSource("assets/music/hallway 3.ogg")
system.tracks[5]:setVolume(0)
system.tracks[5]:setLooping(true)
--system.tracks[5]:setVolume(0)
function add_fade(entity)
	print( entity.mix_effect.to, system.to_track, system.current_track)
	if not (system.current_track == entity.mix_effect.to) and not (system.to_track == entity.mix_effect.to) then
		print("add_fade")
		core.entity.add(entity)
	end
end

system.to_track = 1
local playing = false
system.current_track = 1
local volume = 1
local fadefail = false
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
			print(v.id, system.current_track, v.mix_effect.to, volume, math.max(volume, 0), math.min(1,(1-v.mix_effect.cross)-volume))
			if volume <= -v.mix_effect.cross then
				volume = 1
				
				system.tracks[system.current_track]:setVolume(0)
				system.tracks[v.mix_effect.to]:setVolume(1)

				system.current_track = v.mix_effect.to
				print("END OF EFFECT")

				core.entity.remove(v)
			else
				system.tracks[system.current_track]:setVolume(math.max(volume, 0))
				system.tracks[v.mix_effect.to]:setVolume(math.min(1,(1-v.mix_effect.cross)-volume))
			end



		end
	return
	end
end

system.register = function(entity)
	print("STARTED CROSSOVER FROM ".. system.current_track .. "TO"..entity.mix_effect.to)
	system.to_track = entity.mix_effect.to
	print("HIER")
	if volume ~=  1 then
		volume = (1-entity.mix_effect.cross)-volume
		fadefail = true
	end
	if entity.mix_effect.to == 1 then
		system.tracks[1]:stop()
		system.tracks[1]:play()
	end
	-- assumes only one effect is in use
	for k,v in pairs(system.targets) do
		if v ~= entity then
			v.mix_effect.down = 0.1
		end
	end
end

system.unregister = function(entity)
end

system.requirements = {mix_effect=true}

return system
