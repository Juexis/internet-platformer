extends Area2D

func _on_out_of_bounds(body: Node2D) -> void:
	if body.name == "Player":
		GameManager.gamestate.game_over.emit()
