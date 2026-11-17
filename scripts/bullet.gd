extends Area2D
class_name Bullet

# PROPERTIES

enum Type {
	MAIN, TRIPLE, LASER
}

const EXPLOSION_SCENE = preload("res://scenes/explosion.tscn")
const BULLET_MAIN_SFX = preload("res://assets/sounds/bullet0.ogg")
const BULLET_LASER_SFX = preload("res://assets/sounds/bullet1.ogg")

@export var speed: float = 500.0
@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D
@onready var bullet_audio_stream = $BulletAudioStreamPlayer
@onready var wall_audio_stream = $WallAudioStreamPlayer

var type: Type = Type.MAIN
var is_disabled: bool = false


# FUNCTIONS


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	match type:
		Type.MAIN:
			sprite.texture.region = Rect2(0.0, 22.0, 2.0, 11.0)
			collision.shape.size = Vector2(2.0, 11.0)
			sprite.scale.y = 1.0
			collision.scale.y = 1.0
			bullet_audio_stream.stream = BULLET_MAIN_SFX
		Type.TRIPLE:
			sprite.texture.region = Rect2(3.0, 22.0, 14.0, 11.0)
			collision.shape.size = Vector2(14.0, 11.0)
			sprite.scale.y = 1.0
			collision.scale.y = 1.0
			bullet_audio_stream.stream = BULLET_MAIN_SFX
		Type.LASER:
			sprite.texture.region = Rect2(18.0, 17.0, 8.0, 16.0)
			collision.shape.size = Vector2(8.0, 16.0)
			sprite.scale.y = 2.0
			collision.scale.y = 2.0
			bullet_audio_stream.stream = BULLET_LASER_SFX
	
	bullet_audio_stream.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y -= delta * speed


func die() -> void:
	if type != Type.LASER:
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


func _on_body_shape_entered(
	body_rid: RID,
	body: Node2D,
	_body_shape_index: int,
	_local_shape_index: int
) -> void:
	if not body is TileMapLayer:
		return
	
	var tilemap := body as TileMapLayer
	var tile_coords := tilemap.get_coords_for_body_rid(body_rid)
	var explosion = EXPLOSION_SCENE.instantiate() as Explosion
	
	if tilemap.name == "Destructibles":
		tilemap.call_deferred("erase_cell", tile_coords)
		tilemap.add_child(explosion)
		explosion.type = Explosion.Type.TILE
		explosion.activate(tilemap.map_to_local(tile_coords))
		GameState.increment_powerup_count()
	
	if tilemap.name == "Walls" and type != Type.LASER:
		wall_audio_stream.play()
	
	die()
