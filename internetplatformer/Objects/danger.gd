extends Interactable

func _physics_process(delta: float) -> void:
	if _is_inside and not _logic_triggered:
		GameManager.gamestate.game_over.emit()
	
	super(delta)
