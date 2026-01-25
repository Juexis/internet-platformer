extends Node

func _on_caution_entered(body: Node2D) -> void:
	var player_force = body.get_last_motion()
	ObjectsBus.caution_entered.emit(player_force)
