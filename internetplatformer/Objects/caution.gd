extends Node

func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	var player_force = body.get_last_motion()
	ObjectsBus.caution_entered.emit(player_force)
