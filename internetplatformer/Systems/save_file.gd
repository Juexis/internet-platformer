class_name SaveFile
extends Resource

@export var levels_unlocked: Array[bool] = []

func _init() -> void:
	levels_unlocked.resize(10)
	levels_unlocked.fill(false)
