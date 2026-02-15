extends PanelContainer
@onready var animation: AnimationPlayer = $WindowAnimations
@export var _focus_button: Button

func _ready() -> void:
	GameManager.gamestate.game_over.connect(show_stuff)
func _process(delta: float) -> void:
	if GameManager.is_game_active:
		hide()
	#elif not GameManager.is_game_active and GameManager.player_died:

## change reset animation modulate alpha value to edit 
func show_stuff():
	await get_tree().create_timer(1).timeout
	show()
	animation.play("pop_in")
	_focus_button.grab_focus()
