extends Area2D

@export var speed: int = 1000
@export var max_range: float = 20000
var distance_traveled: float = 0.0

func _physics_process(delta: float) -> void:
	var distance: float = speed * delta
	var velocity: Vector2 = transform.x * speed * delta
	
	position += velocity
	distance_traveled += distance
	
	if distance_traveled > max_range:
		queue_free()

func _on_body_entered(body) -> void:
	body._damaged()
