extends RigidBody2D

@onready var screen_size = get_viewport_rect().size

# TODO: remove after testing
@onready var velocity_label: Label = $velocity_label
@onready var rotation_label: Label = $rotation_label

const MAX_SPEED = 130.0
const MIN_SPEED = 20.0
var speed
var dir = 0.0

func _ready() -> void:
	#add_to_group("asteroids")
	print("asteroid ready")
	randomize()
	
	#speed = randf_range(MIN_SPEED, MAX_SPEED)
	speed = 0
	dir = randf_range(PI, -PI)
	
	# Make asteroid move at a constant velocity and not slow down.
	linear_damp = 0
	gravity_scale = 0
	linear_damp_mode = DampMode.DAMP_MODE_REPLACE
	linear_velocity = Vector2(speed, 0).rotated(dir)
	
func _process(delta: float) -> void:
	rotation_label.text = str(dir)
	velocity_label.text = str(linear_velocity)
	
	# Wrap position on screen bounds
	position.x = wrapf(position.x, 0, screen_size.x)
	position.y = wrapf(position.y, 0, screen_size.y)
	
# Destroy asteroid on collision
func _on_body_entered(body: Node) -> void:
	print("collided with asteroid")
	
	# temporary player death method.
	# TODO: set up actual player death method. 
	#body.queue_free()
	#queue_free()
