extends Label

var minutes: int
var seconds: int
var total_seconds: int

func _process(delta: float) -> void:
	minutes = total_seconds / 60
	seconds = total_seconds % 60
	if GameManager.is_game_active:
		text = "%2d:%02d" % [minutes, seconds]

func _on_timer_timeout() -> void:
	if GameManager.is_game_active:
		total_seconds += 1

func get_total_seconds() -> int:
	return total_seconds
