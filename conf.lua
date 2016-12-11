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

CONTROLS.UP = "w"
CONTROLS.DOWN = "s"
CONTROLS.RIGHT = "d"
CONTROLS.LEFT = "a"
CONTROLS.ROT_LEFT = "left"
CONTROLS.ROT_RIGHT = "right"

CONTROLS.ONE = "t"
CONTROLS.TWO = "g"
CONTROLS.THREE = "f"
CONTROLS.FOUR = "r"

CONTROLS.RESET = 'e'
CONTROLS.PAUSE = 'p'
CONTROLS.ESCAPE = 'escape'

CONTROLS.ALL = {'UP', 'DOWN', 'RIGHT', 'LEFT', 'PAUSE', 'ESCAPE', 'ONE', 'TWO', 'THREE', 'FOUR'}
