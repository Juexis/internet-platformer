extends Label

func _ready() -> void:
	text = get_tree().current_scene.level_name
