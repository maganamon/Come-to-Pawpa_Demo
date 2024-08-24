extends Node

var pause_menu_instance = null
signal player_died()

func _ready():
	# Preload the PauseMenu scene using the correct path
	var pause_menu_scene = preload("res://Scenes/Menu_Scenes/pause_menu.tscn")
	
	# Ensure pause_menu_scene is a valid PackedScene
	if pause_menu_scene is PackedScene:
		print("pause menu scene valid")
	else:
		print("Error: Could not preload scene. Check the path.")
