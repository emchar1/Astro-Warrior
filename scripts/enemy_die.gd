extends Node2D

# PROPERTIES

@onready var anim_sprite = $AnimatedSprite2D
@onready var audio_stream = $AudioStreamPlayer


# FUNCTIONS

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()


func activate(_scale: Vector2 = Vector2.ONE) -> void:
	scale = _scale
	show()
	anim_sprite.play()
	audio_stream.play()


func _on_animated_sprite_2d_animation_finished() -> void:
	hide()
	await get_tree().create_timer(1.0).timeout
	queue_free()
