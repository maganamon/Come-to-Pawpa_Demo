extends Control

var is_game_paused = false

func _ready():
	# Connect signals for buttons
	hide()
	var resume_button = $MarginContainer/VBoxContainer/ResumeButton
	var quit_button = $MarginContainer/VBoxContainer/QuitButton
	
	# Check if buttons are valid
	if resume_button and quit_button:
		resume_button.connect("pressed", Callable(self, "_on_resume_button_pressed"))
		quit_button.connect("pressed", Callable(self, "_on_quit_button_pressed"))
	else:
		print("Error: Buttons not found or not correctly set up.")

func _input(event):
	# Handle pause input even when the game is paused
	if event.is_action_pressed("pause_menu"):
		if is_game_paused:
			unpause_game()
		else:
			pause_game()

func pause_game():
	show() #show menu
	is_game_paused = true
	get_tree().paused = true  # Pause the game

func unpause_game():
	hide() #hide menu
	is_game_paused = false
	get_tree().paused = false  # Unpause the game

func _on_resume_button_pressed():
	unpause_game()


func _on_quit_button_pressed():
	$QuitButton.icon = load("res://Artwork/GUI_Art/Red_pressed.png")
	$QuitButton/Label2.global_position.y += 5
	get_tree().quit()  # Quit the game


func _on_texture_button_pressed():
	unpause_game()
