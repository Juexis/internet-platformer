extends Interactable

func _physics_process(delta: float) -> void:
	# entered and speaker hasn't pushed player yet
	if _is_inside and not _logic_triggered:
		ObjectsBus.speaker_entered.emit()
	
	super(delta)
