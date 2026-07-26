extends Panel

@onready var _times_text: RichTextLabel = $OutlineMargin/VBox/BodyContainer/MarginContainer/TimesText
@onready var _animations: AnimationPlayer = $WindowAnimations
@onready var _x_button: Button = $OutlineMargin/VBox/HeaderContainer/TitlebarMargin/HBoxContainer/MarginContainer/XButton
# from game_manager.gd -> levels_resource.tres -> levels array in levels_resource.tres
var _level_names: Array[String] = GameManager.levels_resource.level_names
var _best_times: Array[int] = GameManager.levels_resource.best_times

func _ready() -> void:
	_x_button.grab_focus()
	var lines = []
	for i in 10:
		var padded_name = _level_names[i].rpad(16)
		var padded_time = _format_time(_best_times[i])
		
		lines.append("%s: %s" % [padded_name, padded_time]) # appends to an array

# adds each line to the textbox with a newline
	for i in lines:
		_times_text.text += i + "\n"

# returns a formatted time in mins and secs
func _format_time(input: int):
	var minutes = input / 60
	var seconds = input % 60
	return "%d:%02d" % [minutes, seconds]


func _on_x_button_pressed() -> void:
	_animations.play("fade_out")
	get_viewport().gui_release_focus() # function to unfocus all gui
	await _animations.animation_finished
	GameManager.gamestate.switch_focus.emit()
	queue_free()
