extends Sprite2D

var shake_intensity = 50.0
var original_position = Vector2()
var can_shake: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	original_position = position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if can_shake:
		can_shake = false
		_shake()

func _shake() -> void:
	position = original_position + Vector2(
		randf_range(-shake_intensity, shake_intensity),
		randf_range(-shake_intensity, shake_intensity)
	)
	await get_tree().create_timer(0.2).timeout
	can_shake = true
