extends CanvasLayer


@onready var colorRect = $Control/ColorRect
@onready var animationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalScript.globalFade2Blk.connect(fadeToBlack)
	colorRect.visible = false

func fadeToBlack():
	animationPlayer.play("fade_in")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "fade_in":
		animationPlayer.play("fade_out")
		colorRect.visible = false
