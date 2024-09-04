extends Node2D

# Called when the node enters the scene tree for the first time.
##	$AnimatedSprite2D.play("RepeatMe")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_button_pressed() -> void:
	print(GlobalScript.dogHealth)
	GlobalScript.dogHealth = 3
	get_tree().change_scene_to_file("res://Scenes/Level_Scenes/level_one.tscn")


func _on_hex_transitionrabie_infested_mutts_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Level_Scenes/level_one.tscn")
