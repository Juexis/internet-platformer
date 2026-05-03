extends Interactable

func _physics_process(delta: float) -> void:
	if is_inside and not logic_triggered:
		GameManager.player_win = true
		GameManager.gamestate.game_over.emit()
		if GameManager.current_level <= 9 and not GameManager.is_next_level_unlocked():
			GameManager.levels_resource.flag_unlocked[GameManager.current_level + 1] = true
	super(delta)
