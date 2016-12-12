local a = 1

all_regions["room1"] =  {
	begin_position     = {x=0,y=0, rot=0},
	end_position       = {x=3,y=0, rot=0},
	no_return_position = {x=10000, y=10000},
	next_room 		   = "room1",
	func               = function(list, x,y,rot, entity)
	local bRot = (rot+ entity.zone.begin_position.rot)%4
		local bX   = x - entity.zone.begin_position.x
		local bY   = y - entity.zone.begin_position.y

		entity.zone.rendered_at = {x = bX, y = bY, rot = bRot}
		add_walls({
			{1,5,"wall1"},
			{0,5,"wall1"},
			{-1,5,"wall1"},
			{1,4,"wall1"},
			{-1,4,"wall1"},
			{1,3,"wall1"},
			{-1,3,"wall1"},
			{1,2,"wall1"},
			{-1,2,"wall1"},
			{1,1,"wall1"},
			{-1,1,"wall1"},
			{1,0,"wall1"},
			
			{-1,0,"wall1"},
			{-1,-1,"wall1"},
			{0,-1,"wall1"},
			{1,-1,"wall1"},
			
			}
		, list, entity.zone.rendered_at)
		add_floors_ceilings({
			{0,0,"wall1","wall1"},
			{0,1,"wall1","wall1"},
			{0,2,"wall1","wall1"},
			{0,3,"wall1","wall1"},
			{0,4,"wall1","wall1"},
			}
		, list, entity.zone.rendered_at)

		--add_entity(game.entity_definitions.triggers.location_fade(2,0,1,2,1.1), list, entity.zone.rendered_at)
		add_entity(game.entity_definitions.triggers.location_audio(2,0,"staywithus1"), list, entity.zone.rendered_at)
		add_entity(game.entity_definitions.triggers.randomaudio(0.6,"staywithus1"), list, entity.zone.rendered_at)
		add_entity(game.entity_definitions.triggers.randomaudio(0.6,"notanywhere1"), list, entity.zone.rendered_at)
add_entity(game.entity_definitions.triggers.randomaudio(0.6,"staywithus1"), list, entity.zone.rendered_at)
		

		return (rot+ all_regions["room1"].end_position.rot)%4
end}

all_regions["hallway1_1"] =  {
	begin_position     = {x=-2,y=0, rot=0},
	end_position       = {x=4,y=-7, rot=1},
	no_return_position = {x=4, y=-2},
	next_room 		   = "hallway1_2",
	func               = function(list, x,y,rot, entity)
		--a
		local bRot = (rot+ entity.zone.begin_position.rot)%4
		local bX   = x - entity.zone.begin_position.x
		local bY   = y - entity.zone.begin_position.y
		entity.zone.rendered_at = {x = bX, y = bY, rot = bRot}
		load_walls(		{
			{-1,0, "hallway_wall1", "hallway_wall1", nil, nil, nil, nil},
			{-2,0, "hallway_wall1", "hallway_wall1", nil, nil, nil, nil},

			{0,0, "hallway_wall1", "hallway_wall1", nil, nil, nil, nil},
			{1,0, "hallway_wall1", "hallway_wall1", nil, nil, nil, nil},
			{2,0, "hallway_wall1", "hallway_wall1", nil, nil, nil, nil},
			{3,0, "hallway_wall1", "hallway_wall1", nil, nil, nil, nil},
			{4,-1, nil, nil, "hallway_wall1", "hallway_wall1", nil, nil},
			{4,0, "hallway_wall1", nil, nil, "hallway_wall1", nil, nil},
			{4,-2, nil, nil, "hallway_wall1", "hallway_wall1", nil, nil},
			{4,-3, nil, nil, "hallway_wall1", "hallway_wall1", nil, nil},
			{4,-4, nil, nil, "hallway_wall1", "hallway_wall1", nil, nil},
			{4,-5, nil, nil, "hallway_wall1", "hallway_wall1", nil, nil},
			{4,-6, nil, nil, "hallway_wall1", "hallway_wall1", nil, nil},

		},list, bX, bY, bRot )
		a = a%2 + 1

		add_entity(game.entity_definitions.triggers.location_fade(4,0,2,6,0.7), list, entity.zone.rendered_at)




		return (rot+ all_regions["hallway1_1"].end_position.rot)%4
	end}

all_regions["hallway1_2"] =  {
	begin_position     = {x=0,y=0, rot=0},
	end_position       = {x=6,y=7, rot=3},
	no_return_position = {x=6, y=2},
	next_room 		   = "hallway1_2",
	func               = function(list, x,y,rot, entity)
		--a
		local bRot = (rot+ entity.zone.begin_position.rot)%4
		local bX   = x - entity.zone.begin_position.x
		local bY   = y - entity.zone.begin_position.y

		entity.zone.rendered_at = {x = bX, y = bY, rot = bRot}
		load_walls(		{
			{0,0, "hallway_wall1", "hallway_wall1", nil, nil, nil, nil},
			{1,0, "hallway_wall1", "hallway_wall1", nil, nil, nil, nil},
			{2,0, "hallway_wall1", "hallway_wall1", nil, nil, nil, nil},
			{3,0, "hallway_wall1", "hallway_wall1", nil, nil, nil, nil},
			{4,0, "hallway_wall1", "hallway_wall1", nil, nil, nil, nil},
			{5,0, "hallway_wall1", "hallway_wall1", nil, nil, nil, nil},
			{6,1, nil, nil, "hallway_wall1", "hallway_wall1", nil, nil},
			{6,0, nil,  "hallway_wall1", nil, "hallway_wall1", nil, nil},
			{6,2, nil, nil, "hallway_wall1", "hallway_wall1", nil, nil},
			{6,3, nil, nil, "hallway_wall1", "hallway_wall1", nil, nil},
			{6,4, nil, nil, "hallway_wall1", "hallway_wall1", nil, nil},
			{6,5, nil, nil, "hallway_wall1", "hallway_wall1", nil, nil},
			{6,6, nil, nil, "hallway_wall1", "hallway_wall1", nil, nil},

		},list, bX, bY, bRot )
		return (rot+ all_regions["hallway1_2"].end_position.rot)%4
	end}

