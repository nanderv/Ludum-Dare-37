

all_regions["hallway_1_3"] =  {
	begin_position     = {x=0,y=0, rot=0},
	end_position       = {x=3,y=2, rot=1},
	no_return_position = {x=2, y=2},
	next_room 		   = "hallway_1_4",
	func               = function(list, x,y,rot, entity)
		--a
		local bRot = (rot+ entity.zone.begin_position.rot)%4
		local bX   = x - entity.zone.begin_position.x
		local bY   = y - entity.zone.begin_position.y
		entity.zone.rendered_at = {x = bX, y = bY, rot = bRot}
		print("LOADING")
				add_walls({
				{1,0,"wall1"},
				{-1,0,"wall1"},
				{1,1,"wall1"},
				{-1,1,"wall1"},
				{-1,2,"wall1"},
				
				{ 0,3,"wall1"},
				{ 1,3,"wall1"},
				{ 1,1,"wall1"},
				{ 2,3,"wall1"},
				{ 2,1,"wall1"},




			}
		, list, entity.zone.rendered_at)
--	"notanywhere1"
--"staywithus1"
--"daddycrying1"
--"getbetter1"
--"getbetter2"
--"getout1"
--"leavenow1"
--"missyou1"
--"notanywhere1"
--"notanywhere2"
--"stayisbad1"
--"staywithus1"

		add_entity(game.entity_definitions.triggers.location_fade(4,0,2,6,0.7), list, entity.zone.rendered_at)




		return (rot+ all_regions["hallway_1_3"].end_position.rot)%4
	end}