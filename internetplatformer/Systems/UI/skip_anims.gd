extends UIAnimation

@export var anim_to_skip: String

func _process(delta: float) -> void:
	if is_playing() == false:
		return
	if Input.is_action_just_pressed("pause"):
		skip_anim(anim_to_skip)
