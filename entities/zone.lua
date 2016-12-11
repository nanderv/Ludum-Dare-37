local id = 0
-- begin_position     = {x = x, y = y, rot = rot}
-- end_position       = {x = x, y = y, rot = rot}
-- no_return_position = {x = x, y = y}
return function( textfile)
	local begin_position = all_regions[textfile].begin_position
	local end_position = all_regions[textfile].end_position
	local no_return_position = all_regions[textfile].no_return_position
	local next_room = all_regions[textfile].next_room
 	local agent = {}
 	id =  id + 1
 	agent.name       ="zone"..id
	agent.zone = {begin_position = begin_position, end_position = end_position, no_return_position = no_return_position, textfile = textfile, next_room = next_room}
	return agent
end
