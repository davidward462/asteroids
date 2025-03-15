extends Area2D

var speed = 700
var energy = 50

@onready var screen_size = get_viewport_rect().size

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Move bullet according to speed
func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta
	
	# Wrap position on screen bounds
	position.x = wrapf(position.x, 0, screen_size.x)
	position.y = wrapf(position.y, 0, screen_size.y)
	
	energy -= 1
	if energy < 0:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	# destroy asteroid that was hit.
	body.queue_free()
	# destroy self.
	queue_free()
