extends PlayerState

@export var fall_state: State

@onready var knocked_timer: Timer = $"../../KnockedTimer"

func enter() -> void:
	knocked_timer.start()
	parent.sprite_animations.play("hit")

func process_physics(delta: float) -> State:
	if knocked_timer.time_left <= 0:
		parent.sprite_animations.play("RESET")
		return fall_state
	
	apply_gravity(delta)
	super(delta)
	return null
