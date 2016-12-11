love.conf = function(t)
  t.title = "Stealth Game Prototype"
  t.version = "0.10.1"
  t.window.width = 800
  t.window.height = 600
  t.window.resizable = false
  t.console = false
  t.window.vsync = false
end

CONTROLS = {}

CONTROLS.MOVE_UP = "w"
CONTROLS.MOVE_DOWN = "s"
CONTROLS.MOVE_RIGHT = "d"
CONTROLS.MOVE_LEFT = "a"
CONTROLS.ROT_LEFT = "left"
CONTROLS.ROT_RIGHT = "right"

CONTROLS.ACTION_ONE = "e"
CONTROLS.ACTION_TWO = "f"
CONTROLS.ACTION_THREE = "g"
CONTROLS.ACTION_FOUR = "r"

CONTROLS.RESET = 'e'
CONTROLS.PAUSE = 'p'
CONTROLS.ESCAPE = 'escape'
CONTROLS.FULLSCREEN_ONE = 'alt'
CONTROLS.FULLSCREEN_TWO = 'enter'

CONTROLS.ALL = {'MOVE_UP', 'MOVE_DOWN', 'MOVE_RIGHT', 'MOVE_LEFT', 'PAUSE', 'ESCAPE', 'ACTION_ONE', 'ACTION_TWO', 'ACTION_THREE', 'ACTION_FOUR', 'FULLSCREEN_ONE', 'FULLSCREEN_TWO'}
