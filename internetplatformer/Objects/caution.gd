extends Interactable

@onready var sprite: AnimatedSprite2D = $Sprite

var player_force

func _physics_process(delta: float) -> void:
	if is_inside:
		for body in interaction_area.get_overlapping_bodies():
			if body.name == "Player":
				player_force = body.get_last_motion()
	
	if is_inside and was_inside and not logic_triggered:
		sprite.play("interact")
		ObjectsBus.caution_entered.emit(player_force)
	
	super(delta)
