extends Control

func _ready():
	GlobalScript.player_died.connect(_on_player_died)
	# Connect signals for buttons
	hide()

func _on_death_menu_exit_button_pressed():
	get_tree().quit()  # Quit the game


func _on_death_menu_restart_button_pressed():
	get_tree().reload_current_scene()
	
func _on_player_died():
	show()
