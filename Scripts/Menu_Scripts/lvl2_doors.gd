extends Node2D

const CHASER = preload("res://Scenes/Character_Scenes/chaser_dogg.tscn")
var random = RandomNumberGenerator.new()
var can_spawn = true
var rand_int
var spwnAmt
var concurrent_doors
var timeToSet
var round_timer
var enemiesLeft
var ENDROUND = false
# Called when the node enters the scene tree for the first time.
func _ready():
	timeToSet = GlobalScript._giveMe_LevelTime()
	round_timer = $DoorsTimer
	round_timer.start(timeToSet)
	GlobalScript.player_died.connect(_on_player_died)
	concurrent_doors = 1
	GlobalScript.No_BlkScreen.emit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	enemiesLeft = get_tree().get_nodes_in_group("Enemies").size()

## Randomly spawn based on a random number generator
## 1 = top_Elevator, 2 = right_elevator, 3 = left_elevator
func _on_spawn_timer_timeout():
	if can_spawn == true:
		for i in range(concurrent_doors):
			if can_spawn:
				random.randomize()
				rand_int = random.randi_range(1, 5)
				random.randomize()
				spwnAmt = random.randi_range(1, 3)
				# Determine which elevator to use based on rand_int
				if rand_int == 1:
					spawn_enemy($"top_elevator/Elevator-Referance_Rect", $top_elevator, spwnAmt)
				elif rand_int == 2:
					spawn_enemy($"right_elevator/Elevator-Referance_Rect", $right_elevator, spwnAmt)
				elif rand_int == 3:
					spawn_enemy($"left_elevator/Elevator-Referance_Rect", $left_elevator, spwnAmt)
				elif rand_int == 4:
					spawn_enemy($"bottomLeft_elevator/Elevator-Referance_Rect", $bottomLeft_elevator, spwnAmt)
				elif rand_int == 5:
					spawn_enemy($"bottomRight_elevator/Elevator-Referance_Rect", $bottomRight_elevator, spwnAmt)
		if (round_timer.time_left <= 0.0):
			can_spawn = false
		#after 35 seconds
		elif (round_timer.time_left <= timeToSet - 35.0):
			concurrent_doors = 3
		#after 15 seconds
		elif (round_timer.time_left <= timeToSet - 15):
			concurrent_doors = 2

func spawn_enemy(spawn_area, elevator, how_many):
	for i in range(how_many):
		# Play the elevator opening animation
		elevator.play("opening")
		# Generate a random position within the rect
		var random_x = randf() * (spawn_area.size.x)
		var random_y = randf() * (spawn_area.size.y)
		var random_position = Vector2(random_x, random_y)
		
		# Instance and position the enemy
		var new_chaser = CHASER.instantiate()
		new_chaser.global_position = spawn_area.global_position + random_position
		get_tree().root.add_child(new_chaser)
		
		# Play the elevator closing animation
		elevator.play("closing")
func _on_player_died():
	can_spawn = false
		


func _on_doors_timer_timeout() -> void:
	can_spawn = false
	if ENDROUND == false:
		ENDROUND = true
		print(enemiesLeft)
		$DoorsTimer.start(4.0)
	if ENDROUND == true && enemiesLeft == 0:
		GlobalScript.currentLevel += 1
		GlobalScript.Yes_BlkScreen.emit()
		await GlobalScript.endTransition
		get_tree().change_scene_to_file("res://Scenes/Menu_Scenes/hex_transition.tscn")
	else:
		$DoorsTimer.start(4.0)
