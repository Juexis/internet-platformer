extends PlayerState

@export var run_state: State
@export var idle_state: State
@export var jump_state: State
@export var fall_state: State

func enter() -> void:
	parent.animations.play("slide")
	input_axis = Input.get_axis("move_left", "move_right")
	
	parent.velocity.x += input_axis * 10

func process_physics(delta: float) -> State:
	input_axis = Input.get_axis("move_left", "move_right")
	
	apply_gravity(delta)
	super(delta)
	
	# slide deceleration
	parent.velocity.x = move_toward(parent.velocity.x, 0, 50 * delta)
	
	if Input.is_action_just_pressed("jump"):
		parent.animations.play("normal")
		return jump_state
	
	if Input.is_action_just_released("press_down"):
		if input_axis:
			parent.animations.play("normal")
			return run_state
		else:
			parent.animations.play("normal")
			return idle_state
	
	if parent.velocity.y > 0 and !parent.is_on_floor():
		parent.animations.play("normal")
		return fall_state
	
	return null
