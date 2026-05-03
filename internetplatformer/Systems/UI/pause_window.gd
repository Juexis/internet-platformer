extends PanelContainer
@onready var _animations: AnimationPlayer = $WindowAnimations
@onready var _next_button: Button = $OutlineMargin/VBox/BodyContainer/MarginContainer/VBoxContainer/NextButton
@onready var _retry_button: Button = $OutlineMargin/VBox/BodyContainer/MarginContainer/VBoxContainer/RetryButton
@onready var _menu_button: Button = $OutlineMargin/VBox/BodyContainer/MarginContainer/VBoxContainer/MenuButton

@export var _default_focus_button: Button

func _ready() -> void:
	if GameManager.is_next_level_unlocked():
		size = Vector2(60, 75) # TODO band-aid fix for incorrect sizing when instantiating
		_default_focus_button = _next_button
		_next_button.show()
	else:
		size = Vector2(60, 56)
		_next_button.hide()
	
	print("Anchors on ready: ", anchor_left, anchor_top, anchor_right, anchor_bottom)
	print("Size on ready: ", size)
	print("Position on ready: ", position)
	_retry_button.grab_focus()
	GameManager.gamestate.unpaused.connect(unpaused)

func unpaused():
	_animations.play("fade_out")
	get_viewport().gui_release_focus() # function to unfocus all gui
	await _animations.animation_finished
	queue_free()
