local path = (...):gsub('%.init$', '') .. "."

local states = {}

states.main = require (path..'game')
states.loading = require (path..'loading')
states.note = require (path..'note')

return states
