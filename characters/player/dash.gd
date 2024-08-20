extends Sprite2D

@onready var marker = $"../DashMarker"

var push_back_array = [0, 200, 400, 600]

var original_position = Vector2()
var can_update: bool = true
var current_index = 0 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	original_position = position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_visible_in_tree():
		if can_update:
			can_update = false
			_move_away()
	else:
		current_index = 0
		self.position = marker.position
		can_update = true

func _move_away() -> void:
	var direction = (position - get_parent().position).normalized()
	position += direction * push_back_array[current_index]
	current_index = (current_index + 1) % push_back_array.size()
	await get_tree().create_timer(0.1).timeout
	if current_index != push_back_array.size() - 1:
		can_update = true
