extends Node2D

@onready var player_scene = load("res://scenes/player.tscn")

func spawn_player(screen_size, start_pos) -> void:
	var player = player_scene.instantiate ()
	add_child(player)
	player.position = start_pos

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var screen_size = get_viewport_rect().end
	var player_start_pos = Vector2(screen_size.x/2, screen_size.y/2)
	
	# Spawn player in the center of the viewport.
	spawn_player(screen_size, player_start_pos)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
