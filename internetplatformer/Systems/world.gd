extends Node2D

var total_time


func _process(delta: float) -> void:
	total_time = Time.get_ticks_msec()
