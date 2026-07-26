extends Button
var _time_window: PackedScene = preload("res://Systems/UI/level_times.tscn")
func _on_pressed() -> void:
	var _window_instance = _time_window.instantiate()
	get_node("/root/MainMenu/CanvasLayer").add_child(_window_instance)
