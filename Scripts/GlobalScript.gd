extends Node

var is_game_paused = false
var pause_menu_instance = null

func _ready():
	# Preload the PauseMenu scene using the correct path
	var pause_menu_scene = preload("res://Scenes/Menu_Scenes/pause_menu.tscn")
	
	# Ensure pause_menu_scene is a valid PackedScene
	if pause_menu_scene is PackedScene:
		pause_menu_instance = pause_menu_scene.instantiate()
		pause_menu_instance.hide()  # Hide it initially
		add_child(pause_menu_instance)
	else:
		print("Error: Could not preload scene. Check the path.")

func _input(event):
	# Handle pause input even when the game is paused
	if event.is_action_pressed("pause_menu"):
		if is_game_paused:
			unpause_game()
		else:
			pause_game()

func pause_game():
	pause_menu_instance.show() 
	is_game_paused = true
	get_tree().paused = true  # Pause the game

func unpause_game():
	pause_menu_instance.hide()  # Hide the pause menu
	is_game_paused = false
	get_tree().paused = false  # Unpause the game
