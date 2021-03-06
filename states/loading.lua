local loading = {}
loading.loaded = 1
-- Loading screen phases, split up loading code among these phases
loading.loaded_paths = {}
local tile_width = 32
local tile_height = 32
require 'zz_lib.core_maths'
function my_require (str)
  loading.loaded_paths[str] = str
  return require (str)
end
local images = {}

local function load_image(url, name)
  if not images[name] then
    images[name] = love.graphics.newImage(url)
  end
end

function get_image(name)
  return images[name]
end

local animation = {}
local function load_animation(prefix, suffix, name)
	if not animation[name] then
		animation[name] = {}
		local running = true
    
		for i=0,122, 1  do
        local test = prefix ..  string.format("%4.4d", i) .. suffix
				animation[name][i] = love.graphics.newImage(test)
    
		end
	end
end

function get_animation(name, frame)
	if animation[name] then
    print( animation[name][frame], frame)
		return animation[name][frame]
	else
		return nil
	end
end

loading.phases = {

  core.reset_game,
  function()
    --load_image('assets/redbrick.png', "redbrick")

    load_image("assets/Notes/videogame_note1.png", "videogame_note1")
	load_image("assets/room/furniture/bed_base.png", "bed")
	load_image("assets/floor_tile_blood2.png", "floor_tile")
	load_image("assets/hallway/ceiling/ceiling1.png", "ceiling_tile")
    load_image("assets/Notes/note.png", "note")


    load_image("assets/Notes/videogame_note1.png", "note1")
    load_image("assets/Notes/videogame_note2.png", "note2")
    load_image("assets/Notes/videogame_note3.png", "note3")
    load_image("assets/Notes/videogame_note4.png", "note4")
    load_image("assets/Notes/videogame_note5.png", "note5")
    load_image("assets/Notes/videogame_note6.png", "note6")
    load_image("assets/Notes/videogame_note7.png", "note7")
    load_image("assets/Notes/videogame_note8.png", "note8")


    load_image("assets/room/lights/Lightbulb dim.png", "light")

  
	--load_image("wipArt/transparant_texture.png", "transparent")
  load_image("assets/room/walls/wall_dark_middle.png", "wall1")
  load_image("assets/hallway/walls/walls0.png", "hallway_wall1")


  end,
  require 'entities.load_all_entity_definitions',
  function()
    for k,v in pairs (loading.loaded_paths) do
      package.loaded[v] = nil
    end
    collectgarbage("collect")

    load_image("assets/floor_tile.png", "floor")
    end,
    require 'entities.load_all_entity_definitions',
    function()
         for k,v in pairs (loading.loaded_paths) do
            package.loaded[v] = nil
         end
        collectgarbage("collect")


        next_id = next_id_func()
        game.resources = {}
        -- require component types
    end,
    require 'states.loading_functions.load_systems',
    function()

       local pl = core.entity.add(game.entity_definitions.player.player(0.5,0.5, 20))



    end,

}

function loading:enter(from)
  print("STARTING LOADING")
  loading.loaded=1
end

-- Leave loading screen
function loading:leave(from)
  for k,v in pairs(game.systems) do
    print("Running system "..v.name)
  end
  print("FINISHED LOADING")
end

function loading:update()
  if self.loaded <= #self.phases then
    self.phases[self.loaded]()
    self.loaded = self.loaded + 1
    -- love.timer.sleep(0.01)
  else
    GS:pop()
  end
end

-- Draw loading screen
function loading:draw()

end

function loading:keypressed(key)

end
return loading
