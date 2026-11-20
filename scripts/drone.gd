extends Area2D
class_name Drone

# PROPERTIES

@onready var target: Node2D = get_parent()

var speed: float
var is_unlocked: bool = false


# FUNCTIONS

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	speed = target.speed


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	pass
