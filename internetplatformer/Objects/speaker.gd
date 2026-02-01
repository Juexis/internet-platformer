extends Interactable

#var is_player_inside

#func _process(delta: float) -> void:
	#var colliding = interaction_area.get_overlapping_bodies()
	#for bodies in colliding:
		#if bodies.name == "Player":
			#ObjectsBus.speaker_entered.emit()
func _on_speaker_entered(body: CharacterBody2D) -> void:
	ObjectsBus.speaker_entered.emit()
