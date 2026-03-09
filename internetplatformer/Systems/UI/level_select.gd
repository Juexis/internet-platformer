extends Panel
@onready var _level_list: ItemList = $OutlineMargin/VBox/BodyContainer/LevelsMargin/LevelList
## Set levels here
var levels: Array[PackedScene] = GameManager.levels_resource.levels

func _ready() -> void:
	#automatically grabs focus of the first level
	_level_list.grab_focus()
	_level_list.select(0)
	
	# disables tooltips
	for level in _level_list.item_count:
		_level_list.set_item_tooltip_enabled(level, false)

func _on_level_selected(index: int) -> void:
	SceneLoader.load_scene(GameManager.levels_resource.levels[index].resource_path)
