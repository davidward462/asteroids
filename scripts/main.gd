extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	# Close window if quit key is pressed.s
	if Input.is_action_pressed("quit"):
		get_tree().quit()
