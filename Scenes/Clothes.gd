extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var tile_index #the index of the clothes it's wearing

#globals used to keep track of colors....
#set in the set_tile_index function!!!
var primColor
var secoColor
var tertColor
var quadColor

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	
	tile_index = randi()%20
	#tile_index = 19
	set_tile_index(tile_index)
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


#Function to set the tile index
func set_tile_index(index):
	print("this isets")
	match(index):
		0:
			#Angel... No need to set colors
			get_child(index).visible = true
		1:
			#Bandana
			primColor = Color(randf(), randf(), randf())
			secoColor = Color(randf(), randf(), randf())
			get_child(index).find_node("Prim").modulate = primColor
			get_child(index).find_node("Seco").modulate = secoColor
			get_child(index).visible = true
		2:
			#BigBow
			primColor = Color(randf(), randf(), randf())
			secoColor = Color(randf(), randf(), randf())
			tertColor = Color(randf(), randf(), randf())
			get_child(index).find_node("Prim").modulate = primColor
			get_child(index).find_node("Seco").modulate = secoColor
			get_child(index).find_node("Tert").modulate = tertColor
			get_child(index).visible = true
		3:
			#Cap
			primColor = Color(randf(), randf(), randf())
			secoColor = Color(randf(), randf(), randf())
			get_child(index).find_node("Prim").modulate = primColor
			get_child(index).find_node("Seco").modulate = secoColor
			get_child(index).visible = true
		4:
			#Crown
			primColor = Color(randf(), randf(), randf())
			secoColor = Color(randf(), randf(), randf())
			get_child(index).find_node("Prim").modulate = primColor
			get_child(index).find_node("Seco").modulate = secoColor
			get_child(index).visible = true
		5:
			#Demon... No need to set colors
			get_child(index).visible = true
		6:
			#Doc
			primColor = MedAlgo.generate_pastel()
			secoColor = MedAlgo.generate_brown()
			get_child(index).find_node("Prim").modulate = primColor
			get_child(index).find_node("Seco").modulate = secoColor
			get_child(index).visible = true
		7:
			#FeatherHat
			primColor = Color(randf(), randf(), randf())
			secoColor = MedAlgo.generate_brown()
			tertColor = Color(randf(), randf(), randf())
			quadColor = Color(randf(), randf(), randf())
			get_child(index).find_node("Prim").modulate = primColor
			get_child(index).find_node("Seco").modulate = secoColor
			get_child(index).find_node("Tert").modulate = tertColor
			get_child(index).find_node("Quad").modulate = quadColor
			get_child(index).visible = true
		8:
			#Hood
			primColor = Color(randf(), randf(), randf())
			secoColor = Color(randf(), randf(), randf())
			get_child(index).find_node("Prim").modulate = primColor
			get_child(index).find_node("Seco").modulate = secoColor
			get_child(index).visible = true
		9:
			#Jester
			primColor = MedAlgo.generate_gold()
			##primColor = Color(randf(), randf(), randf())
			secoColor = Color(randf(), randf(), randf())
			tertColor = Color(randf(), randf(), randf())
			get_child(index).find_node("Prim").modulate = primColor
			get_child(index).find_node("Seco").modulate = secoColor
			get_child(index).find_node("Tert").modulate = tertColor
			get_child(index).visible = true
		10:
			#LilBow
			primColor = Color(randf(), randf(), randf())
			secoColor = Color(randf(), randf(), randf())
			get_child(index).find_node("Prim").modulate = primColor
			get_child(index).find_node("Seco").modulate = secoColor
			get_child(index).visible = true
		11:
			#Masq
			primColor = Color(randf(), randf(), randf())
			secoColor = MedAlgo.oppositeColor(primColor)
			get_child(index).find_node("Prim").modulate = primColor
			get_child(index).find_node("Seco").modulate = secoColor
			get_child(index).visible = true
		12:
			#Mohawk
			primColor = Color(randf(), randf(), randf())
			secoColor = Color(randf(), randf(), randf())
			get_child(index).find_node("Prim").modulate = primColor
			get_child(index).find_node("Seco").modulate = secoColor
			get_child(index).visible = true
		13:
			#Nurse
			primColor = Color(1,1,1)
			secoColor = Color(randf(), randf(), randf())
			get_child(index).find_node("Prim").modulate = primColor
			get_child(index).find_node("Seco").modulate = secoColor
			get_child(index).visible = true
		14:
			#Parasol Hat
			primColor = Color(randf(), randf(), randf())
			secoColor = Color(randf(), randf(), randf())
			tertColor = Color(randf(), randf(), randf())
			get_child(index).find_node("Prim").modulate = primColor
			get_child(index).find_node("Seco").modulate = secoColor
			get_child(index).find_node("Tert").modulate = tertColor
			get_child(index).visible = true
		15:
			#Tie
			primColor = Color(randf(), randf(), randf())
			get_child(index).find_node("Prim").modulate = primColor
			get_child(index).visible = true
		16:
			#LilBow
			primColor = Color(randf(), randf(), randf())
			secoColor = Color(randf(), randf(), randf())
			get_child(index).find_node("Prim").modulate = primColor
			get_child(index).find_node("Seco").modulate = secoColor
			get_child(index).visible = true
		17:
			#LilBow
			primColor = MedAlgo.generate_gold()
			secoColor = Color(randf(), randf(), randf())
			tertColor = Color(randf(), randf(), randf())
			get_child(index).find_node("Prim").modulate = primColor
			get_child(index).find_node("Seco").modulate = secoColor
			get_child(index).find_node("Tert").modulate = tertColor
			get_child(index).visible = true
		18:
			#Witch
			primColor = Color(randf(), randf(), randf())
			secoColor = Color(randf(), randf(), randf())
			tertColor = Color(randf(), randf(), randf())
			get_child(index).find_node("Prim").modulate = primColor
			get_child(index).find_node("Seco").modulate = secoColor
			get_child(index).find_node("Tert").modulate = tertColor
			get_child(index).visible = true
		19:
			#Witch Doc... No need to set colors
			get_child(index).visible = true