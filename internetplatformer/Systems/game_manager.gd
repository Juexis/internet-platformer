extends Node
var gamestate = GameState.new()

var is_game_active: bool = true

class GameState:
	signal game_over
