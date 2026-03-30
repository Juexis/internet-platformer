extends Node
# player sfx
@onready var _player_jump: AudioStreamPlayer = $PlayerSFX/PlayerJump
@onready var _hit: AudioStreamPlayer = $ObjectSFX/Hit
@onready var _explosion: AudioStreamPlayer = $PlayerSFX/Explosion
@onready var _bass: AudioStreamPlayer = $PlayerSFX/Bass

# ui sfx
@onready var _startup: AudioStreamPlayer = $UISFX/Startup
@onready var _fail: AudioStreamPlayer = $UISFX/Fail

func player_jump():
	_player_jump.pitch_scale = randf_range(0.90, 1.00)
	_player_jump.play()

func hit():
	# death hit
	if not GameManager.is_game_active:
		_hit.pitch_scale = randf_range(0.4, 0.5)
	else: # regular knock hit
		_hit.pitch_scale = randf_range(0.8, 1.0)
	_hit.play()

func explosion():
	_explosion.play()
	_bass.play()

func startup():
	_startup.play()

func fail_screen():
	_fail.play()
