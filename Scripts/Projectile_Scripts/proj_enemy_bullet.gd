extends Area2D

var speed = 1500
var direction = Vector2.ZERO
var traveled_distance = 0
var damage = 1
const MAX_DISTANCE = 700  # Adjust this value as needed

func _ready():
	# Calculate direction based on the player's global position
	direction = (GlobalScript.PLAYER_GPS - global_position).normalized()
	rotation = direction.angle()

func _physics_process(delta):
	# Move the bullet in the direction towards the player
	position += direction * speed * delta
	
	# Calculate the distance traveled by the bullet
	traveled_distance += speed * delta
	
	# Check if the bullet has traveled beyond the maximum distance
	if traveled_distance > MAX_DISTANCE:
		queue_free()
		
#Logic to free the bullet
###NOT USING THIS YET!!!
func _on_body_entered(body):
	if body.has_method("take_damage_mob"):
		queue_free()
		var push = global_position.direction_to(body.global_position)
		body.take_damage_mob(damage, push)
	
