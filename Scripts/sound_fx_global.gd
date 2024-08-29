extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalScript.shot_fired.connect(_play_shotFired)
	GlobalScript.enemy_hit.connect(_play_enemyHit)
	
func _play_shotFired():
	$Bullet_sfx.play()

func _play_enemyHit():
	$Enemies_hitmarker.play()
