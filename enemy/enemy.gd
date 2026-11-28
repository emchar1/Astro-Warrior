extends CharacterBody2D
class_name Enemy

# PROPERTIES

signal did_die

const EXPLOSION_SCENE = preload("res://scenes/explosion.tscn")

@onready var anim_sprite = $AnimatedSprite2D
@onready var hurtbox = $Hurtbox

var scene: PackedScene
var config: EnemyConfig

var enemy_config: EnemyConfig
var die_scale: Vector2 = Vector2.ONE
var is_dead: bool = false
var should_explode: bool = true
var player: Player

# Clone Properties
var clones: Array[Enemy] = []
var clones_count: int
var is_leader: bool = true
var initial_position: Vector2


# FUNCTIONS

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	_move(delta)
	
	move_and_slide()


func setup() -> void:
	anim_sprite.animation = EnemyConfig.get_anim_name(enemy_config.type)
	anim_sprite.play()


# HELPER FUNCTIONS

func _move(_delta: float) -> void:
	# You should override this function with specific enemy move implementation
	pass


func _die() -> void:
	if is_dead:
		return
	
	is_dead = true
	
	set_collision_layer_value(2, 0)
	hurtbox.set_deferred("monitoring", false)
	hide()
	did_die.emit()
	
	# MUST come after did_die signal for glider scoring.
	GameState.update_score(enemy_config.score)
	
	# Add explosion
	if should_explode:
		var explosion = EXPLOSION_SCENE.instantiate() as Explosion
		GameState.add_child_to_game_scene(explosion, "Extras")
		explosion.activate(position, die_scale)


# SIGNAL FUNCTIONS

func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullet"):
		if area is Bullet and not area.is_disabled:
			area.die()
			_die()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	await get_tree().create_timer(1.0).timeout
	
	if is_instance_valid(self):
		queue_free()
