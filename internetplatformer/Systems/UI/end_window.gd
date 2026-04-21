extends PanelContainer
@onready var _animation: AnimationPlayer = $WindowAnimations
@export var _default_focus_button: Button

@onready var _x_icon: TextureRect = $OutlineMargin/VBoxContainer/BodyContainer/BodyMargin/VBoxContainer/MarginContainer/XIcon
@onready var _check_icon: TextureRect = $OutlineMargin/VBoxContainer/BodyContainer/BodyMargin/VBoxContainer/MarginContainer/CheckIcon
@onready var _next_button: Button = $OutlineMargin/VBoxContainer/BodyContainer/BodyMargin/VBoxContainer/ButtonHBoxes/NextButton
@onready var _retry_button: Button = $OutlineMargin/VBoxContainer/BodyContainer/BodyMargin/VBoxContainer/ButtonHBoxes/RetryButton

func _ready() -> void:
	GameManager.gamestate.game_over.connect(show_endscreen)
#func _process(delta: float) -> void:
	#if GameManager.is_game_active and not GameManager.player_died:
		#hide()

## change reset animation modulate alpha value to edit 
func show_endscreen():
	await get_tree().create_timer(1).timeout
	show()
	if GameManager.player_died:
		show_lose()
	
	elif GameManager.player_win:
		show_win()
	
	_animation.play("pop_in")
	_default_focus_button.grab_focus()

func show_win():
	_x_icon.hide()
	
	_default_focus_button = _next_button
	_check_icon.show()
	_next_button.show()

func show_lose():
	_check_icon.hide()
	
	_default_focus_button = _retry_button
	AudioController.fail_screen()
	_x_icon.show()
	_next_button.hide()
