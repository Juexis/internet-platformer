extends PlayerState

@export var fall_state: State

@onready var knocked_timer: Timer = $"../../KnockedTimer"
@onready var timeout_timer: Timer = $"../../TimeoutTimer"

func enter() -> void:
	if timeout_timer.is_stopped():
		timeout_timer.start()
	knocked_timer.start()
	parent.sprite.play("knocked")
	parent.sprite_animations.play("hit")
	parent.collision_box.play("normal")

func process_physics(delta: float) -> State:
	print(timeout_timer.time_left)
	if knocked_timer.time_left <= 0:
		parent.sprite_animations.play("RESET")
		timeout_timer.stop()
		return fall_state
	
	apply_gravity(delta)
	super(delta)
	return null
