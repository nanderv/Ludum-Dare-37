all_regions = {}
local     function pack(...)
        return arg
    end
function load_walls(wall_list, list, bx, by, brot)
	print(list, brot)
	for k,v in pairs(wall_list) do

		

		local ent = game.entity_definitions.wall.base_wall(v[1],v[2],v[3],v[4],v[5],v[6],v[7],v[8])
		local axx, bxx =  ent.position.x, ent.position.y
		if brot == 1 then
			ent.position.x, ent.position.y  = ent.position.y, - ent.position.x
			ent.walls.top, ent.walls.right, ent.walls.bottom, ent.walls.left = ent.walls.left, ent.walls.top, ent.walls.right, ent.walls.bottom
		end
		if brot == 2 then
			ent.position.x, ent.position.y  = -ent.position.x, - ent.position.y
			ent.walls.top, ent.walls.right, ent.walls.bottom, ent.walls.left =  ent.walls.bottom, ent.walls.left, ent.walls.top, ent.walls.right
		end
		if brot == 3 then
			ent.position.x, ent.position.y  = -ent.position.y,  ent.position.x
			ent.walls.top, ent.walls.right, ent.walls.bottom, ent.walls.left =  ent.walls.right, ent.walls.bottom, ent.walls.left, ent.walls.top
		end
		local ax, ay = ent.position.x, ent.position.y

		ent.position.x, ent.position.y = ent.position.x+ bx, ent.position.y+ by
		list[#list+1] = ent
		core.entity.add(ent)
	end

end
local function get_actual_coords(rel, pos, rev)
		local x,y = pos.x,pos.y
			if rel.rot == 1 then
				x,y = y, -x
			end
			if rel.rot == 2 then
				x,y = -x, -y
			end
			if rel.rot == 3 then
				x,y =  -y, x
			end
			if not rev then
				return x + rel.x, y + rel.y
			else

				return x - rel.x, y - rel.y
			end
end
local system = {}

local l_entities = {}
local current_zone = nil
local next_zone = nil
local prev_zone = nil
local old_zone = nil
local detected_zone = nil
system.name = "zoneloader"
system.update = function(dt)
	
	if current_zone then
		
		local a,b = get_actual_coords(current_zone.zone.rendered_at, current_zone.zone.no_return_position)

		local x, y = math.floor(game.entities.player.position.posX), math.floor(game.entities.player.position.posY)
		if  a == x and b == y and detected_zone ~= current_zone then
			detected_zone = current_zone
			if prev_zone then
				core.entity.remove(prev_zone)
			end
			if old_zone then
				core.entity.remove(old_zone)
			end
			prev_zone = game.entity_definitions.zone("room1")
			prev_zone.zone.is_prev = true
			core.entity.add(prev_zone)

		end
		local a,b = get_actual_coords(current_zone.zone.rendered_at, current_zone.zone.end_position)

		if a == x and b == y then
			old_zone = prev_zone
			prev_zone = current_zone
			current_zone = next_zone
		  	next_zone = game.entity_definitions.zone(current_zone.zone.next_room)
  			core.entity.add(next_zone)

		end


	end
	
end

system.register = function(entity)
  -- Load zone, after that set previous zone with respect to current zone.
  if not current_zone then
  	current_zone = entity
  	next_zone = game.entity_definitions.zone(entity.zone.next_room)
  	core.entity.add(next_zone)
  	l_entities[entity] = {}
  	all_regions[entity.zone.textfile].func(l_entities[entity], 0,0,0, entity)
  else
  l_entities[entity] = {}
  if not current_zone.zone.rendered_at then
  	current_zone.zone.rendered_at = {x=0,y=0, rot=0}
  	print("OOPS")
  end
  if entity.zone.is_prev then
  	print(current_zone.name)
  	local xz,yz = 1- entity.zone.end_position.x,- entity.zone.end_position.y
	local xx, yy = get_actual_coords(current_zone.zone.rendered_at, {x=xz,y=yz})
    all_regions[entity.zone.textfile].func(l_entities[entity], xx, yy, current_zone.zone.rendered_at.rot, entity)
  else
    local xx, yy = get_actual_coords(current_zone.zone.rendered_at, current_zone.zone.end_position)
    all_regions[entity.zone.textfile].func(l_entities[entity], xx, yy, current_zone.zone.rendered_at.rot+ current_zone.zone.end_position.rot, entity)
end
end
end

system.unregister = function(entity)
	for k,v in pairs(l_entities[entity]) do
		core.entity.remove(v)
	end
end

system.requirements = {zone=true}

return system
