extends PanelContainer

@onready var world: Node2D = $"../../"

@onready var _animation: AnimationPlayer = $WindowAnimations
@export var _default_focus_button: Button

@onready var _best_time_h_box: HBoxContainer = $OutlineMargin/VBoxContainer/BodyContainer/BodyMargin/VBoxContainer/TimerMargin/VBoxContainer/BestTimeHBox
@onready var _b_time_num: Label = %BTimeLabel
@onready var _title_box: Label = %TitleBox

@onready var _x_icon: TextureRect = %XIcon
@onready var _check_icon: TextureRect = %CheckIcon
@onready var _heart_icon: TextureRect = %HeartIcon

@onready var _next_button: Button = $OutlineMargin/VBoxContainer/BodyContainer/BodyMargin/VBoxContainer/ButtonHBoxes/NextButton
@onready var _retry_button: Button = $OutlineMargin/VBoxContainer/BodyContainer/BodyMargin/VBoxContainer/ButtonHBoxes/RetryButton
@onready var _menu_button: Button = $OutlineMargin/VBoxContainer/BodyContainer/BodyMargin/VBoxContainer/ButtonHBoxes/MenuButton

func _ready() -> void:
	GameManager.gamestate.game_over.connect(show_endscreen)
	GameManager.set_end_text.connect(set_text)
#func _process(delta: float) -> void:
	#if GameManager.is_game_active and not GameManager.player_died:
		#hide()

## change reset animation modulate alpha value to edit 
func show_endscreen():
	if GameManager.player_died:
		await get_tree().create_timer(1).timeout
		show_lose()
	
	elif GameManager.player_win:
		await get_tree().create_timer(1.75).timeout
		if GameManager.current_level < 9:
			show_win("Level Complete!")
		else:
			show_win("Thank you for Playing!!!")
	show()
	
	_animation.play("pop_in")
	_default_focus_button.grab_focus()

func show_win(win_text: String):
	_x_icon.hide()
	
	set_text(win_text)
	
	if GameManager.levels_resource.best_times[world.level_index] > 0: ## TODO make best time hide when beating level first time
		display_best_time()
		_best_time_h_box.show()
	else:
		_best_time_h_box.hide()
	
	
	if GameManager.current_level < 9: 
		_default_focus_button = _next_button
		_next_button.show()
		_check_icon.show()
	else: # changes if on last level
		_default_focus_button = _menu_button
		_next_button.hide()
		_heart_icon.show()
	
	
	

func show_lose():
	_check_icon.hide()
	
	# Only show and focus next button (and best time) if the next level has been unlocked
	if GameManager.is_next_level_unlocked():
		_default_focus_button = _retry_button
		_next_button.show()
		display_best_time()
		_best_time_h_box.show()
	else:
		_next_button.hide()
		_best_time_h_box.hide()
	AudioController.fail_screen()
	_x_icon.show()

func set_text(text: String):
	_title_box.text = text

func display_best_time():
	var best_time: int = world.get_best_time()
	var minutes = best_time / 60
	var seconds = best_time % 60
	_b_time_num.text = "%2d:%02d" % [minutes, seconds]
