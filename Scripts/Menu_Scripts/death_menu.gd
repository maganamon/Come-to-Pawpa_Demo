extends Control



func _on_death_menu_exit_button_pressed():
	get_tree().quit()  # Quit the game


func _on_death_menu_restart_button_pressed():
	get_tree().reload_current_scene()
