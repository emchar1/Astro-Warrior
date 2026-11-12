extends Area2D
class_name Bullet

# PROPERTIES

enum Type {
	PLAIN, LASER
}

@export var speed: float = 500.0
@onready var sprite = $Sprite2D

var type: Type
var is_disabled: bool = false


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
		_disable_bullet()


func _disable_bullet() -> void:
	if is_disabled:
		return
	
	is_disabled = true
	speed = 0.0
	set_deferred("monitorable", false)
	hide()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	_disable_bullet()
	
	await get_tree().create_timer(1.0).timeout
	queue_free()
