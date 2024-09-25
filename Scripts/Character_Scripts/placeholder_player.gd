extends CharacterBody2D

var isInvisible = false
var invisibilityCooldown = 0.5
# Movement and Knockback ##
var speed_multiplier = 1.25
const speed = 300.0
var knockback = Vector2.ZERO  # To store knockback velocity
var knockback_tween
var knockback_decay = 0.75
var currentDirection = "none"
var gun_on_right = true
#
##Healing Variables ############
var healing_pause = 2.5
var health_max = 100
var health = health_max
var batteryPickup = 20
## Heath Variables END ##################
# The radius of the circle around the player where the gun will follow.
@onready var gun : = $smg_gun
var gun_distance = 10.0
#


func _ready():
	GlobalScript.PLAYER_GPS = self.global_position
	GlobalScript.energyPickup.connect(moreHealthPls)
	GlobalScript.over_Heat.connect(_loseHP)
	# Play the front idle animation when the game starts
	$AnimatedSprite2D.play("Idle")

func _process(delta):
	GlobalScript.PLAYER_HP = health
	GlobalScript.PLAYER_GPS = self.global_position
	##Gun Moving in Circle Mechanics
	# Get the global position of the player and the mouse.
	var player_pos = global_position
	var mouse_pos = get_global_mouse_position()
	# Calculate the angle between the player and the mouse.
	var angle = (mouse_pos - player_pos).angle()
	# Calculate the new position for the gun.
	var gun_position = player_pos + Vector2(0,-10) + Vector2(cos(angle), sin(angle)) * gun_distance
	# Set the gun's global position.
	gun.global_position = gun_position
	# Optionally, rotate the gun to face the mouse (if needed).
	gun.rotation = angle
	if mouse_pos.x < player_pos.x:
		$smg_gun/Sprite2D.flip_v = true
	else:
		$smg_gun/Sprite2D.flip_v = false
	## Gun Circle END ####
	
# This function is called every physics frame (fixed timestep)
func _physics_process(delta):
	# Handle player movement based on input
	player_movement(delta)
	if knockback != Vector2.ZERO:
		velocity += knockback
		move_and_slide()
		
func _loseHP():
	GlobalScript.player_hit.emit()
	health += -20
	if health <= 0:
			health = 0
			GlobalScript.PLAYER_HP = 0
			die()  # Call the die function if health reaches 0

# Function to handle player movement input and apply velocity
func player_movement(_delta):
	if Input.is_action_pressed("new_up") && Input.is_action_pressed("new_right"):
		currentDirection = "right"  # Set current direction to right
		playAnimation(1)  # Play walking animation
		velocity.x = speed  # Set velocity to move right
		velocity.y = -speed  # Stop vertical movement
		
	elif Input.is_action_pressed("new_up") && Input.is_action_pressed("new_left"):
		currentDirection = "left"  # Set current direction to right
		playAnimation(1)  # Play walking animation
		velocity.x = -speed  # Set velocity to move right
		velocity.y = -speed  # Stop vertical movement
		
	elif Input.is_action_pressed("new_down") && Input.is_action_pressed("new_right"):
		currentDirection = "right"  # Set current direction to right
		playAnimation(1)  # Play walking animation
		velocity.x = speed  # Set velocity to move right
		velocity.y = speed  # Stop vertical movement
		
	elif Input.is_action_pressed("new_down") && Input.is_action_pressed("new_left"):
		currentDirection = "left"  # Set current direction to right
		playAnimation(1)  # Play walking animation
		velocity.x = -speed  # Set velocity to move right
		velocity.y = speed  # Stop vertical movement
		
	elif Input.is_action_pressed("new_right"):
		currentDirection = "right"  # Set current direction to right
		playAnimation(1)  # Play walking animation
		velocity.x = speed * speed_multiplier # Set velocity to move right
		velocity.y = 0  # Stop vertical movement
	elif Input.is_action_pressed("new_left"):
		currentDirection = "left"  # Set current direction to left
		playAnimation(1)  # Play walking animation
		velocity.x = -speed * speed_multiplier # Set velocity to move left
		velocity.y = 0  # Stop vertical movement
	elif Input.is_action_pressed("new_down"):
		currentDirection = "down"  # Set current direction to down
		playAnimation(1)  # Play walking animation
		velocity.x = 0  # Stop horizontal movement
		velocity.y = speed * speed_multiplier # Set velocity to move down
	elif Input.is_action_pressed("new_up"):
		currentDirection = "up"  # Set current direction to up
		playAnimation(1)  # Play walking animation
		velocity.x = 0  # Stop horizontal movement
		velocity.y = -speed * speed_multiplier # Set velocity to move up
	else:
		playAnimation(0)  # Play idle animation
		velocity.x = 0  # Stop horizontal movement
		velocity.y = 0  # Stop vertical movement
	
	# Move the character based on the velocity vector
	move_and_slide()

