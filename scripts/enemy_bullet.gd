extends Area2D
class_name EnemyBullet

# PROPERTIES

@export var speed: float = 100.0

var destination: Vector2
var direction: Vector2


# FUNCTIONS

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	direction = position.direction_to(destination)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	# Proceeds past destination
	position += direction * speed * delta
	
	# Stops at destination
	#position = position.move_toward(destination, speed * delta)


# SIGNAL CALLBACK FUNCTIONS

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
