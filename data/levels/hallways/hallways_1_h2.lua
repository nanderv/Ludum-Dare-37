



for i=1,10, 1 do


all_regions["hallway_11"..i] =  {
	begin_position     = {x=0,y=0, rot=0},
	end_position       = {x=-9,y=2, rot=3},
	no_return_position = {x=-3, y=2},
	next_room 		   = "hallway_11"..(i+1),
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


				{-1,0,"wall1"},
				{-1,1,"wall1"},


				{1,2,"wall1"},
				{1,3,"wall1"},
				{0,4,"wall1"},
				{-1,3,"wall1"},
				{-2,3,"wall1"},
				{-3,3,"wall1"},
				{-4,3,"wall1"},
				{-5,3,"wall1"},
				{-6,3,"wall1"},
				{-7,3,"wall1"},
				{-8,3,"wall1"},				
				{-1,1,"wall1"},
				{-2,1,"wall1"},
				{-3,1,"wall1"},
				{-4,1,"wall1"},
				{-5,1,"wall1"},
				{-6,1,"wall1"},
				{-7,1,"wall1"},
				{-8,1,"wall1"},
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
	if  i == 1 then
		add_entity(game.entity_definitions.triggers.randomaudio(0.6,"notanywhere1"), list, entity.zone.rendered_at)

	end
		if i== 2 then
			add_entity(game.entity_definitions.objs.entity(0,3, "note"), list, entity.zone.rendered_at)
			add_entity(game.entity_definitions.note.note(0,3, "note5"), list, entity.zone.rendered_at)
			add_entity(game.entity_definitions.note.note(0,2, "note5"), list, entity.zone.rendered_at)

		end
		if i==4 then
		add_entity(game.entity_definitions.triggers.randomaudio(0.6,"staywithus1"), list, entity.zone.rendered_at)
					add_entity(game.entity_definitions.triggers.randomaudio(0.6,"notanywhere1"), list, entity.zone.rendered_at)

		end
		if i == 6 then
			add_entity(game.entity_definitions.objs.entity(0,3, "note"), list, entity.zone.rendered_at)
			add_entity(game.entity_definitions.note.note(0,3, "note6"), list, entity.zone.rendered_at)
			add_entity(game.entity_definitions.note.note(0,2, "note6"), list, entity.zone.rendered_at)

		end

		if i == 7 then
			add_entity(game.entity_definitions.objs.entity(0,3, "note"), list, entity.zone.rendered_at)
			add_entity(game.entity_definitions.note.note(0,3, "note7"), list, entity.zone.rendered_at)
			add_entity(game.entity_definitions.note.note(0,2, "note7"), list, entity.zone.rendered_at)
					add_entity(game.entity_definitions.triggers.randomaudio(0.6,"stayisbad1"), list, entity.zone.rendered_at)
					add_entity(game.entity_definitions.triggers.randomaudio(0.6,"staywithus1"), list, entity.zone.rendered_at)
					add_entity(game.entity_definitions.triggers.randomaudio(0.6,"notanywhere1"), list, entity.zone.rendered_at)
					add_entity(game.entity_definitions.triggers.randomaudio(0.6,"leavenow1"), list, entity.zone.rendered_at)

		end

		if i==10 then
					add_entity(game.entity_definitions.triggers.randomaudio(0.6,"stayisbad1"), list, entity.zone.rendered_at)
					add_entity(game.entity_definitions.triggers.randomaudio(0.6,"staywithus1"), list, entity.zone.rendered_at)
					add_entity(game.entity_definitions.triggers.randomaudio(0.6,"notanywhere1"), list, entity.zone.rendered_at)
					add_entity(game.entity_definitions.triggers.randomaudio(0.6,"leavenow1"), list, entity.zone.rendered_at)
					add_entity(game.entity_definitions.triggers.randomaudio(0.6,"getbetter2"), list, entity.zone.rendered_at)

		end
	

		add_entity(game.entity_definitions.triggers.location_fade(4,0,2,6,0.7), list, entity.zone.rendered_at)




		return (rot+ all_regions["hallway_11"..i].end_position.rot)%4
	end}

end