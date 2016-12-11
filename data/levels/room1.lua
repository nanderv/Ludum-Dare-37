
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
	end_position       = {x=5,y=0, rot=0},
	no_return_position = {x=10000, y=10000},
	next_room 		   = "hallway1",
	func               = function(list, x,y,rot, entity)
	local bRot = (rot+ entity.zone.begin_position.rot)%4
		local bX   = x - entity.zone.begin_position.x
		local bY   = y - entity.zone.begin_position.y

		entity.zone.rendered_at = {x = bX, y = bY, rot = bRot}
		load_walls(		{
			{3,-3, nil,  "wood", nil, "wood", nil, nil},
			{3,-2, nil, nil, nil, "wood", nil, nil},
			{3,-1, nil, nil, nil, "wood", nil, nil},
			{3, 1, nil, nil, nil, "redbrick", nil, nil},
			{3, 2, nil, nil, nil, "redbrick", nil, nil},
			{3, 3,  "wood", nil, nil, "redbrick", nil, nil},

			{-2, 3,  "wood", nil, nil, nil, nil, nil},
			{-1, 3,  "wood", nil, nil, nil, nil, nil},
			{ 0, 3,  "wood", nil, nil, nil, nil, nil},
			{ 1, 3,  "wood", nil, nil, nil, nil, nil},
			{ 2, 3,  "wood", nil, nil, nil, nil, nil},
			

			{-3,-3, nil,  "wood", nil, "wood", nil, nil},
			{-3,-2, nil, nil, nil, "wood", nil, nil},
			{-3,-1, nil, nil, nil, "wood", nil, nil},
			{-3, 0, nil, nil, nil, "wood", nil, nil},

			{-3, 1, nil, nil, nil, "redbrick", nil, nil},
			{-3, 2, nil, nil, nil, "redbrick", nil, nil},
			{-3,  3, nil,  "wood", nil, "redbrick", nil, nil},
			{-2, -3, nil,  "wood", nil, nil, nil, nil},
			{-1, -3, nil,  "wood", nil, nil, nil, nil},
			{ 0, -3, nil,  "wood", nil, nil, nil, nil},
			{ 1, -3, nil,  "wood", nil, nil, nil, nil},
			{ 2, -3, nil,  "wood", nil, nil, nil, nil},

		},list, bX, bY, bRot )

		return (rot+ all_regions["room1"].end_position.rot)%4
end}