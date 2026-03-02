extends Node
var gamestate = GameState.new()

var current_level: int

## when not active, player movement and timer is paused/disabled
var is_game_active: bool = true
var player_died: bool = false


class GameState:
	signal game_over

func _process(delta: float) -> void:
	# TODO pause (WIP)
	#if Input.is_physical_key_pressed(KEY_ESCAPE):
		#is_game_active = false
	
	if Input.is_physical_key_pressed(KEY_R):
		restart_level()

# TODO use current level index to restart level based on index number
func restart_level():
		is_game_active = true
		player_died = false
		print("reset")
		get_tree().change_scene_to_packed(get_tree().current_scene.current_level)
