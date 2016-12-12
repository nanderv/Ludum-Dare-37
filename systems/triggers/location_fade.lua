local system = {}
local notes = {}
system.name = "location_fade"
system.update = function(dt)
	for k,v in pairs(system.targets) do
		local c = get_actuals(v)
		if c.x == math.floor(game.entities.player.position.posX) and c.y == math.floor(game.entities.player.position.posY) then
			print("ADD FADE")
			add_fade(game.entity_definitions.fadeto(v.fade.to,v.fade.down,v.fade.down,v.fade.cross))



		end
	end
end

system.register = function(entity)
end

system.unregister = function(entity)
end

system.requirements = {fade=true, position=true}

return system
