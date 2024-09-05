extends CanvasLayer

signal on_transition_finished

@onready var colorRect = $Control/ColorRect
@onready var animationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	colorRect.visible = false
	animationPlayer.animation_finished.connect(_on_anim_finished)

	
func _on_anim_finished(animName):
	if animName == "fade_in":
		on_transition_finished.emit()
		animationPlayer.play("fade_out")
	elif 1 == 1:
		colorRect.visible = true
		
#func
	


func _on_animation_player_animation_finished(anim_name):
	pass # Replace with function body.
