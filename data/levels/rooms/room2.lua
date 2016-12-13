

all_regions["room2"] =  {
	begin_position     = {x=0,y=0, rot=0},
	end_position       = {x=0,y=0, rot=0},
	no_return_position = {x=10000, y=10000},
	next_room 		   = "END",
	func               = function(list, x,y,rot, entity)
	local bRot = (rot+ entity.zone.begin_position.rot)%4
		local bX   = x - entity.zone.begin_position.x
		local bY   = y - entity.zone.begin_position.y

		entity.zone.rendered_at = {x = bX, y = bY, rot = bRot}
		add_walls({
			{-3,4,"wall1"},
			{-2,5,"wall1"},
			{-1,5,"wall1"},
			
			
			{0,5,"wall1"},
			{1,5,"wall1"},
			{2,5,"wall1"},
			{3,4,"wall1"},

			{3,3,"wall1"},
			{-3,3,"wall1"},
			{3,2,"wall1"},
			{-3,2,"wall1"},
			{3,1,"wall1"},
			{-3,1,"wall1"},
			{3,0,"wall1"},
			{-3,0,"wall1"},
			{-2,-1,"wall1"},
			{-1,-1,"wall1"},
			{1,-1,"wall1"},
			{2,-1,"wall1"},
			
			
			
			}
		, list, entity.zone.rendered_at)
		add_floors_ceilings({
			{0,0,"floor_tile","floor_tile"},
			{0,1,"floor_tile","floor_tile"},
			{0,2,"floor_tile","floor_tile"},
			{0,3,"floor_tile","floor_tile"},
			{0,4,"floor_tile","floor_tile"},
			{0,5,"floor_tile","floor_tile"},
			{1,1,"floor_tile","floor_tile"},
			{1,2,"floor_tile","floor_tile"},
			{1,3,"floor_tile","floor_tile"},
			{-1,0,"floor_tile","floor_tile"},
			{-1,1,"floor_tile","floor_tile"},
			{-1,2,"floor_tile","floor_tile"},
			{-1,3,"floor_tile","floor_tile"},
			{-1,4,"floor_tile","floor_tile"},
			}
		, list, entity.zone.rendered_at)

		--add_entity(game.entity_definitions.triggers.location_fade(2,0,1,2,1.1), list, entity.zone.rendered_at)
		add_entity(game.entity_definitions.triggers.location_audio(2,0,"staywithus1"), list, entity.zone.rendered_at)
		add_entity(game.entity_definitions.triggers.randomaudio(0.6,"staywithus1"), list, entity.zone.rendered_at)
		add_entity(game.entity_definitions.triggers.randomaudio(0.6,"notanywhere1"), list, entity.zone.rendered_at)
add_entity(game.entity_definitions.triggers.randomaudio(0.6,"staywithus1"), list, entity.zone.rendered_at)
		

		return (rot+ all_regions["room2"].end_position.rot)%4
end}


all_regions["END"] =  {
	begin_position     = {x=0,y=0, rot=0},
	end_position       = {x=0,y=60, rot=0},
	no_return_position = {x=10000, y=10000},
	next_room 		   = "END",
	func               = function(list, x,y,rot, entity)
	local bRot = (rot+ entity.zone.begin_position.rot)%4
		local bX   = x - entity.zone.begin_position.x
		local bY   = y - entity.zone.begin_position.y

		entity.zone.rendered_at = {x = bX, y = bY, rot = bRot}
		add_walls({

			{0,-1,"wall1"},

			
			
			
			}
		, list, entity.zone.rendered_at)
		add_floors_ceilings({
			{0,0,"floor_tile","floor_tile"},
			{0,1,"floor_tile","floor_tile"},
			{0,2,"floor_tile","floor_tile"},
			{0,3,"floor_tile","floor_tile"},
			{0,4,"floor_tile","floor_tile"},
			{0,5,"floor_tile","floor_tile"},
			{1,1,"floor_tile","floor_tile"},
			{1,2,"floor_tile","floor_tile"},
			{1,3,"floor_tile","floor_tile"},
			{-1,0,"floor_tile","floor_tile"},
			{-1,1,"floor_tile","floor_tile"},
			{-1,2,"floor_tile","floor_tile"},
			{-1,3,"floor_tile","floor_tile"},
			{-1,4,"floor_tile","floor_tile"},
			}
		, list, entity.zone.rendered_at)

		--add_entity(game.entity_definitions.triggers.location_fade(2,0,1,2,1.1), list, entity.zone.rendered_at)
		add_entity(game.entity_definitions.triggers.location_audio(2,0,"staywithus1"), list, entity.zone.rendered_at)
		add_entity(game.entity_definitions.triggers.randomaudio(0.6,"daddycrying1"), list, entity.zone.rendered_at)

add_entity(game.entity_definitions.triggers.randomaudio(0.6,"staywithus1"), list, entity.zone.rendered_at)


		return (rot+ all_regions["room2"].end_position.rot)%4
end}
