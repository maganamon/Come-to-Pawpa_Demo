extends Area2D

var speed = 2300
var direction = Vector2.ZERO
var traveled_distance = 0
var damage = 1
const MAX_DISTANCE = 700  # Adjust this value as needed

func _ready():
	# Set the initial direction towards the mouse
	direction = (get_global_mouse_position() - global_position).normalized()
	rotation = direction.angle()

func _physics_process(delta):
	# Move the bullet in the direction it was initially facing
	position += direction * speed * delta
	
	# Calculate the distance traveled by the bullet
	traveled_distance += speed * delta
	
	# Check if the bullet has traveled beyond the maximum distance
	if traveled_distance > MAX_DISTANCE:
		queue_free()
		
#Logic to free the bullet
###NOT USING THIS YET!!!
func _on_body_entered(body):
	if body.has_method("take_damage"):
		queue_free()
		body.take_damage()


func _on_area_entered(area: Area2D) -> void:
	if area.get_parent().has_method("take_damage"):
		queue_free()
		area.get_parent().take_damage()
