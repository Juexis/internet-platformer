extends Panel
@onready var _animations: AnimationPlayer = $WindowAnimations
@onready var _retry_button: Button = $OutlineMargin/VBox/BodyContainer/MarginContainer/VBoxContainer/RetryButton
@onready var _menu_button: Button = $OutlineMargin/VBox/BodyContainer/MarginContainer/VBoxContainer/MenuButton

func _ready() -> void:
	_retry_button.grab_focus()
	GameManager.gamestate.unpaused.connect(unpaused)

func unpaused():
	_animations.play("fade_out")
	get_viewport().gui_release_focus() # function to unfocus all gui
	GameManager.is_game_active = true
	await _animations.animation_finished
	queue_free()
