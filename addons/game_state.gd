extends Node

# PROPERTIES

var screen_size: Vector2


# FUNCTIONS

func _ready() -> void:
	screen_size = get_viewport().get_visible_rect().size
