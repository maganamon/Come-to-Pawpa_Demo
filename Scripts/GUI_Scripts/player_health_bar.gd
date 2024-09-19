extends TextureProgressBar

var catch_up = false
var yellowBar
# Called when the node enters the scene tree for the first time.
func _ready():
	yellowBar = $yellow_Ebar
	$yellow_Ebar.max_value = GlobalScript.PLAYER_MAXENERGY
	$yellow_Ebar.value = GlobalScript.PLAYER_MAXENERGY
	$red_Hbar.value = GlobalScript.PLAYER_HP

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	## Health Bar Code
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
	## Health Bar END ##
	
	## Energy Bar Code ##
	if yellowBar.value > GlobalScript.PLAYER_ENERGY:
		yellowBar.value = GlobalScript.PLAYER_ENERGY
	elif yellowBar.value < GlobalScript.PLAYER_ENERGY:
		yellowBar.value = GlobalScript.PLAYER_ENERGY

func _on_hbar_timer_timeout():
	catch_up = true
