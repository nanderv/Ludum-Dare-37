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
		for i = 0, 1000, 1 do
			number = string.format("%4.4d", i)
			print("numbers", number)
			print("test 1", prefix)
			print("test 2", suffix)
			print("test 3", prefix .. number .. suffix)
			local test =  prefix .. number .. suffix
			print("test 4", test)
			local f=io.open(test,"r")
			if f~=nil then
				print("test nil")
				io.close(f)
				animation[name][i] = love.graphics.newImage(test)
			else
				break
			end
		end
	end
end

function get_animation(name, frame)
	if animation[name] then
		return animation[name][frame]
	else
		return nil
	end
end

loading.phases = {

  core.reset_game,
  function()
    --load_image('assets/redbrick.png', "redbrick")
    load_image('assets/wood.png', "wood")
	load_image("assets/redbrick.png", "redbrick")
    load_image("assets/Notes/videogame_note1.png", "videogame_note1")
	load_image("assets/floor_tile_blood2.png", "floor_tile")
	load_image("assets/hallway/walls/walls0.png", "ceiling_tile")

	load_animation("wipArt/hallway/shade/sliced animations/shade_animated_", "0.png", "shade0");
	load_animation("wipArt/hallway/shade/sliced animations/shade_animated_", "1.png", "shade1");
	load_animation("wipArt/hallway/shade/sliced animations/shade_animated_", "2.png", "shade2");
	load_animation("wipArt/hallway/shade/sliced animations/shade_animated_", "3.png", "shade3");
	load_animation("wipArt/hallway/shade/sliced animations/shade_animated_", "4.png", "shade4");
	load_animation("wipArt/hallway/shade/sliced animations/shade_animated_", "5.png", "shade5");
	load_animation("wipArt/hallway/shade/sliced animations/shade_animated_", "6.png", "shade6");
	load_animation("wipArt/hallway/shade/sliced animations/shade_animated_", "7.png", "shade7");
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

          core.entity.add(game.entity_definitions.note.note(1,1, "videogame_note1"))


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
