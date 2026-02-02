extends Interactable

var player_force

func _physics_process(delta: float) -> void:
	if _is_inside:
		for body in interaction_area.get_overlapping_bodies():
			if body.name == "Player":
				player_force = body.get_last_motion()
	
	if _is_inside and _was_inside and not _logic_triggered:
		ObjectsBus.caution_entered.emit(player_force)
	
	super(delta)
