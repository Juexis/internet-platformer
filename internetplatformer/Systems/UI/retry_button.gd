extends Button

func _on_pressed() -> void:
	if GameManager.is_loading:
		return
	GameManager.restart_level()
