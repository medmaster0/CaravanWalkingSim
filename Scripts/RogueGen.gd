extends Node

# Generate the Datamap
#Returns a 2D array (X,Y) of coordinates to place clouds
#array contains:
# 0 - cloud
# 2 - empty
func GenerateClouds(map_size):
	randomize()
	
#	#INitialize!
#	var map = []
#	var empty_id = 2
#	var cloud_id = 0
	
#	#Populate empty map array
#	for x in range( map_size.x ): 
#		var column = []
#		for y in range(map_size.y):
#			column.append(empty_id)
#		map.append(column)
#
#
	
	#Add a few rows of clouds
	#These are the settings
	var num_clouds = randi()%3+3
	#These are the temp variables
	var cloud_length
	var cloud_x 
	var cloud_y = int(map_size.y/4)
	#Create a list (of dictionaries for each cloud)
	var clouds = []
	
	#For each cloud we need to create...
	for cloud_iter in range( num_clouds ):
		#Roll new cloud params
		cloud_length = randi()%6+10
		cloud_x = randi()%int(2*map_size.x/3)
		#cloud_y = randi()%int(map_size.y/3) + map_size.y/3
		cloud_y = cloud_y + randi()%4 + 2
		#Add that info to the disctionary list
		clouds.append( 
			{
				"length": cloud_length,
				"x": cloud_x,
				"y": cloud_y
			}
		)
	
#	#Set map cells based on clouds
#	for cloud in clouds:
#		#Cycle acrosst length
#		for x_iter in range(cloud.length):
#			map[cloud.x+x_iter][cloud.y] = cloud_id
	
	return clouds
	
	
	
# Generate a pattern of rectangular rooms
#returns a dicitonary to...
# map : individual pixel data in a 2D array, XY-accessed
# rooms : a list of Rect2 
func GenerateVault_v1(map_size):
	randomize()
	
	var map = [] #the main map (2D array) that we will return map[x][y]
	var num_rooms = 9 #How many rooms we have
	var blank_id = 0 #The ID for empty tiles
	var floor_id = 1 #The ID for Floor tiles
	var wall_id = 2 #The ID for Wall tiles
	
	
	#Initialize map 2D array
	for x in range(map_size.x):
		var column = [] #empty array
		for y in range(map_size.y):
			column.append(blank_id)
		map.append(column)
	
	#Create the rooms
	var rooms = [] #a list of room rectangles
	for room in range(num_rooms):
		#random parameters
		var length = randi()%3+5
		var x = randi()%int(map_size.x-length-2-2)+2
		var height = randi()%3+5
		var y = randi()%int(map_size.y-height-2-2)+2
		var temp_room = Rect2(x-1, y-1, length+1, height+1)
		
		#check if this room intersects any of the other ones...
		var does_intersect = false
		if !rooms.empty():
			for other_room in rooms:
				if temp_room.intersects(other_room):
					does_intersect = true
					print("inter")
					
		if does_intersect == false:
			#But if we made it here, it didn't intersect, so add it
			rooms.append(temp_room)
			
			#Carve out the room
			for tx in range(length):
				for ty in range(height):
					#Set the proper codes
					map[x+tx][y+ty] = floor_id
					
			#Also do the walls
			#TOP WALL & BOTTOM
			for tx in range(length+2):
				map[x+tx-1][y-1] = wall_id
				map[x+tx-1][y+height] = wall_id
			#LEFT AND RIGHTY
			for ty in range(height+1):
				map[x-1][y+ty-1] = wall_id
				map[x+length][y+ty-1] = wall_id

	#Create a path between the rooms
	var counter = 0
	for room in rooms:

		var random_point = inside_rect(room)
		#map[random_point.x][random_point.y] = 0
		var random_point2 = inside_rect(rooms[counter-1])
		#map[random_point2.x][random_point2.y] = wall_id

		#Now we can either go:
		var rand_choice = randi()%2
		match rand_choice:
			0:
				#Horizontal first, then vertical
				map = h_path(random_point.x, random_point2.x, random_point.y, map)
				map = v_path(random_point.y, random_point2.y, random_point2.x, map)
				
				#We need to ensure the "elbow joints" of the two paths are covered in walls	
				#Occurs at [random_point2.x][random_point.y]
				if map[random_point2.x-1][random_point.y-1] != floor_id:
					map[random_point2.x-1][random_point.y-1] = wall_id
					
				if map[random_point2.x+1][random_point.y+1] != floor_id:
					map[random_point2.x+1][random_point.y+1] = wall_id
					
				if map[random_point2.x-1][random_point.y+1] != floor_id:
					map[random_point2.x-1][random_point.y+1] = wall_id
					
				if map[random_point2.x+1][random_point.y-1] != floor_id:
					map[random_point2.x+1][random_point.y-1] = wall_id
				
				
				
				
			1:
				#Vertical first, then vertical
				map = v_path(random_point.y, random_point2.y, random_point.x, map)
				map = h_path(random_point.x, random_point2.x, random_point2.y, map)
				
				#We need to ensure the "elbow joints" of the two paths are covered in walls	
				#Occurs at [random_point.x][random_point2.y]
				if map[random_point.x-1][random_point2.y-1] != floor_id:
					map[random_point.x-1][random_point2.y-1] = wall_id
					
				if map[random_point.x+1][random_point2.y+1] != floor_id:
					map[random_point.x+1][random_point2.y+1] = wall_id
					
				if map[random_point.x-1][random_point2.y+1] != floor_id:
					map[random_point.x-1][random_point2.y+1] = wall_id
					
				if map[random_point.x+1][random_point2.y-1] != floor_id:
					map[random_point.x+1][random_point2.y-1] = wall_id

				
				
				
			
		
		counter = counter + 1
		
	var map_data = {
		
		"map": map,
		"rooms": rooms
		
		}
	
	return(map_data)
	
