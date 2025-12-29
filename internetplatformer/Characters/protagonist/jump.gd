extends PlayerState

@export var fall_state: State

var jump_vel = -225
var air_speed = 100
var air_accel = 500
var air_res = 250

func enter() -> void:
	parent.velocity.y += jump_vel

func process_physics(delta: float) -> State:
	input_axis = Input.get_axis("move_left", "move_right")
	
	if input_axis:
		parent.velocity.x = move_toward(parent.velocity.x, air_speed * input_axis, air_accel * delta)
		parent.sprite.flip_h = input_axis < 0
		parent.velocity.x = move_toward(parent.velocity.x, 0, air_res * delta)
	
	if !input_axis:
		parent.velocity.x = move_toward(parent.velocity.x, 0, air_res * 0.4 * delta)
	
	if Input.is_action_just_released("jump") and parent.velocity.y < jump_vel / 2:
			parent.velocity.y = jump_vel / 2
		
	apply_gravity(delta)
	super(delta)
	
	if parent.velocity.y > 0 and !parent.is_on_floor(): 
		return fall_state
	
	
	return null
