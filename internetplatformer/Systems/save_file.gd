class_name SaveFile
extends Resource

@export var levels_unlocked: Array[bool] = []
@export var level_times: Array[int] = []

func _init() -> void:
	levels_unlocked.resize(10)
	levels_unlocked.fill(false)
	level_times.resize(10)
	level_times.fill(0)
