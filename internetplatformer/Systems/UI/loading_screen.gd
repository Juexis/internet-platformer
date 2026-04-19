extends CanvasLayer

signal loading_screen_ready
@export var animation: AnimationPlayer

func _ready() -> void:
	await animation.animation_finished
	loading_screen_ready.emit()

## can make progress bar/visuals based on progress
func _on_progress_changed(new_value: float) -> void:
	pass

func _on_loading_finished() -> void:
	animation.play("close_out")
	get_tree().paused = false
	await animation.animation_finished
	queue_free()
