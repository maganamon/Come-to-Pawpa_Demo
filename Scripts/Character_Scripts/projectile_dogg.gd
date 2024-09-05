extends CharacterBody2D

##var player
const PROJ_BULLET = preload("res://Scenes/Projectile_Scenes/proj_enemy_bullet.tscn")
const SPEED = 100.0
const BULLETS_ALLOWED = 8
var damage = 10
var facingDirection = "left"
var releventMarker
var bulletSpawn_offset = Vector2(0,10)
var can_shoot = false
var cooldown = 0.10
var longWait = 3.0
var bulletsShot = 0
var health = 2
var safe_distance = 300.0
var tooFar = 500.00
var direction: Vector2

func _ready():
	releventMarker = $LeftMarker
	$ProjEnemy_Timer.start(longWait)
	
func _process(delta):
	if (GlobalScript.PLAYER_GPS.x < global_position.x) && (facingDirection != "left"):
		_update_directionStuff("left")
	elif (GlobalScript.PLAYER_GPS.x > global_position.x) && (facingDirection != "right"):
		_update_directionStuff("right")
	if can_shoot == true:
		_shoot()

	# Calculate the direction from the enemy to the player
	direction = global_position.direction_to(GlobalScript.PLAYER_GPS)

	# Calculate the distance to the player
	var distance_to_player = global_position.distance_to(GlobalScript.PLAYER_GPS)

	# Move away if the player is too close
	if distance_to_player < safe_distance:
		velocity = -direction * SPEED
		move_and_slide()
	elif distance_to_player > tooFar:
		velocity = direction * SPEED
		move_and_slide()
	else:
		velocity = Vector2.ZERO
		move_and_slide()  # Stop moving when at a safe distance

func _update_directionStuff(faceThisWay):
	if faceThisWay == "left":
		$Sprite2D.flip_h = false
		$LeftForProjectiles_Collision.disabled = false
		$RightForProjectile_Collision.disabled = true
		$Area2D_ProjEnemy/Left_ForBody_Collision.disabled = false
		$Area2D_ProjEnemy/Right_ForBody_Collision.disabled = true
		facingDirection = "left"
		releventMarker = $LeftMarker
	else :
		$Sprite2D.flip_h = true
		$LeftForProjectiles_Collision.disabled = true
		$RightForProjectile_Collision.disabled = false
		$Area2D_ProjEnemy/Left_ForBody_Collision.disabled = true
		$Area2D_ProjEnemy/Right_ForBody_Collision.disabled = false
		facingDirection = "right"
		releventMarker = $RightMarker
func _shoot():
	var new_bullet = PROJ_BULLET.instantiate()
	GlobalScript.projEnemy_shot.emit()
	new_bullet.global_position = releventMarker.global_position + bulletSpawn_offset
	bulletSpawn_offset = bulletSpawn_offset * -1
	get_tree().root.add_child(new_bullet)
	can_shoot = false
	if bulletsShot != BULLETS_ALLOWED:
		bulletsShot += 1
		$ProjEnemy_Timer.start(cooldown)
	else:
		bulletsShot = 0
		$ProjEnemy_Timer.start(longWait)

func take_damage():
	GlobalScript.enemy_hit.emit()
	health -= 1
	if health == 0:
		GlobalScript.hurtDog.emit()
		GlobalScript.kill_counter += 1
		queue_free()

func _on_proj_enemy_timer_timeout():
	can_shoot = true


func _on_area_2d_proj_enemy_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage_mob"):
		var push = global_position.direction_to(body.global_position)
		body.take_damage_mob(damage, push * 2)
