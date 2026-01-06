## Used for states specifically for the Player character
@abstract class_name PlayerState
extends State

var parent: CharacterBody2D
## Records player's left and right inputs, returns -1, 0, or 1
var input_axis: float
var x_speed: float
var gravity_mult: float = 0.7

func process_physics(delta: float) -> State:
	parent.move_and_slide()
	x_speed = get_xspeed()
	return null

func apply_gravity(delta):
	parent.velocity += parent.get_gravity() * 0.7 * delta

func get_xspeed() -> float:
	return parent.velocity.x
