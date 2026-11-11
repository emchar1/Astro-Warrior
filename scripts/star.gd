extends Node2D
class_name Star

# PROPERTIES

@export var star_color: Color
@export var twinkle_speed: float = 2

var starting_visibility: float = 0.0
var brighten: bool = false


# FUNCTIONS

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	modulate = star_color
	modulate.a = starting_visibility


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if modulate.a > 1:
		brighten = false
	elif modulate.a < 0:
		brighten = true
	
	var should_brighten: float = 1.0 if brighten else -1.0
	
	modulate.a += delta * twinkle_speed * should_brighten
