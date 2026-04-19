extends Node

## called every time the progress percent changes
signal progress_changed(progress)
signal load_finished

var loading_screen: PackedScene = preload("uid://d2ojawwg4skv0") # uid for loading screen
var loaded_resource: PackedScene
var scene_path: String 
var progress: Array = [] # ResourceLoader uses arrays
var use_sub_threads: bool = true

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	set_process(false)

func load_scene(_scene_path: String) -> void:
	GameManager.is_loading = true
	scene_path = _scene_path
	
	# instantiate a new loading screen and add it to the tree
	var new_loading_screen = loading_screen.instantiate()
	add_child(new_loading_screen)
	# connecting the progress from the loading screens to the scene loader
	progress_changed.connect(new_loading_screen._on_progress_changed)
	load_finished.connect(new_loading_screen._on_loading_finished)
	
	await new_loading_screen.loading_screen_ready
	
	start_load()

func start_load() -> void:
	# requests/checks if able to use multiple threads
	var state = ResourceLoader.load_threaded_request(scene_path, "", use_sub_threads)
	if state == OK:
		set_process(true) # flag to start the loading process
	

func _process(delta: float) -> void:
	# 2nd parameter is a variable that returns the progress in an array, useful for loading bars!
	var load_status = ResourceLoader.load_threaded_get_status(scene_path, progress)
	progress_changed.emit(progress[0])
	match load_status:
		# check: load failed
		ResourceLoader.THREAD_LOAD_INVALID_RESOURCE, ResourceLoader.THREAD_LOAD_FAILED:
			set_process(false)
		ResourceLoader.THREAD_LOAD_LOADED: # load succeeded
			loaded_resource = ResourceLoader.load_threaded_get(scene_path) # returns the scene requested from line 32
			get_tree().change_scene_to_packed(loaded_resource)
			load_finished.emit()
			GameManager.is_loading = false
