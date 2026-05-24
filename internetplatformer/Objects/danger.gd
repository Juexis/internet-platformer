extends Interactable

func _physics_process(delta: float) -> void:
	if is_inside and not logic_triggered:
		GameManager.player_died = true
		GameManager.is_game_active = false
		GameManager.gamestate.game_over.emit()
		GameManager.set_end_text.emit("ERR_CHAR_DELETED")
	super(delta)
