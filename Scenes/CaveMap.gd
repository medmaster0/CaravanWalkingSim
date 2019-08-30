extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export (PackedScene) var Item
export (PackedScene) var Creature

#This is a contained Cave Map
#Contains the tileMap and takes care of drawing
#Also contains all items (background and pickup...)
#Basically a mini version of the Game, but built for one creature...
#
#So the creature will have this random cave to wander around with...
#You can display it off or on...
#Basically push it up to a higher z-layer?
#
# This will have a total of 2 Maps! 
#Since we need to display both Prim and Seco Tiles....

var wallColorPrim
var wallColorSeco
var floorColorPrim
var floorColorSeco

var map_size = Vector2(40,40-8) #the size of the map that can be generated... 
								#Leave room for the interface windows!

var map_enemies = [] #will contain all creature enemies

# Called when the node enters the scene tree for the first time.
func _ready():
	
	randomize()
	
	wallColorPrim = Color(randf(), randf(), randf()) 
	wallColorSeco = Color(randf(), randf(), randf())
	floorColorPrim = Color(randf(), randf(), randf())
	floorColorSeco = Color(randf(), randf(), randf())
	
	#Now set the tiles....
	$PrimMap.tile_set.tile_set_modulate(0, floorColorPrim);
	$PrimMap.tile_set.tile_set_modulate(2, wallColorPrim);
	$SecoMap.tile_set.tile_set_modulate(1, floorColorSeco);
	$SecoMap.tile_set.tile_set_modulate(3, wallColorSeco);
	
	#Generate a random map layout....
	var map_data = RogueGen.GenerateVault_v1(map_size)
	
	#Cycle through the generated map (2D array)
	for x in range(map_size.x):
		for y in range(map_size.y):
			match map_data.map[x][y]:
				0:
					#blank tiles
					pass
				1:
					#floor tiles
					$PrimMap.set_cell(x, y, 0)
					$SecoMap.set_cell(x , y, 1)
				2:
					#wall tiles
					$PrimMap.set_cell(x, y, 2)
					$SecoMap.set_cell(x, y, 3)
	
	#Access Rect2 coords by:
	# (width, length) -> Rect2obj.size
	# (x,y) - > Rect2obj.position
	
	#PLACE A SINGLE RANDOM STONE
	var s = randi()%map_data.rooms.size() #Random room index
	#Get a random point inside the room...
	var point = RogueGen.inside_rect(map_data.rooms[s])
	#make a new item
	var temp_stone = Item.instance()
	#Remember to use global (vs map) coordinates
	temp_stone.position = $PrimMap.map_to_world(point)
	add_child(temp_stone)
	temp_stone.setTile(1)
	temp_stone.disableSelect()

	#STYLE 1:
	# What if we color the stone a blend of the wall colors??
	var blend_col = MedAlgo.blendColor(wallColorSeco,floorColorPrim)
	temp_stone.SetPrimColor(blend_col)
	
	#STYLE 2:
	# Random Wall/Floor colors, but stone based off Creature Pref?? (slightly skewed?)
	# NAAHHHHHHHHHHHHHHHHH (but maybe?)
	
	#PLACE A BUNCH OF RANDOM CANs
	for k in range(9):
		s = randi()%map_data.rooms.size() #Random room index
		#Get a ranodom point inside the room...
		point = RogueGen.inside_rect(map_data.rooms[s])
		#make a new item
		var temp_can = Item.instance()
		#Remember to use global (vs map) coordinates
		temp_can.position = $PrimMap.map_to_world(point)
		add_child(temp_can)
		temp_can.setTile(3)
		temp_can.disableSelect()
	
	#PLACE A COUPLE ENEMIES
	for k in range(2):
		s = randi()%map_data.rooms.size() #random ruoom index
		#Get a ranodom point inside the room...
		point = RogueGen.inside_rect(map_data.rooms[s])
		#Make a new creature
		var temp_enemy = Creature.instance()
		#Remember to use global (vs map) coordinates
		temp_enemy.position = $PrimMap.map_to_world(point)
		add_child(temp_enemy)
		map_enemies.append(temp_enemy)
	
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

#Function to transfer an input creature into the CaveMap
func enterMainCreature(in_creature):
	print(in_creature.name + " entered the Cave")
	$MainCreature.SetPrimColor(in_creature.primColor)
	$MainCreature/Hat.copy_hat(in_creature.find_node("Hat")) #also copy hat
	$MainCreature/MajorArcWeapon.copy_weapon(in_creature.find_node("MajorArcWeapon"))