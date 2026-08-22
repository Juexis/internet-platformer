extends Node2D

func _ready() -> void:
	AudioController.startup()
	GameManager.current_level = -1

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		AudioController.skip_startup()
