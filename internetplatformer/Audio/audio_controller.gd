extends Node
# player sfx
@onready var _player_jump: AudioStreamPlayer = $PlayerSFX/PlayerJump
@onready var _hit: AudioStreamPlayer = $ObjectSFX/Hit
@onready var _explosion: AudioStreamPlayer = $PlayerSFX/Explosion
@onready var _bass: AudioStreamPlayer = $PlayerSFX/Bass
@onready var _slide: AudioStreamPlayer = $PlayerSFX/Slide

# ui sfx
@onready var _startup: AudioStreamPlayer = $UISFX/Startup
@onready var _fail: AudioStreamPlayer = $UISFX/Fail

func player_jump():
	_player_jump.pitch_scale = randf_range(0.90, 1.00)
	_player_jump.play()

func slide():
	# prevents from playing repeatedly
	if _slide.playing:
		return
	_slide.pitch_scale = randf_range(0.9, 1.1)
	_slide.play()

func stop_slide():
	_slide.stop()

func hit():
	# death hit
	if not GameManager.is_game_active:
		_hit.pitch_scale = randf_range(0.4, 0.5)
	else: # regular knock hit
		_hit.pitch_scale = randf_range(0.8, 1.0)
	_hit.play()

func explosion():
	_explosion.play()
	_bass.pitch_scale = 1.0
	_bass.play()

func speaker():
	_bass.pitch_scale = 2.0
	_bass.play()

func startup():
	_startup.play()

func skip_startup():
	_startup.stop()

func fail_screen():
	_fail.play()
