extends PlayerState

@export var fall_state: State

@onready var knocked_timer: Timer = $"../../KnockedTimer"

func enter() -> void:
	knocked_timer.start()

func process_physics(delta: float) -> State:
	if knocked_timer.time_left <= 0:
		return fall_state
	
	apply_gravity(delta)
	super(delta)
	return null
