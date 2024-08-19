extends Control

func _ready():
	# Connect signals for buttons
	var resume_button = $MarginContainer/VBoxContainer/ResumeButton
	var quit_button = $MarginContainer/VBoxContainer/QuitButton
	
	# Check if buttons are valid
	if resume_button and quit_button:
		resume_button.connect("pressed", Callable(self, "_on_resume_button_pressed"))
		quit_button.connect("pressed", Callable(self, "_on_quit_button_pressed"))
	else:
		print("Error: Buttons not found or not correctly set up.")

func _on_resume_button_pressed():
	# Call a function in the global script to unpause the game
	var global_script = get_tree().root.get_node("GlobalScript")
	if global_script:
		global_script.unpause_game()

func _on_quit_button_pressed():
	get_tree().quit()  # Quit the game
