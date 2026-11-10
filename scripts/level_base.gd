extends Node2D
class_name LevelBase

# PROPERTIES

const ENEMY_GLIDER_SCENE = preload("res://enemy/enemy_glider.tscn")
const ENEMY_GLIDER_CONFIG = preload("res://resources/enemy_glider.tres")

@export var scroll_speed: float = 200.0


# FUNCTIONS

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_scroll_level(delta)
	_spawn_enemies()


func _scroll_level(delta: float) -> void:
	position.y += delta * scroll_speed


func _spawn_enemies() -> void:
	# You should override this function with specific Level _spawn_enemies()
	# implementation.
	pass
