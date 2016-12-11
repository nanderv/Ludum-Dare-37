local path = (...):gsub('%.init$', '') .. "."

local states = {}

states.main = require (path..'game')
states.loading = require (path..'loading')
states.menu = require (path..'menu_main')
states.settings = require (path..'menu_settings')
states.pause = require (path..'menu_pause')
states.note = require (path..'note')

return states
