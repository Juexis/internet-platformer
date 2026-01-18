class_name Player
extends CharacterBody2D
## declare any onready var here

@onready
var sprite: AnimatedSprite2D = $AnimatedSprite2D

@onready
var collision_box: AnimationPlayer = $AnimationPlayer

@onready
var state_machine = $state_machine

var this_jump_state: State


func _ready() -> void:
	state_machine.init(self)
	this_jump_state = %jump
	ObjectsBus.speaker_entered.connect(speaker_entered)
	ObjectsBus.caution_entered.connect(caution_entered)

func _unhandled_input(input: InputEvent) -> void:
	state_machine.process_input(input)

func _physics_process(delta: float) -> void:
	#print(velocity.x)
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)

## in player.gd to prevent multiple triggers
func speaker_entered():
	this_jump_state.change_jump_vel(-400)
	state_machine.change_state(%jump)

func caution_entered(force: Vector2):
	state_machine.change_state(%knocked)
	velocity.x -= clampf(force.x * 2200, -200, 200)
	velocity.y -= clampf(force.y * 2200, -200, 200)
	print(velocity)
