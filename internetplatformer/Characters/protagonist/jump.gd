extends PlayerState

@export var fall_state: State

var jump_vel = -200
var air_speed = 75
var air_accel = 600
var air_res = 200

func enter() -> void:
	parent.velocity.y += jump_vel

func process_physics(delta: float) -> State:
	apply_gravity(delta)
	super(delta)
	
	if input_axis:
		parent.velocity.x = move_toward(parent.velocity.x, air_speed * input_axis, air_accel * delta)
	else:
		parent.velocity.x = move_toward(parent.velocity.x, 0, air_res * delta)
	
	if parent.velocity.y > 0: 
		return fall_state
	
	return null
