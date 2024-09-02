extends Sprite2D

var display_me
var purp_txt
var white_txt
# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalScript.player_died.connect(_on_player_died)
	purp_txt = $"Time_Left-Number-Label_purple"
	white_txt = $"Time_Left-Number-Label_white"
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	purp_txt.text = str(ceil($"Time_left-Round_timer".time_left))
	white_txt.text = str(ceil($"Time_left-Round_timer".time_left))

func _on_player_died():
	$"Time_left-Round_timer".paused = true
