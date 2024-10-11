extends Control

func _on_continue_button_pressed() -> void:
	$menu_timer.start(0.75)
	await $menu_timer.timeout
	get_tree().change_scene_to_file("res://Scenes/Level_Scenes/level_one.tscn")
