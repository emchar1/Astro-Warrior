extends Area2D
class_name Bullet

# PROPERTIES

enum Type {
	PLAIN, LASER
}

@export var speed: float = 500.0
@onready var sprite = $Sprite2D

var type: Type


# FUNCTIONS


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	type = Type.PLAIN
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y -= delta * speed


func die() -> void:
	if type == Type.PLAIN:
		queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
