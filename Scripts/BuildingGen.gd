extends Node


######
######
##IMPORTANT NOTE: These building maps are accessed: var map[ROW][COL]
#					   WHEN PRINTED OUT LOOKS LIKES var map[Y-COORD][X_COORD]





#Function to generate an entire building plot
# BUILDING PLOT MAP!!!!
#
#	This is what the building plot looks like...	
#
#	22222222
#	21111112
#	21000012
#	23000612
#	21045032
#	21000012
#	21111112
#	22222222
#
#	0 - FLOOR
#	1 - WALL
#	2 - BALCONY
#	3 - DOOR
#	4 - LADDER
#	5 - FLAG
#	6 - DESK
# 
#Will return a 2D array with the following pattern
# A 8 x 8 ARRAY
func gen_building_plot_map():
	
	var building_map_plot = [] # A 2D array to be returned
	
	#Initialize the ARRAY 
	for i in range(8):
		var new_row = []
		for j in range(8):
			new_row.append(2)
		building_map_plot.append(new_row)
		
	#Place the WALLS
	building_map_plot = place_rectangle_in_map(building_map_plot,1,1,6,6,1)

	#Place the FLOORS
	building_map_plot = place_rectangle_in_map(building_map_plot,2,2,4,4,0)
	
	#Place the LADDER
	building_map_plot[4][3] = 4
	
	#Place the FLAG
	building_map_plot[4][4] = 5
	
	#Place the LADDER
	building_map_plot[4][3] = 4
	
	#Place the DESK
	building_map_plot[3][5] = 6
	
	#PLACE DOORS
	building_map_plot[3][1] = 3
	building_map_plot[4][6] = 3
	
	return(building_map_plot)
	
#####MORE PLOT PATTERNS HERE
	
# UTILITY #######
#
#Will put a rectangle in the map
# Input:
# The in_map to be written to
# Specify the Top Left Corner of the rect
# Width -> x dimension
# Height -> y dimension
# What tile to set the rectangle
func place_rectangle_in_map(in_map, x_coord, y_coord, width, height, tile_index):
	var x_index # used to iterate over the map
	var y_index # used to iterate over the map
	for i in range(width):
		for j in range(height):
			in_map[x_coord + i][y_coord + j] = tile_index #set the tile
			
	return(in_map)
	
	
#####MORE SHAPE FUNCTIONS HERE
	
##Function that puts the building items in a Main Game Scene
# The game_scene will put the items as children
# But will also keep track of them in map_items[][][] 3D indexed arrays
# Also map_buildings
# The x_coord and y_coord are global coords of top left corner
# But assume they are aligned on tiles!!!
func put_items_building_plot(game_scene, x_coord_global, y_coord_global, z_coord):
	var Item = load("res://Scenes//Item.tscn") #Used as a template for making items
	
	var temp_item #the temp item used to create the items
	var temp_x_coord_global #the global position of created item
	var temp_y_coord_global #the global position of created item
	var temp_x_coord_map #the map position of created item
	var temp_y_coord_map #the map position of created item
	var tile_size = 16 #How many global pixels wide/high a tile is....
	var building_map = gen_building_plot_map()
	
	#COLORS>..... SHOULD handle this better
	var floorPrim = Color(randf(), randf(), randf())
	var floorSeco = Color(randf(), randf(), randf())
	var wallPrim = Color(randf(), randf(), randf())
	var wallSeco = Color(randf(), randf(), randf())
	var doorPrim = Color(randf(), randf(), randf())
	var doorSeco = Color(randf(), randf(), randf())
	var flagPrim = Color(randf(), randf(), randf())
	var flagSeco = Color(randf(), randf(), randf())
	var ladderPrim = Color(randf(), randf(), randf())
	
	#Read through the map - NOTE THE ORDER OF ROWS/COLS!!!
	for i in range(building_map.size()): #rows, y-dim
		for j in range(building_map[i].size()): #cols, x-dim
			#Figure out coords
			temp_x_coord_map = j + (x_coord_global/tile_size)
			temp_y_coord_map = i + (y_coord_global/tile_size)
			temp_x_coord_global = tile_size * temp_x_coord_map
			temp_y_coord_global = tile_size * temp_y_coord_map
			
			#Choose Item type and Building Array (Top or Bot?)
			#	0 - FLOOR
			#	1 - WALL
			#	2 - BALCONY
			#	3 - DOOR
			#	4 - LADDER
			#	5 - FLAG
			#	6 - DESK
			match(building_map[i][j]):
				0:  #FLOOR
					#Create floor item
					temp_item = Item.instance()
					temp_item.position = Vector2(temp_x_coord_global,temp_y_coord_global)
					game_scene.add_child(temp_item)
					temp_item.setTile(101)
					game_scene.map_buildings[temp_x_coord_map][temp_y_coord_map][z_coord].append(temp_item)
					temp_item.SetPrimColor(floorPrim)
					temp_item.SetSecoColor(floorSeco)
					temp_item.find_node("SelectButton").visible = false
					temp_item.z_index = z_coord - 1
				1:  #WALL
					#Create wall item
					temp_item = Item.instance()
					temp_item.position = Vector2(temp_x_coord_global,temp_y_coord_global)
					game_scene.add_child(temp_item)
					temp_item.setTile(102)
					game_scene.map_buildings[temp_x_coord_map][temp_y_coord_map][z_coord].append(temp_item)
					temp_item.SetPrimColor(wallPrim)
					temp_item.SetSecoColor(wallSeco)
					temp_item.find_node("SelectButton").visible = false
					temp_item.z_index = z_coord - 1
