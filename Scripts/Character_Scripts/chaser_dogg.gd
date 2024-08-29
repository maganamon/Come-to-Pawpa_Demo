extends CharacterBody2D

@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
@onready var animation := $AnimatedSprite2D as AnimatedSprite2D
var speed = 400  # Adjust the speed of the mob as needed
var player
var mob
 # Amount of damage the enemy will inflict on the player
var damage_dealt = 10
var health = 1
# Get the player's position
func _ready():
	#follow the player
	# Assuming Player is the root node of the player character
	player = get_node("/root/Game/placeholder_player")
	animation.play("dog_attack") 

func _process(_delta):
	if player != null:
		var direction = to_local(nav_agent.get_next_path_position()).normalized()
		velocity = direction * speed
		if velocity > Vector2(0,0):
			animation.play("run_right")
		move_and_slide()
		_update_sprite_direction(direction)
	
		
		
func makepath() -> void:
	if player != null:
		nav_agent.target_position = player.global_position

		
# Update the sprite direction based on the movement direction
func _update_sprite_direction(direction):
	if direction.x > 0:
## Collision update ####
		$"chasser-left_polygon-collision".disabled = true
		$"chasser-right_polygon-collision".disabled = false
		$Area2D/left_head.disabled = true
		$Area2D/right_head.disabled = false
## Collision update ####
		if $AnimatedSprite2D.offset == Vector2(-11,-17):
			$AnimatedSprite2D.offset = Vector2(0,-17)
		$AnimatedSprite2D.flip_h = false
	elif direction.x < 0:
## Collision update ####
		$"chasser-left_polygon-collision".disabled = false
		$"chasser-right_polygon-collision".disabled = true
		$Area2D/left_head.disabled = false
		$Area2D/right_head.disabled = true
## Collision update ####
		if $AnimatedSprite2D.offset == Vector2(0,-17):
			$AnimatedSprite2D.offset = Vector2(-11,-17)
		$AnimatedSprite2D.flip_h = true
		
func take_damage():
	health -= 1
	if health == 0:
		GlobalScript.kill_counter += 1
		queue_free()

func _on_area_2d_body_entered(body):
	if body.has_method("take_damage_mob"):
		speed = 0
		animation.play("dog_attack")
		play_hitmarker_sound()
		var push = global_position.direction_to(body.global_position)
		body.take_damage_mob(damage_dealt, push)

func _on_nav_timer_timeout():
	makepath()


func _on_animated_sprite_2d_animation_finished():
	if animation.animation == "dog_attack":
		$Nav_Timer.paused = true
		$attack_timer.start(1.0)
		speed = 0
		animation.play("Idle")


func _on_attack_timer_timeout():
	$Nav_Timer.paused = false
	speed = 500
	animation.play("run_right")
	
func play_hitmarker_sound():
	$AudioStreamPlayer2D.play()
