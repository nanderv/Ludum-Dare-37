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
	agent.position   = {x=x, y=y, rotation=rot,speed = 100}
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
