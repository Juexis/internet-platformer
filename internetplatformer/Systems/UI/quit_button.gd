extends Button

func _ready() -> void:
	# hides the quit button on web build, as it isn't needed
	if OS.has_feature("web"):
		hide()

func _pressed() -> void:
	GameManager.game_exit()
