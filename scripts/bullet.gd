extends Area2D
class_name Bullet

# PROPERTIES

const EXPLOSION_SCENE = preload("res://scenes/explosion.tscn")
const BULLET_MAIN_SFX = preload("res://assets/sounds/bullet0.ogg")
const BULLET_LASER_SFX = preload("res://assets/sounds/bullet1.ogg")

@export var speed: float = 500.0
@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D
@onready var bullet_audio_stream = $BulletAudioStreamPlayer
@onready var wall_audio_stream = $WallAudioStreamPlayer

var powerup_manager: PowerupManager
var is_disabled: bool = false
var should_silence: bool = false


# FUNCTIONS

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	match powerup_manager.bullet_type:
		Powerup.Type.LASER:
			sprite.texture.region = Rect2(18.0, 17.0, 8.0, 16.0)
			collision.shape.size = Vector2(8.0, 16.0)
			sprite.scale.y = 2.0
			collision.scale.y = 2.0
			bullet_audio_stream.stream = BULLET_LASER_SFX
		Powerup.Type.TRIPLE:
			sprite.texture.region = Rect2(3.0, 22.0, 14.0, 11.0)
			collision.shape.size = Vector2(14.0, 11.0)
			sprite.scale.y = 1.0
			collision.scale.y = 1.0
			bullet_audio_stream.stream = BULLET_MAIN_SFX
		_:
			sprite.texture.region = Rect2(0.0, 22.0, 2.0, 11.0)
			collision.shape.size = Vector2(2.0, 11.0)
			sprite.scale.y = 1.0
			collision.scale.y = 1.0
			bullet_audio_stream.stream = BULLET_MAIN_SFX
	
	if not should_silence:
		bullet_audio_stream.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position.y -= delta * speed


func die() -> void:
	if powerup_manager.bullet_type != Powerup.Type.LASER:
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
	
	if is_instance_valid(self):
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
	
	if tilemap.name == "Destructibles":
		var explosion = EXPLOSION_SCENE.instantiate() as Explosion
		
		tilemap.call_deferred("erase_cell", tile_coords)
		tilemap.add_child(explosion)
		
		explosion.type = Explosion.Type.TILE
		explosion.activate(tilemap.map_to_local(tile_coords))
		
		powerup_manager.increment_powerup_count()
		_add_powerup_label(tilemap, tile_coords)
		GameState.update_score(200)
	
	if powerup_manager.bullet_type != Powerup.Type.LASER \
	and tilemap.name == "Walls":
		if not should_silence:
			wall_audio_stream.play()
	
	die()


func _add_powerup_label(tilemap: TileMapLayer, tile_coords: Vector2i):
	var powerup_font := load("res://assets/fonts/PressStart2P-Regular.ttf")
	var powerup_mod := int(GameState.powerup_count % PowerupManager.THRESHOLD)
	var powerup_label := Label.new()
	var tween := create_tween()
	var _speed := 0.8
	
	powerup_label.z_index = 5
	powerup_label.add_theme_font_override("font", powerup_font)
	powerup_label.add_theme_constant_override("outline_size", 3)
	
	if powerup_mod == 0:
		_speed = 1.0
		powerup_label.text = "POWER UP!"
		powerup_label.add_theme_font_size_override("font_size", 4)
		powerup_label.add_theme_color_override(
			"font_outline_color",
			Color.MAGENTA
		)
	else:
		powerup_label.text = str(powerup_mod, "/", PowerupManager.THRESHOLD)
		powerup_label.add_theme_font_size_override("font_size", 3)
		powerup_label.add_theme_color_override(
			"font_outline_color",
			Color.MAGENTA.darkened(0.4)
		)
	
	tilemap.add_child(powerup_label)
	
	powerup_label.position = tilemap.map_to_local(tile_coords)
		
	tween.tween_property(powerup_label, "modulate:a", 0.0, _speed)
	tween.parallel().tween_property(
		powerup_label,
		"position:y",
		powerup_label.position.y - 10.0,
		_speed
	)
