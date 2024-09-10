extends Node

var pause_menu_instance = null
var kill_counter = 0
var LevelOne_Time = 120.0
var PLAYER_GPS = null
var PLAYER_HP = 100

## Sound Signals ##
signal player_died()
signal enemy_hit()
signal shot_fired()
signal player_hit()
signal projEnemy_shot()
signal hurtDog()
## Sound Signals END ##

func _ready():
	# Preload the PauseMenu scene using the correct path
	var pause_menu_scene = preload("res://Scenes/Menu_Scenes/pause_menu.tscn")
	
	# Ensure pause_menu_scene is a valid PackedScene
	if pause_menu_scene is PackedScene:
		print("pause menu scene valid")
	else:
		print("Error: Could not preload scene. Check the path.")
