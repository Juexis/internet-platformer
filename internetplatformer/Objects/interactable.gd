class_name Interactable
extends StaticBody2D

## dependency injection for the area_2d in the inspector
@export var interaction_path : NodePath # assign interaction area to this!
@onready var interaction_area: Area2D = get_node(interaction_path)

var is_inside: bool = false
var was_inside: bool = false
var logic_triggered = false ## flag for if the object has already done its thing

func _physics_process(_delta: float) -> void:
	
	is_inside = false # set back to false if not inside
	
	_check_player_inside()
	
	# checks for enter (rising edge)
	if is_inside and not was_inside:
		pass
	
	# checks for exit (falling edge)
	if was_inside and not is_inside:
		pass
	
	## removes logic flag, allowing the object to act again
	if not is_inside:
		logic_triggered = false
	
	# check for continuous inside
	if is_inside and was_inside:
		_is_inside_continuous()
	
	was_inside = is_inside # was_inside acts as memory of the previous state 

func detect_player() -> bool:
	if not interaction_area.monitoring: # for paper when stepped on, monitoring is turned off
		return false
	for body in interaction_area.get_overlapping_bodies():
		if body.name == "Player":
			return true
	return false

## checks for if the player is in the interaction area if so then [member Interactable.is_inside] is [code]true[/code]
func _check_player_inside():
	if detect_player():
		is_inside = true

func _is_inside_continuous():
	if logic_triggered: # if logic already happened, nothing happens
		return
	logic_triggered = true # if not then set the flag
