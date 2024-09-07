extends TextureProgressBar

var catch_up = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$red_Hbar.value = GlobalScript.PLAYER_HP

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $red_Hbar.value > GlobalScript.PLAYER_HP:
		$red_Hbar.value = GlobalScript.PLAYER_HP
		$hbar_timer.start(1.5)
	if catch_up == true:
		$white_Hbar.value += -1
	if $white_Hbar.value <= $red_Hbar.value:
		catch_up = false
	if $red_Hbar.value < GlobalScript.PLAYER_HP:
		$red_Hbar.value = GlobalScript.PLAYER_HP
		$white_Hbar.value = GlobalScript.PLAYER_HP

func _on_hbar_timer_timeout():
	catch_up = true
