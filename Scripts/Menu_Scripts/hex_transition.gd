extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("RepeatMe")

func _on_hex_transition_rabie_infested_mutts_button_pressed():
	print("rabies")


func _on_hex_transition_healing_hounds_button_pressed():
	print("healing")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
