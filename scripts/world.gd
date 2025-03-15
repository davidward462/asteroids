extends Node2D

@onready var player_scene = load("res://scenes/player.tscn")
@onready var asteroid_scene = load("res://scenes/asteroid.tscn")
@onready var screen_size = get_viewport_rect().end

var asteroid_count = 2

func spawn_player(start_pos) -> void:
	var player = player_scene.instantiate ()
	add_child(player)
	player.position = start_pos
	
func gen_asteroid_coords() -> Vector2:
	var buffer = 120
	var screen_x = int(screen_size.x)
	var screen_y = int(screen_size.y)
	
	var x = (randi() % (screen_x)-buffer ) + buffer
	var y = (randi() % (screen_y)-buffer ) + buffer
	var coords = Vector2(x, y)
	return coords
	
func spawn_asteroid() -> void:
	var pos = gen_asteroid_coords()
	var asteroid = asteroid_scene.instantiate()
	add_child(asteroid)
	asteroid.position = pos
	
func spawn_asteroids(count) -> void:
	for i in range(count):
		spawn_asteroid()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	var player_start_pos = Vector2(screen_size.x/2, screen_size.y/2)
	
	# Spawn player in the center of the viewport.
	spawn_player(player_start_pos)
	
	# Spawn asteroids
	spawn_asteroids(asteroid_count)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
