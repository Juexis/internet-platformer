extends Node
# player sfx
@onready var _player_jump: AudioStreamPlayer = $PlayerSFX/PlayerJump
@onready var _hit: AudioStreamPlayer = $ObjectSFX/Hit
@onready var _explosion: AudioStreamPlayer = $PlayerSFX/Explosion
@onready var _bass: AudioStreamPlayer = $PlayerSFX/Bass

@onready var _startup: AudioStreamPlayer = $UISFX/Startup

func player_jump():
	_player_jump.pitch_scale = randf_range(2.00, 2.50)
	_player_jump.play()

func hit():
	# death hit
	if not GameManager.is_game_active:
		_hit.pitch_scale = randf_range(0.4, 0.5)
	else: # regular knock hit
		_hit.pitch_scale = randf_range(0.9, 1.1)
	_hit.play()

func explosion():
	_explosion.play()
	_bass.play()

func startup():
	_startup.play()
