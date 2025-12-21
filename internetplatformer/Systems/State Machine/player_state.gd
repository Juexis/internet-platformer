## Used for states specifically for the Player character
@abstract class_name PlayerState
extends State

var parent: CharacterBody2D
## Records player's left and right inputs, returns -1, 0, or 1
var input_axis: int

func process_physics(delta: float) -> State:
	parent.move_and_slide()
	input_axis = Input.get_axis("move_left", "move_right")
	return null

func apply_gravity(delta):
	parent.velocity += parent.get_gravity() * 0.6 * delta
