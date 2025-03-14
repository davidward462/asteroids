extends CharacterBody2D

# For shooting
@export var Bullet : PackedScene
var max_ammo = 5
var ammo = max_ammo
var regen = 0
var max_regen = 20

# TODO: remove later
@onready var velocity_label: Label = $VelocityLabel
@onready var rotation_label: Label = $RotationLabel
@onready var speed_label: Label = $speedLabel

@onready var screen_size = get_viewport_rect().size

var rotation_speed = 4.5

var force = 4.0
var drag_vector = Vector2.ZERO
var drag_coef = 0.008

#const MAX_SPEED = 5.0
const MAX_SPEED = Vector2(5.0, 5.0)

func _do_rotation(delta: float) -> void:
	if Input.is_action_pressed("rotate_clockwise"):
		rotation += rotation_speed * delta
	
	if Input.is_action_pressed("rotate_counterclockwise"):
		rotation -= rotation_speed * delta
		
func shoot():
	ammo -= 1
	regen = 0
	var b = Bullet.instantiate()
	get_tree().get_root().add_child(b)
	b.transform = $GunPosition.global_transform
		
func _process(delta: float) -> void:
	# what does this do? Why is it not in _physics_process()?
	var v_x = velocity.x
	var v_y = velocity.y
	
	# TODO: remove these when no longer needed.
	#velocity_label.text = "(%.1f, %.1f)" % [v_x, v_y]
	#rotation_label.text = "%.2f" % regen
	#velocity_label.text = "%d" % ammo
	
	if ammo < 5:
		# if we have less than max ammo
		if regen < max_regen:
			# if the regeneration value is under the max, add to it.
			regen += delta * 60
			
	if regen >= max_regen:
		# if we reach the max regeneration value, add ammo and reset.
		ammo += 1
		regen = 0
	
	# Shoot
	if Input.is_action_just_pressed("shoot"):
		if ammo > 0:
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

	# TODO: figure out collision.
	#move_and_slide()
	var collision = move_and_collide(velocity * delta)
	
	#if collision:
		#print("collided with player")
		#self.queue_free()
		
	# Wrap position on screen bounds
	position.x = wrapf(position.x, 0, screen_size.x)
	position.y = wrapf(position.y, 0, screen_size.y)
