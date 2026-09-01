class_name LevelList
extends Resource
## Level list, used in level_list.tres to set export variables in game_manager global
@export var levels: Array[PackedScene]
@export var flag_unlocked: Array[bool]
@export var best_times: Array[int]
@export var level_names: Array[String]
func _init() -> void:
	flag_unlocked.resize(10)
	flag_unlocked.fill(false)
	flag_unlocked[0] = true
	best_times.resize(10)
	best_times.fill(0)
