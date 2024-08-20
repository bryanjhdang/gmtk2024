extends Node2D

var fish_scenes = [
	preload("res://characters/fish/tadpole.tscn"),
	preload("res://characters/fish/goldfish.tscn"),
	preload("res://characters/fish/anglerfish.tscn"),
	preload("res://characters/fish/pufferfish.tscn"),
	preload("res://characters/fish/shark.tscn")
]

@onready var player = get_tree().root.get_node("sandbox/Player")

# Number of fish to spawn
@export var max_fish_count: int = 10

# Time interval between spawns
@export var spawn_interval: float = 2.0

var current_fish_count: int = 0

func _ready() -> void:
	# Start the spawn timer
	var spawn_timer = Timer.new()
	spawn_timer.wait_time = spawn_interval
	spawn_timer.autostart = true
	spawn_timer.one_shot = false
	add_child(spawn_timer)
	spawn_timer.connect("timeout", Callable(self, "_on_spawn_timer_timeout"))

func _on_spawn_timer_timeout() -> void:
	# Check if we have reached the max fish count
	if current_fish_count >= max_fish_count:
		return

	# Randomly select a fish type to spawn
	var fish_scene = fish_scenes[randi() % fish_scenes.size()]
	var fish_instance = fish_scene.instantiate() as Fish


	# Set random position within boundaries
	var x = randf_range(50, 950)  # Adjust according to your game world
	var y = randf_range(50, 550)
	fish_instance.position = Vector2(x, y)
	

	
	# Add the fish to the scene
	get_parent().add_child(fish_instance)
	fish_instance.player = %Player
	fish_instance.game_manager = %GameManager

	current_fish_count += 1

	print("Spawned fish at position: ", fish_instance.position)
	print(fish_instance)
