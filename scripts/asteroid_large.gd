extends CharacterBody2D

@onready var screen_size = get_viewport_rect().size

# TODO: remove after testing
@onready var rotation_label: Label = $RotationLabel
@onready var velocity_label: Label = $VelocityLabel

var speed = 10.0
var dir = 0.0

func _ready() -> void:
	randomize()
	dir = randf_range(PI, -PI)
	speed = randf_range(20.0, 130.0)
	velocity = Vector2(speed, 0).rotated(dir)
	
func _process(delta: float) -> void:
	rotation_label.text = str(dir)
	velocity_label.text = str(velocity)

func _physics_process(delta: float) -> void:
	
	move_and_collide(velocity * delta)
	
	# Wrap position on screen bounds
	position.x = wrapf(position.x, 0, screen_size.x)
	position.y = wrapf(position.y, 0, screen_size.y)
