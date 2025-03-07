extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var screen_size = get_viewport_rect().end
	var player_start_pos = Vector2(screen_size.x/2, screen_size.y/2)
	var scene = load("res://scenes/player.tscn")
	var player = scene.instantiate ()
	add_child(player)
	player.position = player_start_pos


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
