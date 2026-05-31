extends Node2D

@export var level_name: String
@export var level_index: int
var best_time: int

@onready var windows: TileMapLayer = $LevelElements/Windows
@onready var objects: TileMapLayer = $LevelElements/Objects
@onready var Level_Time: Label = $"UI/TitleBarPanel/TitleBar Margin/HBoxContainer/TimeLabel"

func _ready() -> void:
	GameManager.gamestate.game_over.connect(set_best_time)
	process_mode = Node.PROCESS_MODE_PAUSABLE
	GameManager.current_level = level_index
	GameManager.is_game_active = true
	GameManager.player_win = false
	GameManager.player_died = false


func set_best_time():
	if not GameManager.player_win:
		return
	
	var this_time: int = Level_Time.get_total_seconds()
	if this_time < GameManager.levels_resource.best_times[level_index] or GameManager.levels_resource.best_times[level_index] == 0:
		GameManager.levels_resource.best_times[level_index] = this_time
		print("new best time saved!")

func get_best_time():
	return GameManager.levels_resource.best_times[level_index]