# Function to play the appropriate animation based on direction and movement state
func playAnimation(movement):
	var direction = currentDirection  # Get the current direction
	var animation = $AnimatedSprite2D
	  # Get the AnimatedSprite2D node
	
	if direction == "right":
		animation.flip_h = false  # Ensure sprite is not flipped horizontally
		if movement == 1:
			animation.play("walk_right")  # Play walking animation for right
		elif movement == 0:
			animation.play("Idle_right")  # Play idle animation for right
	elif direction == "left":
		animation.flip_h = false  # Flip sprite horizontally
		if movement == 1:
			animation.play("walk_left")  # Play walking animation for left
		elif movement == 0:
			animation.play("Idle_left")  # Play idle animation for left
	elif direction == "down":
		animation.flip_h = false  # Ensure sprite is not flipped horizontally
		if movement == 1:
			animation.play("walk_down")  # Play walking animation for down
		elif movement == 0:
			animation.play("Idle_down")  # Play idle animation for down
	elif direction == "up":
		animation.flip_h = false  # Ensure sprite is not flipped horizontally
		if movement == 1:
			animation.play("walk_up")  # Play walking animation for up
		elif movement == 0:
			animation.play("Idle_up")  # Play idle animation for up
			
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Function to take damage
func take_damage_mob(dmg_amt, pushed):
	if isInvisible == false:
		isInvisible = true
		$invisibility_Timer.start(invisibilityCooldown)
		GlobalScript.player_hit.emit()
		health -= dmg_amt # Reduce current health by damage amount
		if health <= 0:
			health = 0
			GlobalScript.PLAYER_HP = 0
			die()  # Call the die function if health reaches 0
		# Have a 3 second healing cooldown after being hit ###
		## knock back logic here:
		## change the multiplied constant after pushed to change knockback
		knockback = Vector2.ZERO + (pushed * 200)
		knockback_tween = get_tree().create_tween()
		knockback_tween.parallel().tween_property(self, "knockback", Vector2.ZERO, knockback_decay)
		## Knockback Logic END #####
		#Change color when hit
		$AnimatedSprite2D.modulate = Color(1,0,0,1)
		knockback_tween.parallel().tween_property($AnimatedSprite2D, "modulate", Color(1,1,1,1), knockback_decay)
	
func die():
	print(GlobalScript.kill_counter)
	print("PLayer Died")
	GlobalScript.kill_counter = 0
	GlobalScript.player_died.emit()
	queue_free()

func moreHealthPls():
	#print("HP Before: ",health)
	health += batteryPickup
	if health > health_max:
		health = health_max
	#print("HP After: ",health)


func _on_level_music_ready() -> void:
	pass # Replace with function body.


func _on_invisibility_timer_timeout() -> void:
	isInvisible = false


func _on_level_2_music_ready() -> void:
	pass # Replace with function body.

##For Chasers
func _on_circle_area_area_entered(area: Area2D) -> void:
	if area.get_parent().has_method("_entered_PlayerCircle"):
		area.get_parent()._entered_PlayerCircle(global_position)


func _on_circle_area_area_exited(area: Area2D) -> void:
	if area.get_parent().has_method("_leftCircle"):
		area.get_parent()._leftCircle()
