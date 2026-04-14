extends Interactable

@onready var paper_anims: AnimationPlayer = $PaperAnims
@onready var particle: CPUParticles2D = $PaperBallParticle

func _ready() -> void:
	# runs when signal is emitted, overrides the pause
	# allows it to run
	GameManager.gamestate.paused.connect(paused) 

func _physics_process(delta: float) -> void:
	if not GameManager.is_game_active: # this + signal fixed it
		return
	
	if is_inside and was_inside and not logic_triggered:
		paper_anims.play("crumple")
		await paper_anims.animation_finished and particle.finished # TODO fix particle being cut off
		queue_free()
	
	super(delta)

func paused():
	paper_anims.pause()
