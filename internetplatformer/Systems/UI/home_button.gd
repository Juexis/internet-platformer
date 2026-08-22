extends Button

const MAIN_MENU = "uid://c25ktv7xd8ocs"

func _process(delta: float) -> void:
	if GameManager.level_check():
		show()
	else:
		hide()

func _on_pressed() -> void:
	SceneLoader.load_scene(MAIN_MENU)
	AudioController.stop_bgm()
