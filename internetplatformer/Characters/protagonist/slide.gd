extends PlayerState

@export var run_state: State
@export var idle_state: State
@export var jump_state: State
@export var fall_state: State

@onready var crouch_roof: RayCast2D = $"../../CrouchRoof"

func enter() -> void:
	parent.collision_box.play("slide")
	input_axis = Input.get_axis("move_left", "move_right")
	
	parent.velocity.x += input_axis * 10

func process_physics(delta: float) -> State:
	input_axis = Input.get_axis("move_left", "move_right")
	
	# slide deceleration
	parent.velocity.x = move_toward(parent.velocity.x, 0, 50 * delta)
	
	apply_gravity(delta)
	super(delta)
	
	#region transitions
	if Input.is_action_just_pressed("jump") and not crouch_roof.is_colliding():
		parent.collision_box.play("normal")
		return jump_state
	
	if Input.is_action_just_released("press_down"):
		if input_axis and not crouch_roof.is_colliding():
			parent.collision_box.play("normal")
			return run_state
	
	if not input_axis and not crouch_roof.is_colliding():
		parent.collision_box.play("normal")
		return idle_state
	
	if parent.velocity.y > 0 and !parent.is_on_floor():
		parent.collision_box.play("normal")
		return fall_state
	
	#endregion
	
	return null
