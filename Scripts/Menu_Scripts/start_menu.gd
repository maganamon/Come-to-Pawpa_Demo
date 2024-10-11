extends Control

func _on_play_button_pressed():
	$menu_timer.start(0.75)
	await $menu_timer.timeout
	get_tree().change_scene_to_file("res://Scenes/Menu_Scenes/tutorial_screen.tscn")

func _on_exit_button_pressed():
	$menu_timer.start(0.75)
	await $menu_timer.timeout
	get_tree().quit()
	pass # Replace with function body.

func _on_timer_timeout():
	pass # Replace with function body.
