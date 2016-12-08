# Ludum-Dare-37
We be cool people making videogamez!

## About Tools:
### Essentials 
+ Löve2D - game engine - https://love2d.org/ 
+ Git - version control - https://git-scm.com/
+> Your favorite git tool
+ Google Drive - assets sharing - https://www.google.com/drive/download/

### Programming
+ Text editor / IDE for LUA, we recommendations:
+> Sublime Text - text editor - https://www.sublimetext.com/
++> With plugin: BracketHighlighter
+> Atom - text editor - https://atom.io/

### Art
+ Any program of your preference capable of producing pixel art
+> I will personally use Adobe Photoshop and Aseprite (https://www.aseprite.org/)
+> It should be able to handle animations

### Music
+ I don't know this part, Peter usually handles this

### Level Design
+ Tiled - http://www.mapeditor.org/

## Programming structure
The structure used for the game is called ECS (Entity Component System).
It's based on three (five) main components:
1. Entities: Things that exist within the game. For instance, the player. They are basically just a reference.
2. Components: Properties of Entities. Example: Position.
3. Systems: Logical systems, such as Gravity, or Drawing

### Entities
> Creating them
>> Create a function that makes them and fills them.
Put this function in the entities folder. It will get loaded automatically.
Example:
```
local id = 0
return function(x,y, rot)
 	local agent = {}
 	id =  id + 1
 	agent.name       ="agent".. id
	agent.position   = {x=x, y=y, rotation=rot}
	agent.basic_move = {true}
	agent.speed   = {speed = 100}
	agent.bump_shape = {w = 28, h = 28}
	return agent
end
```

>> Adding an entity:

```
 local pl = core.entity.add(game.entity_definitions.player.player(400,1100, 20))
```

>> Removing an entity:
core.component.remove(v, "idle")

### Components
Components are mostly added inline for Entities, since a lot of components are trivial, data-wise.

### Systems
A system is a logical unit. It contains:
1. A name (String). It has to be unique.
2. A function. Often update or draw. 
3. A dictionary of requirements. Those are the names of components that entities must all have in order to be in the target list of a system.

A system automatically gets a list of targets. That one can be iterated over (using pairs) to get all targets of a system.


