class_name Player
extends CharacterBody2D
## declare any onready var here

@onready
var sprite: Sprite2D = $Sprite2D
@onready
var state_machine = $state_machine

func _ready() -> void:
	state_machine.init(self)

func _unhandled_input(input: InputEvent) -> void:
	state_machine.process_input(input)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)
