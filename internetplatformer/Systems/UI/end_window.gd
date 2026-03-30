extends PanelContainer
@onready var animation: AnimationPlayer = $WindowAnimations
@export var _focus_button: Button

func _ready() -> void:
	GameManager.gamestate.game_over.connect(show_stuff)
func _process(delta: float) -> void:
	if GameManager.is_game_active and not GameManager.player_died:
		hide()

## change reset animation modulate alpha value to edit 
func show_stuff():
	await get_tree().create_timer(1).timeout
	show() 
	AudioController.fail_screen() ## TODO create flag for win/lose to play and show appropriate screen
	animation.play("pop_in")
	_focus_button.grab_focus()
