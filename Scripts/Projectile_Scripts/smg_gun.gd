extends Area2D

var can_shoot = true
var cooldown_time = 0.15
const BULLET = preload("res://Scenes/Projectile_Scenes/energy_ball.tscn")

func _ready():
	pass
func _process(_delta):
	if can_shoot && Input.is_action_pressed("shoot"):
			# Start shooting
			shoot()

func shoot():
	#Create a Bullet on Marker
		#### NOT DOING THIS YET!!health -= 1
		var new_bullet = BULLET.instantiate()
		GlobalScript.shot_fired.emit()
		new_bullet.global_position = $gun_marker.global_position #marker's global pos
		get_tree().root.add_child(new_bullet)

		can_shoot = false
		$FireRate_Cooldown.start(cooldown_time)
		
func _on_fire_rate_cooldown_timeout():
	can_shoot = true
