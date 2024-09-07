extends Node

var currentLevel = 1
var pause_menu_instance = null
var kill_counter = 0
var LevelOne_Time = 12.0
var LevelTwo_Time = 140.0
var PLAYER_GPS = null
var PLAYER_HP = 100
var PLAYER_ENERGY = 15
var dogHealth = 1

## Sound Signals ##
signal player_died()
signal enemy_hit()
signal shot_fired()
signal over_Heat()
signal player_hit()
signal projEnemy_shot()
signal hurtDog()
 # Transition Black Screen Signals
signal No_BlkScreen()
signal Yes_BlkScreen()
signal endTransition()
 #
## Sound Signals END ##

func _ready():
	# Preload the PauseMenu scene using the correct path
	var pause_menu_scene = preload("res://Scenes/Menu_Scenes/GUI_Bits/pause_menu.tscn")
	
	# Ensure pause_menu_scene is a valid PackedScene
	if pause_menu_scene is PackedScene:
		print("pause menu scene valid")
	else:
		print("Error: Could not preload scene. Check the path.")
		
func _giveMe_LevelTime():
	if currentLevel == 1:
		return LevelOne_Time
	elif currentLevel == 2:
		return LevelTwo_Time
