class_name Interactable
extends StaticBody2D

## dependency injection for the area_2d in the inspector
@export var interaction_path : NodePath
@onready var interaction_area: Area2D = get_node(interaction_path)

var _is_inside: bool = false
var _was_inside: bool = false
var _logic_triggered = false ## flag for if the object has already done its thing

func _physics_process(_delta: float) -> void:
	_is_inside = false # set back to false if not inside
	
	_check_player_inside()
	
	# checks for enter (rising edge)
	if _is_inside and not _was_inside:
		pass
	
	# checks for exit (falling edge)
	if _was_inside and not _is_inside:
		pass
	
	## removes logic flag, allowing the object to act again
	if not _is_inside:
		_logic_triggered = false
	
	# check for continuous inside
	if _is_inside and _was_inside:
		_is_inside_continuous()
	
	_was_inside = _is_inside # _was_inside acts as memory of the previous state 

func detect_player() -> bool:
	for body in interaction_area.get_overlapping_bodies():
		if body.name == "Player":
			return true
	return false

## checks for if the player is in the interaction area if so then [member Interactable._is_inside] is [code]true[/code]
func _check_player_inside():
	if detect_player():
		_is_inside = true

func _is_inside_continuous():
	if _logic_triggered: # if logic already happened, nothing happens
		return
	_logic_triggered = true # if not then set the flag
