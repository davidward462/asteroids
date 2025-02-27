extends CharacterBody2D

@onready var screen_size = get_viewport_rect().size

# TODO: remove after testing
@onready var rotation_label: Label = $RotationLabel
@onready var velocity_label: Label = $VelocityLabel

const MAX_SPEED = 130.0
const MIN_SPEED = 20.0
var speed
var dir = 0.0

func _ready() -> void:
	randomize()
	dir = randf_range(PI, -PI)
	speed = randf_range(MIN_SPEED, MAX_SPEED)
	velocity = Vector2(speed, 0).rotated(dir)
	
func _process(delta: float) -> void:
	rotation_label.text = str(dir)
	velocity_label.text = str(velocity)

func _physics_process(delta: float) -> void:
	
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		# TODO: sometimes asteroid does not free itself on collision.
		self.queue_free()
	
	# Wrap position on screen bounds
	position.x = wrapf(position.x, 0, screen_size.x)
	position.y = wrapf(position.y, 0, screen_size.y)
