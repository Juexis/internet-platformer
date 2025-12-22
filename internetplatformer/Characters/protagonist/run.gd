extends PlayerState

@export var idle_state: State
@export var jump_state: State
@export var fall_state: State

var speed: float = 100
var acceleration: float = 1750
var friction: float = 1000

func process_physics(delta: float) -> State:
	input_axis = Input.get_axis("move_left", "move_right")
	if input_axis:
		parent.velocity.x = move_toward(parent.velocity.x, speed * input_axis, acceleration * delta)
	
	if !input_axis:
		parent.velocity.x = move_toward(parent.velocity.x, 0, friction * delta)
	
	apply_gravity(delta)
	super(delta)
	
	if Input.is_action_just_pressed("jump") and parent.is_on_floor():
		return jump_state
	
	if parent.velocity.y > 0 and !parent.is_on_floor(): 
		return fall_state
	
	## transition back to idle
	if parent.velocity.x == 0 and input_axis == 0:
		return idle_state
	
	return null
	
