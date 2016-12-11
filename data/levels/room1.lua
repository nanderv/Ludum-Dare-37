local a = 1
all_regions["hallway1"] =  {
	begin_position     = {x=0,y=0, rot=0},
	end_position       = {x=4,y=-5, rot=1},
	no_return_position = {x=4, y=-2},
	next_room 		   = "hallway2",
	func               = function(list, x,y,rot, entity)
		--a
		local bRot = (rot+ entity.zone.begin_position.rot)%4
		local bX   = x - entity.zone.begin_position.x
		local bY   = y - entity.zone.begin_position.y
		entity.zone.rendered_at = {x = bX, y = bY, rot = bRot}
		load_walls(		{
			{0,0, "wood", "redbrick", nil, nil, nil, nil},
			{1,0, "wood", "redbrick", nil, nil, nil, nil},
			{2,0, "wood", "redbrick", nil, nil, nil, nil},
			{3,0, "wood", "redbrick", nil, nil, nil, nil},
			{4,-1, nil, nil, "wood", "wood", nil, nil},
			{4,0, "wood", nil, nil, "wood", nil, nil},
			{4,-2, nil, nil, "wood", "wood", nil, nil},
			{4,-3, nil, nil, "wood", "wood", nil, nil},
			{4,-4, nil, nil, "wood", "wood", nil, nil},
			{4,-5, nil, nil, "wood", "wood", nil, nil},

		},list, bX, bY, bRot )
		a = a%2 + 1
		
		add_entity(game.entity_definitions.triggers.location_fade(4,0,2,6,0.7), list, entity.zone.rendered_at)
			
		
		

		return (rot+ all_regions["hallway1"].end_position.rot)%4
	end}

all_regions["hallway2"] =  {
	begin_position     = {x=0,y=0, rot=0},
	end_position       = {x=4,y=5, rot=3},
	no_return_position = {x=4, y=2},
	next_room 		   = "hallway1",
	func               = function(list, x,y,rot, entity)
		--a
		local bRot = (rot+ entity.zone.begin_position.rot)%4
		local bX   = x - entity.zone.begin_position.x
		local bY   = y - entity.zone.begin_position.y

		entity.zone.rendered_at = {x = bX, y = bY, rot = bRot}
		load_walls(		{
			{0,0, "wood", "redbrick", nil, nil, nil, nil},
			{1,0, "wood", "redbrick", nil, nil, nil, nil},
			{2,0, "wood", "redbrick", nil, nil, nil, nil},
			{3,0, "wood", "redbrick", nil, nil, nil, nil},
			{4,1, nil, nil, "wood", "wood", nil, nil},
			{4,0, nil,  "wood", nil, "wood", nil, nil},
			{4,2, nil, nil, "wood", "wood", nil, nil},
			{4,3, nil, nil, "wood", "wood", nil, nil},
			{4,4, nil, nil, "wood", "wood", nil, nil},
			{4,5, nil, nil, "wood", "wood", nil, nil},

		},list, bX, bY, bRot )
		return (rot+ all_regions["hallway2"].end_position.rot)%4
	end}


all_regions["room1"] =  {
	begin_position     = {x=0,y=0, rot=0},
	end_position       = {x=4,y=0, rot=0},
	no_return_position = {x=10000, y=10000},
	next_room 		   = "hallway1",
	func               = function(list, x,y,rot, entity)
	local bRot = (rot+ entity.zone.begin_position.rot)%4
		local bX   = x - entity.zone.begin_position.x
		local bY   = y - entity.zone.begin_position.y

		entity.zone.rendered_at = {x = bX, y = bY, rot = bRot}
		load_walls(		{

			{2,-3, nil,  "wood", nil, "wood", nil, nil},
			{2,-2, nil, nil, nil, "wood", nil, nil},
			{2,-1, nil, nil, nil, "wood", nil, nil},
			{2, 1, nil, nil, nil, "redbrick", nil, nil},

			{2, 2,  "wood", nil, nil, "redbrick", nil, nil},

			{-2, 4,  "wood", nil, nil, nil, nil, nil},
			{-1, 4,  "wood", nil, nil, nil, nil, nil},
			{ 0, 4,  "wood", nil, nil, nil, nil, nil},
			{ 1, 4,  "wood", nil, nil, nil, nil, nil},
			{ 2, 4,  "wood", nil, nil, nil, nil, nil},


			{-2,-2, nil,  "wood", nil, "wood", nil, nil},

			{-2,-1, nil, nil, nil, "wood", nil, nil},
			{-2, 0, nil, nil, nil, "wood", nil, nil},

			{-2, 1, nil, nil, nil, "redbrick", nil, nil},


			{-2, -4, nil,  "wood", nil, "redbrick", nil, nil},
			{-2, -4, nil,  "wood", nil, nil, nil, nil},
			{-1, -4, nil,  "wood", nil, nil, nil, nil},
			{ 0, -4, nil,  "wood", nil, nil, nil, nil},
			{ 1, -4, nil,  "wood", nil, nil, nil, nil},


			{ -1, -4, "shade0", nil, nil, nil, nil, nil},
			{ -1, -3, "shade1", nil, nil, nil, nil, nil},
			{ -1, -2, "shade2", nil, nil, nil, nil, nil},
			{ -1, -1, "shade3", nil, nil, nil, nil, nil},
			{ -1, 0, "shade4", nil, nil, nil, nil, nil},
			{ -1, 1, "shade5", nil, nil, nil, nil, nil},
			{ -1, 2, "shade6", nil, nil, nil, nil, nil},
			{ -1, 3, "shade7", nil, nil, nil, nil, nil},
		},list, bX, bY, bRot )
		add_entity(game.entity_definitions.triggers.location_fade(2,0,1,2,1.1), list, entity.zone.rendered_at)

		return (rot+ all_regions["room1"].end_position.rot)%4
end}
