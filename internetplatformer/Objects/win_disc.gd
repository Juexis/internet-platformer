extends Interactable

func _physics_process(delta: float) -> void:
	if is_inside and not logic_triggered:
		GameManager.player_win = true
		GameManager.gamestate.game_over.emit()
	super(delta)
