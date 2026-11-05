extends Area2D

# PROPERTIES

@export var speed: float = 400.0
@onready var sprite = $Sprite2D


# FUNCTIONS


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y -= delta * speed
	
	if position.y <= -sprite.texture.height / 2:
		queue_free()
