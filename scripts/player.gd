extends CharacterBody2D

# for testing
@onready var velocity_label: Label = $VelocityLabel
@onready var rotation_label: Label = $RotationLabel
@onready var speed_label: Label = $speedLabel


@onready var screen_size = get_viewport_rect().size

var rotation_speed = 3.0
var v = Vector2.ZERO
var acceleration = 1.0
var drag = 0.5
var speed = 0.0
var reverse_vector = Vector2.ZERO
var drag_coef = 0.2
const MAX_SPEED = 5.0

func _do_rotation(delta: float) -> void:
	if Input.is_action_pressed("rotate_clockwise"):
		rotation += rotation_speed * delta
	
	if Input.is_action_pressed("rotate_counterclockwise"):
		rotation -= rotation_speed * delta
		
func _process(delta: float) -> void:
	velocity_label.text = str(velocity)
	rotation_label.text = str(rotation)
	speed_label.text = str(speed)

func _physics_process(delta: float) -> void:
	
	_do_rotation(delta)
	
	if Input.is_action_pressed("accelerate"):
		if speed < MAX_SPEED:
			speed += acceleration
		
		velocity += Vector2(speed, 0).rotated(rotation)
	else:
		#if speed > 0:
		#	
		if speed > 0:
			speed -= drag
			velocity += Vector2(-1 * speed, 0).rotated(rotation)
		

	#move_and_slide()
	move_and_collide(velocity * delta)
