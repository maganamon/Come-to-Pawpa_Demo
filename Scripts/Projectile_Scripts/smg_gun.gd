extends Area2D

var can_shoot = true
var can_Erecover = false
var ENERGY_MAX = 15
var cooldown_time = 0.15
var energy = 15
var E_RecoveryTime = 0.5
const BULLET = preload("res://Scenes/Projectile_Scenes/energy_ball.tscn")

func _ready():
	energy = ENERGY_MAX
	GlobalScript.PLAYER_ENERGY = energy
	
func _process(_delta):
	GlobalScript.PLAYER_ENERGY = energy
	if can_shoot && Input.is_action_pressed("shoot") && energy != 0:
			# Start shooting
			shoot()
	if can_Erecover == true && Input.is_action_pressed("shoot") != true && energy < ENERGY_MAX:
		energy += 1

func shoot():
	#Create a Bullet on Marker
		can_Erecover = false
		can_shoot = false
		energy += -1
		#### NOT DOING THIS YET!!health -= 1
		var new_bullet = BULLET.instantiate()
		GlobalScript.shot_fired.emit()
		new_bullet.global_position = $gun_marker.global_position #marker's global pos
		get_tree().root.add_child(new_bullet)
		$FireRate_Cooldown.start(cooldown_time)
		$Energy_Recover.start(E_RecoveryTime)
		if energy == 0:
			GlobalScript.over_Heat.emit()
func _on_fire_rate_cooldown_timeout():
	can_shoot = true

func _on_energy_recover_timeout() -> void:
	can_Erecover = true
