extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalScript.shot_fired.connect(_play_shotFired)
	GlobalScript.enemy_hit.connect(_play_enemyHit)
	GlobalScript.player_hit.connect(_play_playerHit)
	GlobalScript.projEnemy_shot.connect(_play_projEnemyFired)
	GlobalScript.hurtDog.connect(_play_hurtDog)
	
func _play_shotFired():
	$Bullet_sfx.play()

func _play_enemyHit():
	$Enemies_hitmarker.play()
	
func _play_playerHit():
	$Player_TakeDMG.play()
	
func _play_projEnemyFired():
	$projEnemy_laser.play()
	
func _play_hurtDog():
	$hurtDogFX.play()