#Find a random point in a rectangle
func inside_rect(rect):
	var rx = rect.position.x + randi()%int(rect.size.x-1) + 1
	var ry = rect.position.y + randi()%int(rect.size.y-1) + 1
	var return_vect = Vector2(rx,ry)
	return(return_vect)
	
#Carve out a path (walls and floors) of a horizontal line in the given map
func h_path(x1, x2, y, map):
	
	#Check to make sure they are ordered correctly
	if(x1>x2):
		var temp_x = x2
		x2 = x1
		x1 = temp_x
		
	#Go through and fill out the points
	for i in range(x1,x2+1):
		#Set cell
		map[i][y] = 1
		
		#Possibly make the surrounding tiles walls
		#As long as it's not a floor
		if map[i][y-1] != 1:
			map[i][y-1] = 2
		if map[i][y+1] != 1:
			map[i][y+1] = 2
		
	return(map)
	
#Carve out a path (walls and floors) of a horizontal line in the given map
func v_path(y1, y2, x, map):
	
	#Check to make sure they are ordered correctly
	if(y1>y2):
		var temp_y = y2
		y2 = y1
		y1 = temp_y
	
	#Go through and fill out the points
	for i in range(y1,y2+1):
		
		map[x][i] = 1
		
		#Possibly make the surrounding tiles walls
		#As long as it's not a floor
		if map[x-1][i] != 1:
			map[x-1][i] = 2
		if map[x+1][i] != 1:
			map[x+1][i] = 2
		
	return(map)
	
	
#Generate Bank Layout
func GenerateBank(map_size):
	randomize()
	
	var map = [] #the main map (2D array) that we will return map[x][y]
	var num_rooms = 9 #How many rooms we have
	var blank_id = 0 #The ID for empty tiles
	var floor_id = 1 #The ID for Floor tiles
	var wall_id = 2 #The ID for Wall tiles
	var window_id = 3 #The ID for Window tiles
	var back_floor_id = 4 #A different ID for floors of a different color
	
	#Initialize map 2D array
	for x in range(map_size.x):
		var column = [] #empty array
		for y in range(map_size.y):
			column.append(blank_id)
		map.append(column)
		
	#Determine starting point of room rect
	var x0 = 10
	var y0 = 15
	var width = 40
	var height = 15
	#Determine a random window pattern
	var window_interval = randi()%6 + 1 + 1 #how often windows appear
	#var window_run = randi()%window_interval + 1 #how long the window will be
	var window_run = window_interval - 1 #how long the window will be
	# oXXoXXoXXo - interval: 3 run: 2
	# oXoooXoooX - interval: 4 run: 1
	
	#Set the floor space
	for i in range(width):
		for j in range(height):
			map[x0+i][y0+j] = floor_id
			
	#Put a row for counter (walls)
	for i in range(width):
		map[x0+i][y0-1] = wall_id
	
	#Put some floor space behind the counter
	for i in range(width):
		for j in range(7):
			map[x0+i][y0-j-3] = back_floor_id
	
	#Put a random window pattern
	#(start with a row of wall)
	for i in range(width):
		map[x0+i][y0-2] = wall_id
	#Then carve out the window tiles
	for i in range(width):
		if i%window_interval==0: #Every interval start a window
			for r in range(window_run):
				if i+r < width: #make sure it doesn't extend bounds of width
					map[x0+i+r][y0-2] = window_id
	
	return map
	

