extends CharacterBody2D
class_name Enemy

# PROPERTIES

signal did_die

const EXPLOSION_SCENE = preload("res://scenes/explosion.tscn")

@onready var anim_sprite = $AnimatedSprite2D
@onready var hurtbox = $Hurtbox

var enemy_config: EnemyConfig
var die_scale: Vector2 = Vector2.ONE


# FUNCTIONS

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	_move(delta)
	
	move_and_slide()


func setup() -> void:
	anim_sprite.animation = enemy_config.get_anim_name()
	anim_sprite.play()


# HELPER FUNCTIONS

func _move(_delta: float) -> void:
	# You should override this function with specific enemy move implementation
	pass


func _die() -> void:
	set_collision_layer_value(2, 0)
	hurtbox.set_deferred("monitoring", false)
	hide()
	did_die.emit()
	
	var explosion = EXPLOSION_SCENE.instantiate() as Explosion
	get_tree().current_scene.get_node("GameScene/Extras").add_child(explosion)
	explosion.activate(position, die_scale)


# SIGNAL FUNCTIONS

func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullet"):
		if area is Bullet:
			area.die()
			_die()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	await get_tree().create_timer(1.0).timeout
	queue_free()
