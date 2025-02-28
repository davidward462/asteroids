extends CharacterBody2D

# For shooting
@export var Bullet : PackedScene

# for testing
@onready var velocity_label: Label = $VelocityLabel
@onready var rotation_label: Label = $RotationLabel
@onready var speed_label: Label = $speedLabel

@onready var screen_size = get_viewport_rect().size

var rotation_speed = 3.0

var force = 3.0
var drag_vector = Vector2.ZERO
var drag_coef = 0.01

const MAX_SPEED = 5.0

func _do_rotation(delta: float) -> void:
	if Input.is_action_pressed("rotate_clockwise"):
		rotation += rotation_speed * delta
	
	if Input.is_action_pressed("rotate_counterclockwise"):
		rotation -= rotation_speed * delta
		
func shoot():
	var b = Bullet.instantiate()
	owner.add_child(b)
	b.transform = $GunPosition.global_transform
		
func _process(delta: float) -> void:
	velocity_label.text = str(velocity)
	rotation_label.text = str(rotation)
	
	# Shoot
	if Input.is_action_just_pressed("shoot"):
		shoot()

func _physics_process(delta: float) -> void:
	pass # Replace with function body.
	_do_rotation(delta)
	
	if Input.is_action_pressed("accelerate"):
		# when there is thrust, add force to velocity vector.
		velocity += Vector2(force, 0).rotated(rotation)
	else:
		# When there is no thrust, add the drag vector against the velocity.
		# TODO: do somethign better than drag coefficient. Maybe a small threshold.
		
		drag_vector = -1 * velocity * drag_coef
		velocity += drag_vector

	#move_and_slide()
	var collision = move_and_collide(velocity * delta)
	
	#if collision:
		#print("collided with player")
		#self.queue_free()
		
	# Wrap position on screen bounds
	position.x = wrapf(position.x, 0, screen_size.x)
	position.y = wrapf(position.y, 0, screen_size.y)
