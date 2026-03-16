extends Node
var gamestate = GameState.new()
var levels_resource = preload("res://Systems/level_list.tres")
var current_level: int
var pause_screen: PackedScene = preload("res://Systems/UI/pause_window.tscn")

## when not active, player movement and timer is paused/disabled
var is_game_active: bool = true
var player_died: bool = false
var is_loading: bool = false


class GameState:
	signal game_over
	signal unpaused

func _process(delta: float) -> void:
	# TODO pause system
	
	if not is_game_active:
		get_viewport().gui_disable_input = false
	
	if Input.is_action_just_pressed("pause") and is_game_active and not player_died:
		is_game_active = false
		var pause_instance = pause_screen.instantiate()
		get_node("/root/world/UI").add_child(pause_instance)
	elif Input.is_action_just_pressed("pause") and not is_game_active and not player_died:
		gamestate.unpaused.emit()
	
	if Input.is_physical_key_pressed(KEY_R):
		restart_level()

func restart_level():
		# await the load scene before setting game to active
		await SceneLoader.load_scene(levels_resource.levels[current_level].resource_path)
		is_game_active = true
		player_died = false
		print("reset")
		
