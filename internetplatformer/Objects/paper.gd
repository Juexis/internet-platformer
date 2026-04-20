extends Interactable

@onready var paper_anims: AnimationPlayer = $PaperAnims
@onready var particle: CPUParticles2D = $PaperBallParticle
@onready var disappear_timer: Timer = $DisappearTimer

func _ready() -> void:
	# runs when signal is emitted, overrides the pause
	# allows it to run
	GameManager.gamestate.paused.connect(paused)
	GameManager.gamestate.unpaused.connect(unpaused)

func _physics_process(delta: float) -> void:
	if not GameManager.is_game_active:
		return
	
	if is_inside and was_inside and not logic_triggered:
		paper_anims.play("crumple")
		logic_triggered = true # flags crumple as done, wont activate anymore
		interaction_area.monitoring = false # turns off monitoring so it wont get retriggered upon re-entry
		disappear_timer.start()
		await disappear_timer.timeout # timer to allow for particle to spawn, paper is functionally useless at this point
		queue_free()
	#print(disappear_timer.time_left)
	super(delta)

func paused():
	get_tree().paused = true

func unpaused():
	get_tree().paused = false
