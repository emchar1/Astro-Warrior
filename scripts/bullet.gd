extends Area2D
class_name Bullet

# PROPERTIES

enum Type {
	PLAIN, LASER
}

const EXPLOSION_SCENE = preload("res://scenes/explosion.tscn")

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
	
	tilemap.call_deferred("erase_cell", tile_coords)
	tilemap.add_child(explosion)
	explosion.type = Explosion.Type.TILE
	explosion.activate(tilemap.map_to_local(tile_coords))
	
	GameState.powerup_count += 1
	die()