#Generate Corridor Maze
#Inspired by moititi
# 0 - Empty Space
# 1 - Brick Space
# Access maze[row][col]
func GenerateCorridorMaze(num_rows, num_cols, num_inner_walls):
	
	randomize()
	
	var maze = [] #2D Array, with maze tiles to return
	#Intialize array with alternating rows of 0 and 1
	for i in range(num_rows):
		maze.append([])
		if i%2 == 0: #if even
			for j in range(num_cols):
				maze[i].append(0)
		else: #if odd
			for j in range(num_cols):
				maze[i].append(1)
	
	#Need to place walls in the middle of the empty rows (have 0s)
	#And also keep track of them!
	var empty_row_wall_locs = [] #2d list of positions where the walls are (doesn't have any for brick rows)
	for i in range(num_rows): #iterate over the rows
		if i%2!=0: #Skip the row if it's a brick wall
			continue 
		else: #otherwise, Now, we're accessing an empty row
			var walls = [] #list of col indices where wall is
			for w in range(num_inner_walls):
				# w + randi()%num_inner_walls/num_rows
				var wall_col #this is the col index of the tile that (will) become(s) a wall
				wall_col = w*(num_cols/num_inner_walls) + randi()%((num_cols/num_inner_walls) - 1)
				walls.append(wall_col)
				#Finally, set the tile to be a wall
				maze[i][wall_col] = 1
			empty_row_wall_locs.append(walls)
	#empty_row_wall_locs will have list (for each row) of list
	
	#Now with walls placed, we can decide where to put openings in brick walls
	for i in range(num_rows):
		if i%2==0: #Skip the row if it's an empty row
			continue
		else: #otherwise, now, we're accessing a brick row
			#Determine where the walls were in the adjacent empty rows...
			var adj_walls = [] #list of col indices where a wall appears in adjacent rows
			#Add the wall col_indices from empty row, above (if applicable)
			var above_row_index = floor(i/2.0)
			if above_row_index >= 0: #bounds check
				for w in empty_row_wall_locs[above_row_index]: #Copy all the indices 
					adj_walls.append(w) 
			#Add the wall col_indices from the empty row, below (if applicable)
			var below_row_index = ceil(i/2.0)
			if below_row_index < empty_row_wall_locs.size(): #bounds check
				for w in empty_row_wall_locs[below_row_index]: #Copy all the indices
					adj_walls.append(w)
			#Now adj_walls has the full list of col indices of adj walls
			#But we should sort them...
			adj_walls.sort_custom(self, "int_array_sort")
			
			#Now we place random openings between each wall
			#Before First
			if(adj_walls[0] > 1): #make sure there's enough room
				var d = randi()%(adj_walls[0]-1) + 1#Pick a random spot for it
				maze[i][d] = 0 #set the opening in the maze
			#Between Intermediate Walls
			for c in range(adj_walls.size()-1):
				if(adj_walls[c+1] - adj_walls[c]) > 1: #Make sure there's enough room
					var d = randi()%(adj_walls[c+1] - adj_walls[c] - 1) + adj_walls[c] + 1#pick a random spot for it
					maze[i][d] = 0 #set the opening in the maze
			#After Last
			if(num_cols - adj_walls[adj_walls.size()-1]) > 1:
				var d = randi()%(num_cols - adj_walls[adj_walls.size()-1] - 1) + adj_walls[adj_walls.size()-1] + 1
				maze[i][d] = 0 #set the opening in the maze
	
	return(maze)

#Utility function used to sort int array
func int_array_sort(a,b):
	return a < b
	
	

#Generate Flow Map
#Reads in a maze array (2D, 0 for empty, 1 for blocked)
#REturns an identically sized array
#But each cell contains a value from 0 - 15
#One of the possible combinations of
# UP   DOWN   LEFT  RIGHT
# 0 	0		0		0
# 0		0		0		1
# ......
# 1		1		1		1
func DetermineFlowMap(maze_map):
	
	print("")
	
	var flow_map = [] #the flow map we return
	
	#Copy the maze_map
	var x_dim = maze_map.size()
	var y_dim = maze_map[0].size()
	for i in range(x_dim):
		var row = []
		for j in range(y_dim):
			row.append(0)
		flow_map.append(row)
		
	#Iterate through the flow map
	var check_x #index to check maze_map
	var check_y #index to check maze_map
	var isBlock = false #flag used to check if the flow is blocked in that direction
	for i in range(x_dim): #x dim
		for j in range(y_dim): #y dim
		
			#Construct the string "0000" to "1111" bit-by-bit
			var flow_code = ""
			
			#If the tile is blocked, then write 1111 to it
			if maze_map[i][j] == 1:
				flow_code = "XXXX"
				flow_map[i][j] = flow_code
				continue
			
			#UP
			check_x = i
			check_y = j - 1
			#First bounds check
			if check_y < 0:
				flow_code = flow_code + "1"
			else:
				#Then Check if blocked
				if maze_map[check_x][check_y] == 1:
					flow_code = flow_code + "1"
				else:
					flow_code = flow_code + "0"
				
			#DOWN
			check_x = i
			check_y = j + 1
			#First bounds check
			if check_y >= y_dim:
				flow_code = flow_code + "1"
			else:
				#Then Check if blocked
				if maze_map[check_x][check_y] == 1:
					flow_code = flow_code + "1"
				else:
					flow_code = flow_code + "0"
			
			#LEFT
			check_x = i - 1
			check_y = j
			#First bounds check
			if check_x < 0:
				flow_code = flow_code + "1"
			else:
				#Then Check if blocked
				if maze_map[check_x][check_y] == 1:
					flow_code = flow_code + "1"
				else:
					flow_code = flow_code + "0"
				
			#RIGHT
			check_x = i + 1
			check_y = j
			#First bounds check
			if check_x >= x_dim:
				flow_code = flow_code + "1"
			else:
				#Then Check if blocked
				if maze_map[check_x][check_y] == 1:
					flow_code = flow_code + "1"
				else:
					flow_code = flow_code + "0"

			#Enter the flow code...
			flow_map[i][j] = flow_code
			
	return(flow_map)
