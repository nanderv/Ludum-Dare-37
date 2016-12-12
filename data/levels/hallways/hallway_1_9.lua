






all_regions["hallway_1_9"] =  {
	begin_position     = {x=0,y=0, rot=0},
	end_position       = {x=-4,y=16, rot=3},
	no_return_position = {x=-4, y=16},
	next_room 		   = "room2",
	func               = function(list, x,y,rot, entity)
		--a
		local bRot = (rot+ entity.zone.begin_position.rot)%4
		local bX   = x - entity.zone.begin_position.x
		local bY   = y - entity.zone.begin_position.y
		entity.zone.rendered_at = {x = bX, y = bY, rot = bRot}
		print("LOADING")
				add_walls({
				{1,0,"wall1"},
				{1,1,"wall1"},
				{1,2,"wall1"},
				{1,3,"wall1"},
				{1,4,"wall1"},
				{1,5,"wall1"},
				{1,6,"wall1"},
				{1,7,"wall1"},
				{1,8,"wall1"},
				{1,9,"wall1"},
				{1,10,"wall1"},
				{1,11,"wall1"},
				{1,12,"wall1"},
				{1,13,"wall1"},
				{1,14,"wall1"},
				{1,15,"wall1"},

				{-1,0,"wall1"},
				{-1,1,"wall1"},
				{-1,2,"wall1"},
				{-1,3,"wall1"},
				{-1,4,"wall1"},					
				{-1,5,"wall1"},
				{-1,6,"wall1"},
				{-1,7,"wall1"},
				{-1,8,"wall1"},
				{-1,9,"wall1"},				
				{-1,10,"wall1"},
				{-1,11,"wall1"},
				{-1,12,"wall1"},
				{-1,13,"wall1"},
				{-1,14,"wall1"},				
				{-1,15,"wall1"},

				{1,16,"wall1"},
				{0,17,"wall1"},
				{-1,17,"wall1"},
				{-2,17,"wall1"},
				{-3,17,"wall1"},
				{-1,15,"wall1"},
				{-2,15,"wall1"},
				{-3,15,"wall1"},
			}
		, list, entity.zone.rendered_at)


		add_entity(game.entity_definitions.triggers.location_fade(4,0,2,6,0.7), list, entity.zone.rendered_at)




		return (rot+ all_regions["hallway_1_9"].end_position.rot)%4
	end}
