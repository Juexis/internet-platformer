extends Interactable
@onready var sprite: AnimatedSprite2D = $Sprite

func _physics_process(delta: float) -> void:
	if is_inside and not logic_triggered:
		sprite.play("interact")
		GameManager.player_win = true
		GameManager.gamestate.game_over.emit()
		GameManager.unlock_next_level()
		GameManager.save_game()
	super(delta)
