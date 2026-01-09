extends PlayerState

@export var idle_state: State
@export var jump_state: State
@export var fall_state: State
@export var slide_state: State

@onready var coyote_timer: Timer = $"../../CoyoteTimer"

var speed: float = 125
var acceleration: float = 750
var friction: float = 900


func enter() -> void:
	parent.sprite.play("run")

func process_physics(delta: float) -> State:
	input_axis = Input.get_axis("move_left", "move_right")
	if input_axis:
		parent.velocity.x = move_toward(parent.velocity.x, speed * input_axis, acceleration * delta)
		enable_sprite_flip()
	
	if !input_axis:
		parent.velocity.x = move_toward(parent.velocity.x, 0, friction * delta)
	
	apply_gravity(delta)
	super(delta)
	
	#region transitions
	if Input.is_action_just_pressed("jump") and parent.is_on_floor():
		return jump_state
	
	if Input.is_action_pressed("press_down") and (x_speed == speed or x_speed == -speed):
		return slide_state
	
	if parent.velocity.y > 0 and !parent.is_on_floor():
		coyote_timer.start()
		return fall_state
	
	## transition back to idle
	if parent.velocity.x == 0 and input_axis == 0:
		return idle_state
	
	#endregion
	return null
