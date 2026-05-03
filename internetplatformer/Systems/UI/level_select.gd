extends Panel
@onready var _level_list: ItemList = %LevelList
# from game_manager.gd -> levels_resource.tres -> levels array in levels_resource.tres
var levels: Array[PackedScene] = GameManager.levels_resource.levels

func _ready() -> void:
	#automatically grabs focus of the first level
	_level_list.grab_focus()
	_level_list.select(GameManager.current_level)
	
	# sets levels to be enabled based on the levels_resource
	for i in _level_list.item_count:
		if GameManager.levels_resource.flag_unlocked[i] == true:
			_level_list.set_item_disabled(i, false)
	
	# disables tooltips
	for level in _level_list.item_count:
		_level_list.set_item_tooltip_enabled(level, false)

func _on_level_selected(index: int) -> void:
	if GameManager.is_loading:
		return
	SceneLoader.load_scene(GameManager.levels_resource.levels[index].resource_path)
