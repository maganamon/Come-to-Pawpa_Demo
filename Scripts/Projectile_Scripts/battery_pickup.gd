extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage_mob"):
		GlobalScript.energyPickup.emit()
		queue_free()
	else:
		pass