#				2:  #BALCONY
##					temp_item.queue_free()
				3:  #DOOR
					#Create Floor Item first
					temp_item = Item.instance()
					temp_item.position = Vector2(temp_x_coord_global,temp_y_coord_global)
					game_scene.add_child(temp_item)
					temp_item.setTile(101)
					game_scene.map_buildings[temp_x_coord_map][temp_y_coord_map][z_coord].append(temp_item)
					temp_item.SetPrimColor(floorPrim)
					temp_item.SetSecoColor(floorSeco)
					temp_item.find_node("SelectButton").visible = false
					temp_item.z_index = z_coord - 1
					#Then Create Door Item
					temp_item = Item.instance()
					temp_item.position = Vector2(temp_x_coord_global,temp_y_coord_global)
					game_scene.add_child(temp_item)
					temp_item.setTile(103)
					game_scene.map_buildings[temp_x_coord_map][temp_y_coord_map][z_coord].append(temp_item)
					temp_item.SetPrimColor(doorPrim)
					temp_item.SetSecoColor(doorSeco)
					temp_item.z_index = z_coord - 1
				4:  #LADDER
					#Create Floor Item first
					temp_item = Item.instance()
					temp_item.position = Vector2(temp_x_coord_global,temp_y_coord_global)
					game_scene.add_child(temp_item)
					temp_item.setTile(101)
					game_scene.map_buildings[temp_x_coord_map][temp_y_coord_map][z_coord].append(temp_item)
					temp_item.SetPrimColor(floorPrim)
					temp_item.SetSecoColor(floorSeco)
					temp_item.find_node("SelectButton").visible = false
					temp_item.z_index = z_coord - 1
					#Then Create Ladder Item
					temp_item = Item.instance()
					temp_item.position = Vector2(temp_x_coord_global,temp_y_coord_global)
					game_scene.add_child(temp_item)
					temp_item.setTile(104)
					game_scene.map_buildings[temp_x_coord_map][temp_y_coord_map][z_coord].append(temp_item)
					temp_item.SetPrimColor(ladderPrim)
					temp_item.z_index = z_coord - 1
				5:  #FLAG
					#Create floor item first
					temp_item = Item.instance()
					temp_item.position = Vector2(temp_x_coord_global,temp_y_coord_global)
					game_scene.add_child(temp_item)
					temp_item.setTile(101)
					game_scene.map_buildings[temp_x_coord_map][temp_y_coord_map][z_coord].append(temp_item)
					temp_item.SetPrimColor(floorPrim)
					temp_item.SetSecoColor(floorSeco)
					temp_item.find_node("SelectButton").visible = false
					temp_item.z_index = z_coord - 1
					#Then Create Flag Item
					temp_item = Item.instance()
					temp_item.position = Vector2(temp_x_coord_global,temp_y_coord_global)
					game_scene.add_child(temp_item)
					temp_item.setTile(105)
					game_scene.map_buildings[temp_x_coord_map][temp_y_coord_map][z_coord].append(temp_item)
					temp_item.SetPrimColor(flagPrim)
					temp_item.SetSecoColor(flagSeco)
					temp_item.z_index = z_coord - 1
				6:  #DESK
					#Create floor item first
					temp_item = Item.instance()
					temp_item.position = Vector2(temp_x_coord_global,temp_y_coord_global)
					game_scene.add_child(temp_item)
					temp_item.setTile(101)
					game_scene.map_buildings[temp_x_coord_map][temp_y_coord_map][z_coord].append(temp_item)
					temp_item.SetPrimColor(floorPrim)
					temp_item.SetSecoColor(floorSeco)
					temp_item.find_node("SelectButton").visible = false
					temp_item.z_index = z_coord - 1
					

