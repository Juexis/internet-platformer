extends PlayerState

@export var fall_state: State

var current_jump_vel
var standard_jump_vel = -235
var air_speed = 125
var air_accel = 500
var air_res = 250
var is_speaker_jump: bool = false

# TODO fix player's jump being added when jumping simutaneously while entering the speaker's range
func enter() -> void:
	parent.collision_box.play("normal")
	if Input.is_action_just_pressed("jump"):
		change_jump_vel(standard_jump_vel)
		AudioController.play_player_jump()
	clamp(parent.velocity.y, 0, current_jump_vel)
	parent.sprite.play("jump")
	parent.velocity.y += current_jump_vel

func process_physics(delta: float) -> State:
	#region horizontal movement
	input_axis = Input.get_axis("move_left", "move_right")
	
	if input_axis:
		parent.velocity.x = move_toward(parent.velocity.x, air_speed * input_axis, air_accel * delta)
		enable_sprite_flip()
		parent.velocity.x = move_toward(parent.velocity.x, 0, air_res * delta) # add air res while moving too
	
	if !input_axis:
		parent.velocity.x = move_toward(parent.velocity.x, 0, air_res * 0.4 * delta)
	
	#endregion
	# variable jump height
	if Input.is_action_just_released("jump") and parent.velocity.y < current_jump_vel / 2 and not is_speaker_jump:
			parent.velocity.y = current_jump_vel / 2
	
	apply_gravity(delta)
	super(delta)
	
	#region transitions
	if parent.velocity.y > 0 and !parent.is_on_floor(): 
		return fall_state
	
	#endregion
	return null

func change_jump_vel(value: float):
	# disables jump cancelling (variable jump height: 33-34)
	if value < standard_jump_vel:
		is_speaker_jump = true
	else:
		is_speaker_jump = false
	current_jump_vel = value
