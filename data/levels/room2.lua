
all_regions["room2_t2"] =  {
	begin_position     = {x=0,y=0, rot=0},
	end_position       = {x=4,y=-5, rot=1},
	no_return_position = {x=4, y=-2},
	next_room 		   = "room2",
	func               = function(list, x,y,rot, entity)
		--a
		local bRot = (rot+ entity.zone.begin_position.rot)%4
		local bX   = x - entity.zone.begin_position.x
		local bY   = y - entity.zone.begin_position.y
		entity.zone.rendered_at = {x = bX, y = bY, rot = bRot}
		load_walls(		{

		},list, bX, bY, bRot )
		return (rot + all_regions["hallway1"].end_position.rot)%4
	end}

all_regions["room2_t1"] =  {
	begin_position     = {x=0,y=0, rot=0},
	end_position       = {x=4,y=5, rot=3},
	no_return_position = {x=4, y=2},
	next_room 		   = "room2_t2",
	func               = function(list, x,y,rot, entity)
		--a
		local bRot = (rot+ entity.zone.begin_position.rot)%4
		local bX   = x - entity.zone.begin_position.x
		local bY   = y - entity.zone.begin_position.y
		core.entity.add(game.entity_definitions.fadeto(2,8,8,0.7))

		entity.zone.rendered_at = {x = bX, y = bY, rot = bRot}
		load_walls(		{


		},list, bX, bY, bRot )

		return (rot+ all_regions["hallway2"].end_position.rot)%4
	end}


all_regions["room2"] =  {
	begin_position     = {x=0,y=0, rot=0},
	end_position       = {x=4,y=0, rot=0},
	no_return_position = {x=10000, y=10000},
	next_room 		   = "room2_t1",
	func               = function(list, x,y,rot, entity)
	local bRot = (rot+ entity.zone.begin_position.rot)%4
		local bX   = x - entity.zone.begin_position.x
		local bY   = y - entity.zone.begin_position.y

		entity.zone.rendered_at = {x = bX, y = bY, rot = bRot}
		load_walls(		{

		},list, bX, bY, bRot )

		return (rot+ all_regions["room1"].end_position.rot)%4
end}
