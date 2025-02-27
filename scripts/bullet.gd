extends Area2D

var speed = 700

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Move bullet according to speed
func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta

func _on_body_entered(body: Node2D) -> void:
	queue_free()
