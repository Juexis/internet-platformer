extends PlayerState

@export var idle_state: State
@export var run_state: State
@export var jump_state: State

@onready var jump_buffer: Timer = $"../../JumpBuffer"

var air_speed = 100
var air_accel = 500
var air_res = 250

func process_physics(delta: float) -> State:
	input_axis = Input.get_axis("move_left", "move_right")
	
	apply_gravity(delta * 1.1)
	super(delta)
	
	#print(parent.velocity.y)
	if input_axis:
		parent.velocity.x = move_toward(parent.velocity.x, air_speed * input_axis, air_accel * delta)
		parent.sprite.flip_h = input_axis < 0
		parent.velocity.x = move_toward(parent.velocity.x, 0, air_res * delta)
	
	if !input_axis:
		parent.velocity.x = move_toward(parent.velocity.x, 0, air_res * 0.4 * delta)
	
	if Input.is_action_just_pressed("jump"):
		jump_buffer.start()
		print("jump pressed")
		
	# jump buffer implementation
	if jump_buffer.time_left > 0 and parent.is_on_floor():
		print(jump_buffer.time_left)
		return jump_state
	
	if parent.is_on_floor():
		return idle_state
	
	if parent.is_on_floor() and input_axis:
		return run_state
	else:
		return null
	
	
	
