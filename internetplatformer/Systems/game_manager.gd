extends Node
var gamestate = GameState.new()
var levels_resource = preload("res://Systems/level_list.tres")
var current_level: int
var pause_screen: PackedScene = preload("res://Systems/UI/pause_window.tscn")

## when not active, player movement and timer is paused/disabled
var is_game_active: bool = true
var player_died: bool = false
var player_win: bool = false
var is_loading: bool = false
signal set_end_text(text: String)
signal get_time

#region debug
@export var full_reset: bool = false:
	set(v): reset_save_file()

@export var default_save_file: bool = false:
	set(v): default_save()

@export var unlock_all_levels: bool = false:
	set(v): unlock_all()

@export var reset_best_times: bool = false:
	set(v): reset_times()
#endregion

class GameState:
	signal game_over
	signal paused
	signal unpaused

func _ready() -> void:
	get_tree().auto_accept_quit = false
	
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	if FileAccess.file_exists("user://savedata.tres"):
		load_game()
	else:
		save_game()

# triggers on game exit
func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		game_exit()

func _process(delta: float) -> void:
	#region debug
	if Input.is_action_just_pressed("debug_save"):
		save_game()
	
	if Input.is_action_just_pressed("debug_load"):
		load_game()
		
	if Input.is_physical_key_pressed(KEY_R):
		restart_level()
	
	#endregion
	if not is_game_active:
		get_viewport().gui_disable_input = false
	
	## PAUSING
	if Input.is_action_just_pressed("pause") and is_game_active and not player_died:
		pause()
	elif Input.is_action_just_pressed("pause") and not is_game_active and not player_died and not player_win:
		unpause()

func pause():
		if get_node("/root/MainMenu"):
			return
		gamestate.paused.emit()
		is_game_active = false
		get_node("/root/world").get_tree().paused = true
		var pause_instance = pause_screen.instantiate()
		if get_node_or_null("/root/world/UI/PauseWindow"): ## TODO unpausing after opening level select requires two "esc" presses
			return
		else:
			get_node("/root/world/UI").add_child(pause_instance)

func unpause():
	is_game_active = true
	get_node("/root/world").get_tree().paused = false
	gamestate.unpaused.emit()

func _exit_tree() -> void:
	save_game()

func restart_level():
		# await the load scene before setting game to active
		await SceneLoader.load_scene(levels_resource.levels[current_level].resource_path)
		is_game_active = true
		player_died = false
		print("reset")

func next_level():
	SceneLoader.load_scene(levels_resource.levels[current_level + 1].resource_path)

func is_next_level_unlocked() -> bool:
	return GameManager.levels_resource.flag_unlocked[GameManager.current_level + 1]

func unlock_next_level():
	if current_level <= 9 and not is_next_level_unlocked():
		GameManager.levels_resource.flag_unlocked[GameManager.current_level + 1] = true

func save_game():
	# creates a new SaveFile resource
	var save: SaveFile = SaveFile.new()
	
	# sets the current levels unlocked to the file
	save.levels_unlocked = levels_resource.flag_unlocked
	save.level_times = levels_resource.best_times
	
	# saves the file in "savedata.tres"
	ResourceSaver.save(save, "user://savedata.tres")
	print("game saved!")

func load_game():
	var save: SaveFile = load("user://savedata.tres")
	
	# loads the data from "savedata.tres"
	levels_resource.flag_unlocked = save.levels_unlocked
	levels_resource.best_times = save.level_times
	print("game loaded!")

func game_exit():
	save_game()
	get_tree().quit()

#region debug functions
func unlock_all():
	levels_resource.flag_unlocked.fill(true)

func default_save():
	levels_resource.flag_unlocked.fill(false)
	levels_resource.flag_unlocked[0] = true

func reset_times():
	levels_resource.best_times.fill(0)

func reset_save_file():
	default_save()
	reset_times()
#endregion
