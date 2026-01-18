class_name StateMachine
extends Node

@export var starting_state: State
var current_state: State

func init(parent) -> void:
		for child in get_children():
			child.parent = parent
		
		change_state(starting_state)

func change_state(new_state: State):
	if current_state:
		current_state.exit()
	current_state = new_state
	current_state.enter()

func process_input(input: InputEvent) -> void:
	var new_state = current_state.process_input(input)
	if new_state:
		change_state(new_state)

func process_physics(delta: float) -> void:
	var new_state = current_state.process_physics(delta)
	print(current_state)
	if new_state:
		change_state(new_state)

func process_frame(delta: float) -> void:
	var new_state = current_state.process_frame(delta)
	if new_state:
		change_state(new_state)
