extends Node2D
class_name Explosion

# PROPERTIES

enum Type {
	ACTOR, TILE
}

@onready var anim_sprite = $AnimatedSprite2D
@onready var audio_stream = $AudioStreamPlayer

var type: Type = Type.ACTOR


# FUNCTIONS

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()


func activate(_position: Vector2, _scale: Vector2 = Vector2.ONE) -> void:
	position = _position
	scale = _scale
	
	match type:
		Type.ACTOR:
			anim_sprite.animation = "actor"
			audio_stream.stream = load("res://assets/sounds/enemy_kill.ogg")
		Type.TILE:
			anim_sprite.animation = "tile"
			audio_stream.stream = load("res://assets/sounds/unused.ogg")
	
	show()
	
	anim_sprite.play()
	audio_stream.play()


func _on_animated_sprite_2d_animation_finished() -> void:
	hide()
	await get_tree().create_timer(1.0).timeout
	queue_free()
