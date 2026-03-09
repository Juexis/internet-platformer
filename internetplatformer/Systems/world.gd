extends Node2D

@export var level_name: String
@export var level_index: int
@export var next_level: PackedScene
var total_time

func _ready() -> void:
	GameManager.current_level = level_index

func _process(delta: float) -> void:
	total_time = Time.get_ticks_msec()

#func get_scene_path() -> 
