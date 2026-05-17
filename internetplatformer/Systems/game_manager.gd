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

#region debug
@export var default_save_file: bool = false:
	set(v): default_save()

@export var unlock_all_levels: bool = false:
	set(v): unlock_all()
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
		gamestate.paused.emit()
		is_game_active = false
		get_node("/root/world").get_tree().paused = true
		var pause_instance = pause_screen.instantiate()
		get_node("/root/world/UI").add_child(pause_instance)
	elif Input.is_action_just_pressed("pause") and not is_game_active and not player_died and not player_win:
		GameManager.is_game_active = true
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
	
	# saves the file in "savedata.tres"
	ResourceSaver.save(save, "user://savedata.tres")
	print("game saved!")

func load_game():
	var save: SaveFile = load("user://savedata.tres")
	
	# loads the data from "savedata.tres"
	levels_resource.flag_unlocked = save.levels_unlocked
	print("game loaded!")

func game_exit():
	save_game()
	get_tree().quit()

#region debug functions
func unlock_all():
	for i in levels_resource.flag_unlocked:
		levels_resource.flag_unlocked.fill(true)

func default_save():
	for i in levels_resource.flag_unlocked:
		levels_resource.flag_unlocked.fill(false)
	levels_resource.flag_unlocked[0] = true

#endregion
