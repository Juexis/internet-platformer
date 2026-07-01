extends Interactable
@onready var waves_sprite: AnimatedSprite2D = $waves_sprite

func _physics_process(delta: float) -> void:
	# entered and speaker hasn't pushed player yet
	if is_inside and not logic_triggered:
		waves_sprite.play("interact")
		ObjectsBus.speaker_entered.emit()
	
	super(delta)
