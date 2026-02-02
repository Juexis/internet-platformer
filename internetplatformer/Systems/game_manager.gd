extends Node
var gamestate = GameState.new()

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

func restart_level():
		is_game_active = true
		player_died = false
		print("reset")
		get_tree().change_scene_to_file("res://Levels/game.tscn")