#Function to put down a street block....
#give it the desired block type
#and rotation index
func put_street_block(game_scene, x_coord_global, y_coord_global, z_coord, block_type, rot_type):
	var StreetBlock = load("res://Scenes//StreetBlock.tscn") #Used as a template for making items
	var temp_block = StreetBlock.instance()
	temp_block.position = Vector2(x_coord_global, y_coord_global)
	game_scene.add_child(temp_block)
	game_scene.street_blocks.append(temp_block)
	temp_block.SetTile(block_type)
	temp_block.RotateSprites(rot_type)
	temp_block.SetPrimColor(game_scene.street_prim_col)
	temp_block.SetSecoColor(game_scene.street_seco_col)
	temp_block.SetTertColor(game_scene.street_tert_col)
	temp_block.SetQuadColor(game_scene.street_quad_col)

#Function to put road tiles (but not sidewalks)
#same as above without sidewalks
func put_just_road_block(game_scene, x_coord_global, y_coord_global, z_coord, block_type, rot_type):
	var JustRoadBlock = load("res://Scenes//JustRoadBlock.tscn")
	var temp_block = JustRoadBlock.instance()
	temp_block.position = Vector2(x_coord_global, y_coord_global)
	game_scene.add_child(temp_block)
	game_scene.street_blocks.append(temp_block)
	temp_block.SetTile(block_type)
	temp_block.RotateSprites(rot_type)
	temp_block.SetPrimColor(game_scene.road_prim_col)
	temp_block.SetSecoColor(game_scene.road_seco_col)
	
	
	
	


#FUnction that will layout road tiles down according to an input flowmap
#input the top left corner of flow map
func put_flow_map_street(game_scene, x_coord_global, y_coord_global, z_coord, flow_map):
	for row in flow_map:
		print(row)
		
	
	var tiles_per_road_block = 4 #(a 4x4 square)
	
	for i in flow_map.size(): #the x dim
		for j in flow_map[i].size(): #the y dim
			var temp_x_coord = i * game_scene.find_node("TileMap").cell_size.x * tiles_per_road_block
			var temp_y_coord = j * game_scene.find_node("TileMap").cell_size.y * tiles_per_road_block
			var temp_z_coord = z_coord
			var block_type = flow_map[i][j]
			match(block_type):
				'0000':
					BuildingGen.put_just_road_block(game_scene, temp_x_coord, temp_y_coord, temp_z_coord, 4, 0)
				'0001':
					BuildingGen.put_just_road_block(game_scene, temp_x_coord, temp_y_coord, temp_z_coord, 3, 0)
				'0010':
					BuildingGen.put_just_road_block(game_scene, temp_x_coord, temp_y_coord, temp_z_coord, 3, 2)
				'0011':
					BuildingGen.put_just_road_block(game_scene, temp_x_coord, temp_y_coord, temp_z_coord, 1, 0)
				'0100':
					BuildingGen.put_just_road_block(game_scene, temp_x_coord, temp_y_coord, temp_z_coord, 3, 1)
				'0101':
					BuildingGen.put_just_road_block(game_scene, temp_x_coord, temp_y_coord, temp_z_coord, 2, 1)
				'0110':
					BuildingGen.put_just_road_block(game_scene, temp_x_coord, temp_y_coord, temp_z_coord, 2, 2)
				'0111':
					print("nothing")
				'1000':
					BuildingGen.put_just_road_block(game_scene, temp_x_coord, temp_y_coord, temp_z_coord, 3, 3)
				'1001':
					BuildingGen.put_just_road_block(game_scene, temp_x_coord, temp_y_coord, temp_z_coord, 2, 0)
				'1010':
					BuildingGen.put_just_road_block(game_scene, temp_x_coord, temp_y_coord, temp_z_coord, 2, 3)
				'1011':
					print("nothing")
				'1100':
					BuildingGen.put_just_road_block(game_scene, temp_x_coord, temp_y_coord, temp_z_coord, 1, 1)
				'1101':
					print("nothing")
				'1110':
					print("nothing")
				'1111':
					print("nothing")
				'XXXX':
					print("nothing")
