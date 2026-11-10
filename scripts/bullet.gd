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
	# FIXME: - Replace with proper setup
	type = Type.PLAIN


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y -= delta * speed


func die() -> void:
	if type == Type.PLAIN:
		speed = 0.0
		set_deferred("monitorable", false)
		hide()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	await get_tree().create_timer(1.0).timeout
	queue_free()
