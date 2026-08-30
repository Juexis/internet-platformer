extends Node
# player sfx
@onready var _player_jump: AudioStreamPlayer = $PlayerSFX/PlayerJump
@onready var _hit: AudioStreamPlayer = $ObjectSFX/Hit
@onready var _explosion: AudioStreamPlayer = $PlayerSFX/Explosion
@onready var _bass: AudioStreamPlayer = $PlayerSFX/Bass
@onready var _slide: AudioStreamPlayer = $PlayerSFX/Slide

# object sfx
@onready var _paper: AudioStreamPlayer = $ObjectSFX/Paper

# ui sfx
@onready var _startup: AudioStreamPlayer = $UISFX/Startup
@onready var _fail: AudioStreamPlayer = $UISFX/Fail
@onready var _win: AudioStreamPlayer = $UISFX/Win

# songs
var current_song: GameManager.SongList = GameManager.SongList.NONE
@onready var ost: Node = $OST
@onready var _floating_point: AudioStreamPlayer = $"OST/Floating Point"
@onready var _blu_shop: AudioStreamPlayer = $OST/BluShop
@onready var _logging_out: AudioStreamPlayer = $"OST/Logging Out"

func _ready() -> void:
	GameManager.gamestate.start_song.connect(song_picker)

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

func paper():
	_paper.pitch_scale = randf_range(0.7, 1)
	_paper.play()
	

func explosion():
	_explosion.play()
	_bass.pitch_scale = 1.0
	_bass.play()

func speaker():
	_bass.pitch_scale = 2.0
	_bass.play()

func startup():
	_startup.play()

func fail_screen():
	_fail.play()

func win_screen():
	_win.play()

func song_picker(bgm: GameManager.SongList):
	# stop the current song if the next one is different
	if bgm != current_song:
		for i: AudioStreamPlayer in ost.get_children():
			i.stop()
	
	# allows the current song to keep playing if song_start() emits the same song (on restarts and levels with same song)
	if current_song == bgm:
		return
	match bgm:
		GameManager.SongList.FLOATING_POINT:
			current_song = GameManager.SongList.FLOATING_POINT
			_floating_point.play()
		GameManager.SongList.BLUSHOP:
			current_song = GameManager.SongList.BLUSHOP
			_blu_shop.play()
		GameManager.SongList.LOGGINGOUT:
			current_song = GameManager.SongList.LOGGINGOUT
			_logging_out.play()

## -- STOP functions --

func skip_startup():
	_startup.stop()

func stop_paper():
	_paper.stop()

func stop_bgm():
	for i: AudioStreamPlayer in ost.get_children():
		i.stop()
	current_song = GameManager.SongList.NONE
