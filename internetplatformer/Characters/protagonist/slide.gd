extends PlayerState

@export var run_state: State
@export var idle_state: State
@export var jump_state: State
@export var fall_state: State

@onready var crouch_roof: RayCast2D = $"../../CrouchRoof"

func enter() -> void:
	parent.sprite.play("slide")
	parent.collision_box.play("slide")
	input_axis = Input.get_axis("move_left", "move_right")
	
	parent.velocity.x += input_axis * 15

func exit() -> void:
	AudioController.stop_slide()

func process_physics(delta: float) -> State:
	
	#region sfx
	if parent.is_on_floor():
		AudioController.slide()
	else: # disables sound midair
		AudioController.stop_slide()
	#endregion
	
	input_axis = Input.get_axis("move_left", "move_right")
	
	# slide deceleration
	parent.velocity.x = move_toward(parent.velocity.x, 0, 30 * delta)
	
	apply_gravity(delta)
	super(delta)
	
	#region transitions
	# jump transition
	if Input.is_action_just_pressed("jump") and not crouch_roof.is_colliding() and parent.is_on_floor():
		parent.collision_box.play("normal")
		return jump_state
	
	# on down release transitions
	# using not .is_action_pressed instead of just_released to auto release slide when out of tunnel
	if not Input.is_action_pressed("press_down"):
		if not crouch_roof.is_colliding():
			parent.collision_box.play("normal")
			return idle_state
		elif input_axis and not crouch_roof.is_colliding():
			parent.collision_box.play("normal")
			return run_state
	
	## test if this is better off
	#if parent.velocity.y > 0 and !parent.is_on_floor():
		#parent.collision_box.play("normal")
		#return fall_state
	
	#endregion
	
	return null
