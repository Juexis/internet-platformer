extends Node2D

func _ready() -> void:
	AudioController.startup()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		AudioController.skip_startup()
