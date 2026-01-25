extends StaticBody2D

func _on_danger_entered(body: Node2D) -> void:
	GameManager.gamestate.game_over.emit()
	GameManager.is_game_active = false
	print("game over")
