extends Node
var gamestate = GameState.new()

## when not active, player movement and timer is paused/disabled
var is_game_active: bool = true

class GameState:
	signal game_over

func _process(delta: float) -> void:
	restart_level()

func restart_level():
	if Input.is_physical_key_pressed(KEY_R):
		is_game_active = true
		get_tree().change_scene_to_file("res://Levels/game.tscn")
