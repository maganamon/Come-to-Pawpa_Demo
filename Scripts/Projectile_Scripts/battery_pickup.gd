extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage_mob"):
		queue_free()
		GlobalScript.energyPickup.emit()
