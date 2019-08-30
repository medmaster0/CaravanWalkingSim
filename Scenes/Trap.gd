extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	
	randomize()
	
	#Make sure LaidTrap is visible to start
	$LaidSprite.visible = true; 
	
	#Add color
	#$LaidSprite.modulate = Color(randf(), randf(), randf())


	
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func setTrap(set_color = Color(randf(), randf(), randf())):
	#set visible/invisible sprites
	$LaidSprite.visible = false; 
	$SprungSpriteSeco.visible = true; 
	$SprungSpritePrim.visible = true; 
	
	#set color of ribbon
	$SprungSpriteSeco.modulate = set_color; 