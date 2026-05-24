extends Area2D

func _on_out_of_bounds(body: Node2D) -> void:
	if body.name == "Player":
		GameManager.player_died = true
		GameManager.is_game_active = false
		GameManager.gamestate.game_over.emit()
		GameManager.set_end_text.emit("ERR_CHAR_NOT_FOUND")
