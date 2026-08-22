extends TextureRect

const EASY = preload("uid://bo45hpp2f62l2")
const HARD = preload("uid://bto2nvyuo4fxa")
const NORMAL = preload("uid://cq0xsapwkyqv2")

func _ready() -> void:
	GameManager.set_icon.connect(change_icon)

func change_icon(difficulty: int):
	match difficulty:
		1:
			texture = EASY
		2:
			texture = NORMAL
		3:
			texture = HARD
		_:
			texture = EASY
