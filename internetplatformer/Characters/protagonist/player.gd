class_name Player
extends CharacterBody2D
## declare any onready var here

@onready
var sprite: AnimatedSprite2D = $AnimatedSprite2D

@onready
var collision_box: AnimationPlayer = $CollisionChanges

@onready
var sprite_animations: AnimationPlayer = $SpriteAnimations

@onready
var state_machine = $state_machine

## death variables
@onready
var death_particles: Node = $DeathParticles
@onready 
var death_anim_timer: Timer = $DeathAnimTimer

var this_jump_state: State
var max_knock: float = 200
var min_knock: float = -200

func _ready() -> void:
	state_machine.init(self)
	this_jump_state = %jump
	ObjectsBus.speaker_entered.connect(speaker_entered)
	ObjectsBus.caution_entered.connect(caution_entered)
	GameManager.gamestate.game_over.connect(game_over)
	GameManager.gamestate.paused.connect(_on_paused)

func _unhandled_input(input: InputEvent) -> void:
	if GameManager.is_game_active:
		state_machine.process_input(input)

func _physics_process(delta: float) -> void:
	if GameManager.is_game_active:
		state_machine.process_physics(delta)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)

## in player.gd to prevent multiple triggers
func speaker_entered():
	this_jump_state.change_jump_vel(-400)
	state_machine.change_state(%jump)

func caution_entered(force: Vector2):
	state_machine.change_state(%knocked)
	# multiply force to force consistant knockback values
	velocity.x -= clampf(force.x * 2200, min_knock, max_knock)
	velocity.y -= clampf(force.y * 2200, min_knock, max_knock)
	print(velocity)

func game_over():
	GameManager.is_game_active = false
	GameManager.player_died = true
	sprite.play("knocked")
	sprite_animations.play("death")
	death_anim_timer.start()

func _on_death_anim_timer_timeout() -> void:
	for particles in death_particles.get_children():
		particles.emitting = true
	sprite.hide()

func _on_paused():
	sprite.pause()
