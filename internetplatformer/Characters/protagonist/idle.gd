extends PlayerState

@export var run_state: State
@export var jump_state: State
@export var fall_state: State

var friction: float = 500

func enter() -> void:
	parent.sprite.play("idle")

func process_physics(delta: float) -> State:
	input_axis = Input.get_axis("move_left", "move_right")
	get_tile_data()
	if parent.velocity.x != 0:
		parent.velocity.x = move_toward(parent.velocity.x, 0, friction * delta)
	
	apply_gravity(delta)
	super(delta)
	
	#region transitions
	if input_axis:
		return run_state
	
	if Input.is_action_just_pressed("jump") and parent.is_on_floor():
		return jump_state
	
	if parent.velocity.y > 0:
		return fall_state
	
	#if Input.is_action_just_pressed("move_down") and parent.is_on_floor():
		#get_object_data()
		#return
	
	#endregion
	return null
