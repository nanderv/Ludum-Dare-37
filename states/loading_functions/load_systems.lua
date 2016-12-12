sti = require 'zz_lib.sti'

return function()
    core.system.add( my_require 'systems.player_control.keyboard_movement',  {"update"})
    core.system.add( my_require 'systems.player_control.mouse_movement',  {"update"})
    core.system.add( my_require 'systems.collision.bump',  {"update"})
        core.system.add( my_require 'systems.sound.musicmixer',  {"update"})
        core.system.add( my_require 'systems.sound.sfx',  {"update"})

      -- core.system.add( my_require 'systems.player_control.controller_movement', {})

        core.system.add( my_require 'systems.raycaster.basicCaster',  {"update", "draw"})
        core.system.add( my_require 'systems.note_detecting',  {"update", "draw"})
        core.system.add( my_require 'systems.zoneloader',  {"update"})
        core.system.add( my_require 'systems.triggers.location_fade',  {"update"})
        core.system.add( my_require 'systems.triggers.locationaudio',  {"update"})
        core.system.add( my_require 'systems.triggers.randomaudio',  {"update"})


        core.system.add( my_require 'systems.add_entities.add_ceiling',  {"update"})
        core.system.add( my_require 'systems.add_entities.add_entity',  {"update"})
        core.system.add( my_require 'systems.add_entities.add_floor',  {"update"})
        core.system.add( my_require 'systems.add_entities.add_physical_objects',  {"update"})
        core.system.add( my_require 'systems.add_entities.add_wall',  {"update"})
        

        my_require 'data.levels.room1'

        core.entity.add(game.entity_definitions.zone("room1"))

end
