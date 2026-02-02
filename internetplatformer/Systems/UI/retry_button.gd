extends Button

func _process(delta: float) -> void:
	if GameManager.is_game_active:
		hide()
	elif not GameManager.is_game_active and GameManager.player_died:
		show()

func _on_pressed() -> void:
	GameManager.restart_level()
