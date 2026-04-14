extends Interactable

func _physics_process(delta: float) -> void:
	# entered and speaker hasn't pushed player yet
	if is_inside and not logic_triggered:
		ObjectsBus.speaker_entered.emit()
	
	super(delta)
