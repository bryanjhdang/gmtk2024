extends Node2D

#var fish_scenes = {
	#"easy": [preload("res://characters/fish/tadpole.tscn"), preload("res://characters/fish/goldfish.tscn")],
	#"medium": [preload("res://characters/fish/pufferfish.tscn"), preload("res://characters/fish/anglerfish.tscn")],
	#"hard": [preload("res://characters/fish/shark.tscn"), preload("res://characters/fish/shark.tscn")]
#}

var fish_scenes = [
	preload("res://characters/fish/tadpole.tscn"),
	preload("res://characters/fish/goldfish.tscn"),
	preload("res://characters/fish/anglerfish.tscn"),
	preload("res://characters/fish/pufferfish.tscn"),
	preload("res://characters/fish/shark.tscn")
]

@onready var player = %Player
@onready var camera_size  = get_viewport_rect().size 
@onready var spawn_timer = Timer.new()


var VIEWPORT_LEFT
var VIEWPORT_RIGHT 
var VIEWPORT_TOP 
var VIEWPORT_BOTTOM 

var SPAWN_DISTANCE = 500

@export var max_fish_count: int = 50
var spawn_interval: int = 1

var current_fish_count: int = 0
var time_elapsed: float = 0.0

var x: float
var y: float


var spawn_probabilities = {
	"easy": 0.7,
	"medium": 0.2,
	"hard": 0.1
}

func _process(delta):
	VIEWPORT_LEFT = player.position.x + camera_size[0]
	VIEWPORT_RIGHT = player.position.x - camera_size[0]
	VIEWPORT_TOP = player.position.y - camera_size[1]
	VIEWPORT_BOTTOM = player.position.y + camera_size[1]

func _ready() -> void:
	spawn_timer.wait_time = spawn_interval
	spawn_timer.autostart = true
	add_child(spawn_timer)
	spawn_timer.connect("timeout", Callable(self, "_on_spawn_timer_timeout"))

	# Start probability timer
	#var probability_timer = Timer.new()
	#probability_timer.wait_time = 1.0
	#probability_timer.autostart = true
	#add_child(probability_timer)
	#probability_timer.connect("timeout", Callable(self, "_update_spawn_probabilities"))
	
	
func _choose_location_to_spawn() -> Vector2:
	var edge = randi() % 4
	
	match edge:
		0:  # Left edge
			x = VIEWPORT_LEFT + SPAWN_DISTANCE 
			y = randf_range(VIEWPORT_TOP, VIEWPORT_BOTTOM)
		1:  # Right edge
			x = VIEWPORT_RIGHT - SPAWN_DISTANCE  
			y = randf_range(VIEWPORT_TOP, VIEWPORT_BOTTOM)
		2:  # Top edge
			x = randf_range(VIEWPORT_LEFT, VIEWPORT_RIGHT)
			y = VIEWPORT_TOP - SPAWN_DISTANCE  
		3:  # Bottom edge
			x = randf_range(VIEWPORT_LEFT, VIEWPORT_RIGHT)
			y = VIEWPORT_BOTTOM + SPAWN_DISTANCE 

	return Vector2(x, y)


func _on_spawn_timer_timeout() -> void:
	# Check if we have reached the max fish count
	if current_fish_count >= max_fish_count:
		return

	# Randomly select a fish type to spawn
	var fish_instance = _choose_fish_to_spawn()

	fish_instance.position = _choose_location_to_spawn()
	

	
	get_parent().add_child(fish_instance)
	fish_instance.player = %Player
	fish_instance.game_manager = %GameManager
	
	current_fish_count += 1
	spawn_timer.wait_time = randi_range(1, 3)
	print(spawn_timer.wait_time)

	print("Spawned fish at position: ", fish_instance.position)

	print(fish_instance.value)
	
func _choose_fish_to_spawn() -> Fish:
	#var cum_prob = 0.0
	var fish_scene = fish_scenes[randi() % fish_scenes.size()]
	return fish_scene.instantiate() as Fish

	#for difficulty in spawn_probabilities.keys():
		#cum_prob += spawn_probabilities[difficulty]

		#if randf() <= cum_prob:
			#var fish_list = fish_scenes[difficulty]
			#return fish_list[randi() % fish_scenes[difficulty].size()].instantiate() as Fish
			
	#return null # should never reach
#
### TODO Fish spawn probabilities is still kinda wonky
#func _update_spawn_probabilities() -> void:
	#time_elapsed += 1.0  
	#if time_elapsed < 45:  
		#spawn_probabilities["easy"] -= 0.05
		#spawn_probabilities["medium"] += 0.025
		#spawn_probabilities["hard"] += 0.025
	#elif time_elapsed < 60: 
		#spawn_probabilities["hard"] += 0.05
		#
## probabilities sum to 1
	#var total_prob = 0.0
	#for prob in spawn_probabilities.values():
		#total_prob += prob
#
	#for key in spawn_probabilities.keys():
		#spawn_probabilities[key] /= total_prob
		#
		
func decrease_fish_count() -> void:
	current_fish_count -= 1
