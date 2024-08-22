extends Node2D

const CHASER = preload("res://Scenes/Character_Scenes/chaser_dogg.tscn")
var random = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

## Randomly spawn based on a random number generator
## 1 = top_Elevator, 2 = right_elevator, 3 = left_elevator
func _on_spawn_timer_timeout():
	random.randomize()
	var rand_int = random.randi_range(1, 3)
	if rand_int == 1:
		$top_elevator.play("opening")
		var new_chaser = CHASER.instantiate()
		new_chaser.global_position = $top_elevator/Spawn_Here.global_position
		get_tree().root.add_child(new_chaser)
		$top_elevator.play("closing")
	if rand_int == 2:
		$right_elevator.play("opening")
		var new_chaser = CHASER.instantiate()
		new_chaser.global_position = $right_elevator/Spawn_Here.global_position
		get_tree().root.add_child(new_chaser)
		$right_elevator.play("closing")
	if rand_int == 3:
		$left_elevator.play("opening")
		var new_chaser = CHASER.instantiate()
		new_chaser.global_position = $left_elevator/Spawn_Here.global_position
		get_tree().root.add_child(new_chaser)
		$left_elevator.play("closing")
	
