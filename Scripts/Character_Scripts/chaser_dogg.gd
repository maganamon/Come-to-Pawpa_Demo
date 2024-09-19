extends CharacterBody2D

@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
@onready var animation := $AnimatedSprite2D as AnimatedSprite2D
var speed = 400  # Adjust the speed of the mob as needed
var CHASER_SPEED = 400
var mob
var direction = Vector2.ZERO
 # Amount of damage the enemy will inflict on the player
var damage_dealt = 10
var health = 1
# Get the player's position
func _ready():
	health += GlobalScript.dog_health_hex
	CHASER_SPEED += GlobalScript.dog_speed_hex
	speed = CHASER_SPEED
	animation.play("watch_out")

func _process(_delta):
	if animation.animation != "watch_out":
		direction = to_local(nav_agent.get_next_path_position()).normalized()
		velocity = direction * speed
	if velocity != Vector2(0,0):
		animation.play("run_right")
	_update_sprite_direction(direction)
	move_and_slide()
	
		
		
func makepath() -> void:
	if GlobalScript.PLAYER_GPS != null:
		nav_agent.target_position = GlobalScript.PLAYER_GPS

		
# Update the sprite direction based on the movement direction
func _update_sprite_direction(direction):
	if direction.x > 0:
## Collision update ####
		$Area2D/RightProjectileArea.disabled = false
		$Area2D/LeftProjectileArea.disabled = true
		$AnimatedSprite2D.flip_h = false
## Collision update ####
		if $AnimatedSprite2D.offset == Vector2(-11,-17):
			$AnimatedSprite2D.offset = Vector2(0,-17)
	elif direction.x < 0:
## Collision update ####
		$Area2D/RightProjectileArea.disabled = true
		$Area2D/LeftProjectileArea.disabled = false
## Collision update ####
		if $AnimatedSprite2D.offset == Vector2(0,-17):
			$AnimatedSprite2D.offset = Vector2(-11,-17)
		$AnimatedSprite2D.flip_h = true
func take_damage():
	GlobalScript.enemy_hit.emit()
	health -= 1
	if health == 0:
		GlobalScript.hurtDog.emit()
		GlobalScript.kill_counter += 1
		queue_free()

func _on_area_2d_body_entered(body):
	if body.has_method("take_damage_mob"):
		speed = 0
		animation.play("dog_attack")
		var push = global_position.direction_to(body.global_position)
		body.take_damage_mob(damage_dealt, push)

func _on_nav_timer_timeout():
	makepath()


func _on_animated_sprite_2d_animation_finished():
	if animation.animation == "watch_out":
		$small_circle_collision.disabled = false
		direction = to_local(nav_agent.get_next_path_position()).normalized()
		animation.play("run_right")
		_update_sprite_direction(direction)
	elif animation.animation == "dog_attack":
		$Nav_Timer.paused = true
		$attack_timer.start(1.0)
		speed = 0
		animation.play("Idle")

func _on_attack_timer_timeout():
	$Nav_Timer.paused = false
	speed = CHASER_SPEED
	animation.play("run_right")
	direction = to_local(nav_agent.get_next_path_position()).normalized()
	_update_sprite_direction(direction)
