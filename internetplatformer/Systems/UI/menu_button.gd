extends Button

@onready var level_select_window: PackedScene = load("res://Systems/UI/level_select.tscn")

func _on_pressed() -> void:
	var new_level_select_window: Node = level_select_window.instantiate()
	get_node("/root/world/UI").add_child(new_level_select_window) # add to UI canvas layer instead of the button
	new_level_select_window.set_anchors_preset(Control.PRESET_CENTER)
