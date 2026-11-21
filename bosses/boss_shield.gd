extends Area2D
class_name BossShield

# PROPERTIES

signal did_die

const EXPLOSION_SCENE = preload("res://scenes/explosion.tscn")

@export var hp: float = 1.0

@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D
@onready var audio_stream = $AudioStreamPlayer

var can_target: bool = true
var is_dead: bool = false


# FUNCTIONS

func _damage(amount: float) -> void:
	if is_dead:
		return
	
	hp -= amount
	audio_stream.play()
	
	if hp <= 0:
		_die()
		return


func _die() -> void:
	if is_dead:
		return
	
	is_dead = true
	can_target = false
	
	set_collision_layer_value(2, 0)
	set_deferred("monitoring", false)
	hide()
	did_die.emit()
	
	# Add explosion
	var explosion = EXPLOSION_SCENE.instantiate() as Explosion
	GameState.add_child_to_game_scene(explosion, "Extras")
	explosion.activate(collision.global_position)


# SIGNAL CALLBACK FUNCTIONS

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullet"):
		if not can_target:
			return
		
		if area is Bullet and not area.is_disabled:
			area.die()
			_damage(area.damage)


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	await get_tree().create_timer(1.0).timeout
	
	if is_instance_valid(self):
		queue_free()
