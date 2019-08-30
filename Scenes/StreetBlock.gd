extends Node2D

#Load the necessary sprites, before hand
var endPrim = preload("res://Tiles//street//fullBlock//EndPrim.png")
var endSeco = preload("res://Tiles//street//fullBlock//EndSeco.png")
var endTert = preload("res://Tiles//street//fullBlock//EndTert.png")
var endQuad = preload("res://Tiles//street//fullBlock//EndQuad.png")

var straightPrim = preload("res://Tiles//street//fullBlock//StraightPrim.png")
var straightSeco = preload("res://Tiles//street//fullBlock//StraightSeco.png")
var straightTert = preload("res://Tiles//street//fullBlock//StraightTert.png")
var straightQuad = preload("res://Tiles//street//fullBlock//StraightQuad.png")

var elbowPrim = preload("res://Tiles//street//fullBlock//ElbowPrim.png")
var elbowSeco = preload("res://Tiles//street//fullBlock//ElbowSeco.png")
var elbowTert = preload("res://Tiles//street//fullBlock//ElbowTert.png")
var elbowQuad = preload("res://Tiles//street//fullBlock//ElbowQuad.png")

var triPrim = preload("res://Tiles//street//fullBlock//TriPrim.png")
var triSeco = preload("res://Tiles//street//fullBlock//TriSeco.png")
var triTert = preload("res://Tiles//street//fullBlock//TriTert.png")
var triQuad = preload("res://Tiles//street//fullBlock//TriQuad.png")

var fourwayPrim = preload("res://Tiles//street//fullBlock//FourwayPrim.png")
var fourwaySeco = preload("res://Tiles//street//fullBlock//FourwaySeco.png")
var fourwayTert = preload("res://Tiles//street//fullBlock//FourwayTert.png")
var fourwayQuad = preload("res://Tiles//street//fullBlock//FourwayQuad.png")

var surroundTert = preload("res://Tiles//street//fullBlock//SurroundTert.png")
var surroundQuad = preload("res://Tiles//street//fullBlock//SurroundQuad.png")

#Class Variables
var tile_index
var primCol
var secoCol
var tertCol
var quadCol

#TILE INDEX CORRESPONDS TO:
# 0 - END
# 1 - STRAIGHT
# 2 - ELBOW
# 3 - TRI
# 4 - FOURWAY
# 5 - SURROUND

# Called when the node enters the scene tree for the first time.
func _ready():
	
	tile_index = randi()%5
	SetTile(tile_index)
	
	primCol = Color(randf(),randf(),randf())
	secoCol = Color(randf(),randf(),randf())
	tertCol = Color(randf(),randf(),randf())
	quadCol = Color(randf(),randf(),randf())
	SetPrimColor(primCol)
	SetSecoColor(secoCol)
	SetTertColor(tertCol)
	SetQuadColor(quadCol)
	
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
	
func SetTertColor(color):
	tertCol = color
	$Tert.modulate = tertCol
	
func SetQuadColor(color):
	quadCol = color
	$Quad.modulate = quadCol

#Set the tile index based on input code
func SetTile(in_tile_index):
	tile_index = in_tile_index
	match tile_index:
		0: #End
			$Prim.texture = endPrim
			$Seco.texture = endSeco
			$Tert.texture = endTert
			$Quad.texture = endQuad
		1: #Straight
			$Prim.texture = straightPrim
			$Seco.texture = straightSeco
			$Tert.texture = straightTert
			$Quad.texture = straightQuad
		2: #Elbow
			$Prim.texture = elbowPrim
			$Seco.texture = elbowSeco
			$Tert.texture = elbowTert
			$Quad.texture = elbowQuad
		3: #Tri
			$Prim.texture = triPrim
			$Seco.texture = triSeco
			$Tert.texture = triTert
			$Quad.texture = triQuad
		4: #Fourway
			$Prim.texture = fourwayPrim
			$Seco.texture = fourwaySeco
			$Tert.texture = fourwayTert
			$Quad.texture = fourwayQuad
		5:
			#Surround
			$Prim.texture = null
			$Seco.texture = null
			$Tert.texture = surroundTert
			$Quad.texture = surroundQuad


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
			$Tert.rotation_degrees = 0
			$Quad.rotation_degrees = 0
			#Adjust the offset 
			$Prim.offset = Vector2(0,0)
			$Seco.offset = $Prim.offset
			$Tert.offset = $Prim.offset
			$Quad.offset = $Prim.offset
		1:
			#Adjust the rotation
			$Prim.rotation_degrees = 90
			$Seco.rotation_degrees = 90
			$Tert.rotation_degrees = 90
			$Quad.rotation_degrees = 90
			#Adjust the offset 
			$Prim.offset = Vector2(0,-128)
			$Seco.offset = $Prim.offset
			$Tert.offset = $Prim.offset
			$Quad.offset = $Prim.offset
		2:
			#Adjust the rotation
			$Prim.rotation_degrees = 180
			$Seco.rotation_degrees = 180
			$Tert.rotation_degrees = 180
			$Quad.rotation_degrees = 180
			#Adjust the offset 
			$Prim.offset = Vector2(-128,-128)
			$Seco.offset = $Prim.offset
			$Tert.offset = $Prim.offset
			$Quad.offset = $Prim.offset
		3:
			#Adjust the rotation
			$Prim.rotation_degrees = -90
			$Seco.rotation_degrees = -90
			$Tert.rotation_degrees = -90
			$Quad.rotation_degrees = -90
			#Adjust the offset 
			$Prim.offset = Vector2(-128,0)
			$Seco.offset = $Prim.offset
			$Tert.offset = $Prim.offset
			$Quad.offset = $Prim.offset
		4:
			#Flip Horizontal < >
			$Prim.flip_h = !$Prim.flip_h
			$Seco.flip_h = !$Seco.flip_h
			$Tert.flip_h = !$Tert.flip_h
			$Quad.flip_h = !$Quad.flip_h
		5:
			#Flip Vert ^ v
			$Prim.flip_v = !$Prim.flip_v
			$Seco.flip_v = !$Seco.flip_v
			$Tert.flip_v = !$Tert.flip_v
			$Quad.flip_v = !$Quad.flip_v
		6:
			#First flip, then rotate 90
			$Prim.flip_v = !$Prim.flip_v
			$Prim.rotation_degrees = 90
			$Prim.offset = Vector2(0,-128)
			$Seco.flip_v = !$Seco.flip_v
			$Seco.rotation_degrees = 90
			$Seco.offset = Vector2(0,-128)
			$Tert.flip_v = !$Tert.flip_v
			$Tert.rotation_degrees = 90
			$Tert.offset = Vector2(0,-128)
			$Quad.flip_v = !$Quad.flip_v
			$Quad.rotation_degrees = 90
			$Quad.offset = Vector2(0,-128)
		7:
			#First flip, then rotate -90
			$Prim.flip_v = !$Prim.flip_v
			$Prim.rotation_degrees = -90
			$Prim.offset = Vector2(-128,0)
			$Seco.flip_v = !$Seco.flip_v
			$Seco.rotation_degrees = -90
			$Seco.offset = Vector2(-128,0)
			$Tert.flip_v = !$Tert.flip_v
			$Tert.rotation_degrees = -90
			$Quad.offset = Vector2(-128,0)
			$Quad.flip_v = !$Quad.flip_v
			$Quad.rotation_degrees = -90
			$Tert.offset = Vector2(-128,0)