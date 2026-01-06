extends StaticBody2D

@onready var area_2d: Area2D = $Area2D

func _on_area_2d_body_entered(body: CollisionObject2D) -> void:
	ObjectsBus.speaker_entered.emit()
