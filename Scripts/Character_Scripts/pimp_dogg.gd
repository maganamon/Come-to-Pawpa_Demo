extends CharacterBody2D

@onready var animation := $AnimatedSprite2D
@onready var nav_agent := $NavigationAgent2D
@onready var nav_timer := $Nav_Timer
@onready var attack_timer := $attack_timer
@onready var right_projectile_area := $Area2D/RightProjectileArea
@onready var left_projectile_area := $Area2D/LeftProjectileArea

var speed = 200  # Movement speed
var direction = Vector2.ZERO
var health = 40  # Starting health
var damage_dealt = 10  # Damage dealt to the target
var is_active = true  # Enemy starts active immediately
var attack_ready = true  # Prevent multiple attacks during cooldown

func _ready():
	# Start the movement logic immediately
	animation.play("run")
	nav_timer.connect("timeout", Callable(self, "_on_nav_timer_timeout"))
	attack_timer.connect("timeout", Callable(self, "_on_attack_timer_timeout"))
	make_path()

func _process(delta):
	if is_active and direction != Vector2.ZERO:
		velocity = direction * speed
		move_and_slide()
		_update_sprite_direction(direction)  # Flip sprite based on movement direction

func _on_nav_timer_timeout():
	if is_active:
		make_path()

func make_path():
	# Set navigation target to player's position
	if GlobalScript.PLAYER_GPS != null:
		nav_agent.target_position = GlobalScript.PLAYER_GPS
		direction = to_local(nav_agent.get_next_path_position()).normalized()

func _update_sprite_direction(dir):
	# Flip the sprite horizontally based on movement direction
	if dir.x > 0:
		animation.flip_h = false  # Face right
	elif dir.x < 0:
		animation.flip_h = true  # Face left

func _on_area_2d_body_entered(body):
	# Detect when Pimp Dogg enters a target's collision area
	if is_active and attack_ready and body.has_method("take_damage"):
		attack_ready = false  # Prevent multiple attacks
		animation.play("first_attack")  # Play attack animation
		body.take_damage(damage_dealt)  # Deal damage to the target
		attack_timer.start(1.0)  # Cooldown before attacking again

func _on_attack_timer_timeout():
	attack_ready = true  # Allow attacking again

func take_damage(amount):
	# Reduce health and play the hurt animation
	if is_active:
		health -= amount
		if health > 0:
			animation.play("hurt")
		else:
			die()

func die():
	# Play death animation and remove from the scene
	is_active = false
	animation.play("death")
	nav_timer.stop()
	attack_timer.stop()
	queue_free()  # Remove the node after the animation finishes

func _on_animated_sprite_2d_animation_finished():
	# Handle animation transitions
	match animation.animation:
		"first_attack":
			animation.play("run")  # Return to run animation after attacking
		"hurt":
			if health > 0:
				animation.play("run")  # Resume running if still alive
		"death":
			queue_free()  # Remove Pimp Dogg after death animation
