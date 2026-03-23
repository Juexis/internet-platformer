extends Node

@onready var _player_jump: AudioStreamPlayer = $PlayerJump

func play_player_jump():
	_player_jump.pitch_scale = randf_range(2.00, 2.50)
	_player_jump.play()
