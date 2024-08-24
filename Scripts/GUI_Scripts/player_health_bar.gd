extends TextureProgressBar

var player
var catch_up = false
# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node("/root/Game/placeholder_player")
	$red_Hbar.value = player.health

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player != null:
		if $red_Hbar.value > player.health:
			$red_Hbar.value = player.health
			$hbar_timer.start(1.5)
		if catch_up == true:
			$white_Hbar.value += -1
		if $white_Hbar.value <= $red_Hbar.value:
			catch_up = false
	else:
		$red_Hbar.value = 0
		$white_Hbar.value = 0
	


func _on_hbar_timer_timeout():
	catch_up = true
