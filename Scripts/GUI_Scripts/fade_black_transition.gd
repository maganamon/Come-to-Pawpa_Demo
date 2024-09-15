extends CanvasLayer


@onready var colorRect = $Control/ColorRect
@onready var animationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalScript.Yes_BlkScreen.connect(fadeToBlack)
	GlobalScript.No_BlkScreen.connect(fadeToTransparent)
	colorRect.visible = false

func fadeToBlack():
	colorRect.modulate = Color(1,1,1,0)
	colorRect.visible = true
	animationPlayer.play("fade_in")

func fadeToTransparent():
	colorRect.modulate = Color(1,1,1,1)
	colorRect.visible = true
	animationPlayer.play("fade_out")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	GlobalScript.endTransition.emit()
	colorRect.visible = false
