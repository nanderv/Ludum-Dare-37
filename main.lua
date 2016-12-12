game = {}
GS = require "zz_lib.gamestate"
global = {}
require 'ECS'
core.states = require 'states'
models = {}
game___objs = {}
game___objs.wall = {}
game___objs.ceiling = {}
game___objs.floor = {}
game___objs.entity = {}
game___objs.physical_side = {}
game___objs.physical_top = {}

function love.load()
  love.graphics.setDefaultFilter("nearest", "nearest", 1)
  GS.registerEvents()
  GS.switch(core.states.menu)
end

-- This one will only be used for debugging purposes, love.keyDown is used in most other cases
function love.keypressed(key)
  core.gamepad = nil
  if GS.current() == core.states.main and key == CONTROLS.PAUSE then
    if GS.current() ~= core.states.pause then
      GS.push(core.states.pause)
    else
      GS.pop()
    end
  end
  if key == CONTROLS.FOUR then
    GS.push(core.states.loading)
  end
end

function love.threaderror(t, e)
  return error(e)
end
