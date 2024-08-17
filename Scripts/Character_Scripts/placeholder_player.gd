extends CharacterBody2D


const speed = 300.0
var knockback = Vector2.ZERO  # To store knockback velocity
var knockback_tween
var knockback_decay = 0.75
var currentDirection = "none"
func _ready():
	# Play the front idle animation when the game starts
	$AnimatedSprite2D.play("Idle")

# This function is called every physics frame (fixed timestep)
func _physics_process(delta):
	# Handle player movement based on input
	player_movement(delta)
	if knockback != Vector2.ZERO:
		velocity += knockback
		move_and_slide()
# Function to handle player movement input and apply velocity
func player_movement(_delta):
	if Input.is_action_pressed("new_right"):
		currentDirection = "right"  # Set current direction to right
		playAnimation(1)  # Play walking animation
		velocity.x = speed  # Set velocity to move right
		velocity.y = 0  # Stop vertical movement
	elif Input.is_action_pressed("new_left"):
		currentDirection = "left"  # Set current direction to left
		playAnimation(1)  # Play walking animation
		velocity.x = -speed  # Set velocity to move left
		velocity.y = 0  # Stop vertical movement
	elif Input.is_action_pressed("new_down"):
		currentDirection = "down"  # Set current direction to down
		playAnimation(1)  # Play walking animation
		velocity.x = 0  # Stop horizontal movement
		velocity.y = speed  # Set velocity to move down
	elif Input.is_action_pressed("new_up"):
		currentDirection = "up"  # Set current direction to up
		playAnimation(1)  # Play walking animation
		velocity.x = 0  # Stop horizontal movement
		velocity.y = -speed  # Set velocity to move up
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
