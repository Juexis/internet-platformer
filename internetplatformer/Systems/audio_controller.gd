extends Node

@onready var _player_jump: AudioStreamPlayer = $PlayerJump


@onready var _startup: AudioStreamPlayer = $UISFX/Startup

func player_jump():
	_player_jump.pitch_scale = randf_range(2.00, 3.00)
	_player_jump.play()

func startup():
	_startup.play()
