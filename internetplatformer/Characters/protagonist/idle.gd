extends PlayerState

@export var run_state: State

func process_physics(delta: float) -> State:
	apply_gravity(delta)
	super(delta)
	
	if input_axis:
		return run_state
	
	return null
