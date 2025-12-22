extends PlayerState

@export var idle_state: State
@export var run_state: State

var air_speed = 75
var air_accel = 600
var air_res = 600

func process_physics(delta: float) -> State:
	input_axis = Input.get_axis("move_left", "move_right")
	
	apply_gravity(delta * 1.2)
	super(delta)
	
	print(parent.velocity.y)
	if input_axis:
		parent.velocity.x = move_toward(parent.velocity.x, air_speed * input_axis, air_accel * delta)
	else:
		parent.velocity.x = move_toward(parent.velocity.x, 0, air_res * delta)
	
	
	if parent.is_on_floor() and parent.velocity.x == 0:
		return idle_state
	
	if parent.is_on_floor() and input_axis:
		return run_state
	else:
		return null
	
	
	
