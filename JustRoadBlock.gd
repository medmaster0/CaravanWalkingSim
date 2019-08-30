extends Node2D

#Load the necessary sprites, before hand
#var endPrim = preload("res://Tiles//street//justRoad//EndPrim.png")
#var endSeco = preload("res://Tiles//street//justRoad//EndSeco.png")

var straightPrim = preload("res://Tiles//street//justRoad//STRAIGHTPrim.png")
var straightSeco = preload("res://Tiles//street//justRoad//STRAiGHTSeco.png")

var elbowPrim = preload("res://Tiles//street//justRoad//ELBOWPrim.png")
var elbowSeco = preload("res://Tiles//street//justRoad//ELBOWSeco.png")

var triPrim = preload("res://Tiles//street//justRoad//TRIPrim.png")
var triSeco = preload("res://Tiles//street//justRoad//TRISeco.png")

var fourwayPrim = preload("res://Tiles//street//justRoad//QUADPrim.png")
var fourwaySeco = preload("res://Tiles//street//justRoad//QUADSeco.png")


#Class Variables
var tile_index
var primCol
var secoCol

#TILE INDEX CORRESPONDS TO:
# 0 - END
# 1 - STRAIGHT
# 2 - ELBOW
# 3 - TRI
# 4 - FOURWAY
# 5 - SURROUND

# Called when the node enters the scene tree for the first time.
func _ready():
	
	randomize()
	
	tile_index = 1 + randi()%4
	SetTile(tile_index)
	
	primCol = Color(randf(),randf(),randf())
	secoCol = Color(randf(),randf(),randf())
	SetPrimColor(primCol)
	SetSecoColor(secoCol)

	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

#CLASS FUNCS
func SetPrimColor(color):
	primCol = color
	$Prim.modulate = primCol

func SetSecoColor(color):
	secoCol = color
	$Seco.modulate = secoCol
	

#Set the tile index based on input code
func SetTile(in_tile_index):
	tile_index = in_tile_index
	match tile_index:
#		0: #End
#			$Prim.texture = endPrim
#			$Seco.texture = endSeco
#			$Tert.texture = endTert
#			$Quad.texture = endQuad
		1: #Straight
			$Prim.texture = straightPrim
			$Seco.texture = straightSeco
		2: #Elbow
			$Prim.texture = elbowPrim
			$Seco.texture = elbowSeco
		3: #Tri
			$Prim.texture = triPrim
			$Seco.texture = triSeco
		4: #Fourway
			$Prim.texture = fourwayPrim
			$Seco.texture = fourwaySeco



#Function to rotate the items...
#Will preserve the position, but will change the sprite offsets
#Code:
# 0 - 0 degrees
# 1 - 90
# 2 - 180
# 3 - -90
# 4 - Flip H <>
# 5 - Flip V ^ v
# 6 - Flip Origin
# 7 - Flip Reverse Origin
func RotateSprites(rotation_code):
	
	match(rotation_code):
		0:
			#Adjust the rotation
			$Prim.rotation_degrees = 0
			$Seco.rotation_degrees = 0
			#Adjust the offset 
			$Prim.offset = Vector2(0,0)
			$Seco.offset = $Prim.offset
		1:
			#Adjust the rotation
			$Prim.rotation_degrees = 90
			$Seco.rotation_degrees = 90
			#Adjust the offset 
			$Prim.offset = Vector2(0,-64)
			$Seco.offset = $Prim.offset
		2:
			#Adjust the rotation
			$Prim.rotation_degrees = 180
			$Seco.rotation_degrees = 180
			#Adjust the offset 
			$Prim.offset = Vector2(-64,-64)
			$Seco.offset = $Prim.offset
		3:
			#Adjust the rotation
			$Prim.rotation_degrees = -90
			$Seco.rotation_degrees = -90
			#Adjust the offset 
			$Prim.offset = Vector2(-64,0)
			$Seco.offset = $Prim.offset
		4:
			#Flip Horizontal < >
			$Prim.flip_h = !$Prim.flip_h
			$Seco.flip_h = !$Seco.flip_h
		5:
			#Flip Vert ^ v
			$Prim.flip_v = !$Prim.flip_v
			$Seco.flip_v = !$Seco.flip_v
		6:
			#First flip, then rotate 90
			$Prim.flip_v = !$Prim.flip_v
			$Prim.rotation_degrees = 90
			$Prim.offset = Vector2(0,-64)
			$Seco.flip_v = !$Seco.flip_v
			$Seco.rotation_degrees = 90
			$Seco.offset = Vector2(0,-64)

		7:
			#First flip, then rotate -90
			$Prim.flip_v = !$Prim.flip_v
			$Prim.rotation_degrees = -90
			$Prim.offset = Vector2(-64,0)
			$Seco.flip_v = !$Seco.flip_v
			$Seco.rotation_degrees = -90
			$Seco.offset = Vector2(-64,0)