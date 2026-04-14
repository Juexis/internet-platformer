extends Interactable

@onready var paper_anims: AnimationPlayer = $PaperAnims
@onready var particle: CPUParticles2D = $PaperBallParticle

func _ready() -> void:
	GameManager.gamestate.paused.connect(paused)

func _physics_process(delta: float) -> void:
	print(paper_anims.is_animation_active())
	if is_inside and not logic_triggered:
		paper_anims.play("crumple")
		await paper_anims.animation_finished and particle.finished
		queue_free()
	
	super(delta)

func paused():
	paper_anims.pause()
