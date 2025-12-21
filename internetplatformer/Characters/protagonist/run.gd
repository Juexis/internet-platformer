extends PlayerState

@export var idle_state: State

var speed: float = 100
var acceleration: float = 1750

func process_physics(delta: float) -> State:
	if input_axis:
		parent.velocity.x = move_toward(parent.velocity.x, speed * input_axis, acceleration * delta)
	
	if !input_axis:
		parent.velocity.x = move_toward(parent.velocity.x, 0, 2000 * delta)
	
	super(delta)
	apply_gravity(delta)
	
	## transition back to idle
	if parent.velocity.x == 0 and input_axis == 0:
		return idle_state
	
	return null
	
