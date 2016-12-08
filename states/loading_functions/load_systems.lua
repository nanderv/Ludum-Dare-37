sti = require 'zz_lib.sti'

return function()
    core.system.add( my_require 'systems.player_control.basic_movement',  {"update"})
    core.system.add( my_require 'systems.collision.bump',  {"update"})
end