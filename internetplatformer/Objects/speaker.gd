extends StaticBody2D

@onready var area_2d: Area2D = $Area2D

func _on_speaker_entered(body: CharacterBody2D) -> void:
	ObjectsBus.speaker_entered.emit()
