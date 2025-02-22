extends CharacterBody2D

@onready var rotation_label: Label = $RotationLabel

const SPEED = 10.0
var dir = 0.0

func _ready() -> void:
	randomize()
	dir = randf_range(PI, -PI)
	
func _process(delta: float) -> void:
	rotation_label.text = str(dir)

func _physics_process(delta: float) -> void:
	
	move_and_collide(velocity * delta)
