extends PlayerState

@export var run_state: State
@export var jump_state: State
@export var fall_state: State

func enter() -> void:
	parent.sprite.play("idle")

func process_physics(delta: float) -> State:
	input_axis = Input.get_axis("move_left", "move_right")
	if parent.velocity.x != 0:
		parent.velocity.x = move_toward(parent.velocity.x, 0, 500 * delta)
	
	apply_gravity(delta)
	super(delta)
	
	#region transitions
	if input_axis:
		return run_state
	
	if Input.is_action_just_pressed("jump") and parent.is_on_floor():
		return jump_state
	
	if parent.velocity.y > 0:
		return fall_state
	
	#endregion
	return null
