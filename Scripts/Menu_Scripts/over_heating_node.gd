extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$OverHeating_Sprite.visible = false
	GlobalScript.over_Heat.connect(play_OHanim)


func play_OHanim():
	$OverHeating_Sprite.visible = true
	$OverHeatAnimPlayer.play("fluxuate")


func _on_over_heat_anim_player_animation_finished(anim_name: StringName) -> void:
	$OverHeating_Sprite.visible = false
