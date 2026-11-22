extends CharacterBody2D
class_name Boss

# PROPERTIES

signal did_die

enum MoveType { 
	ENTER, TAUNT, ATTACK1, ATTACK2, DIE
}

const EXPLOSION_SCENE = preload("res://scenes/explosion.tscn")

@onready var sprite = $Sprite2D
@onready var hurtboxes = $Hurtboxes

var scene: PackedScene
var config: BossConfig

var boss_config: BossConfig
var player: Player
var move_type: MoveType = MoveType.ENTER
var is_dead: bool = false


# FUNCTIONS

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	_move(delta)
	
	move_and_slide()


func setup() -> void:
	pass


# HELPER FUNCTIONS

func _move(_delta: float) -> void:
	# You should override this function with specific enemy move implementation
	match move_type:
		MoveType.ENTER:
			var texture = sprite.texture
			
			if texture == null:
				return
			
			velocity.y = 32.0
			
			if position.y >= texture.region.size.y / 2:
				move_type = MoveType.TAUNT
		MoveType.TAUNT:
			velocity = Vector2.ZERO
			
			await get_tree().create_timer(2.0).timeout
			
			if is_instance_valid(self):
				move_type = MoveType.ATTACK1
		MoveType.DIE:
			velocity = Vector2.ZERO


func _die() -> void:
	if is_dead:
		return
	
	is_dead = true
	
	set_collision_layer_value(2, 0)
	move_type = MoveType.DIE
	did_die.emit()
	
	GameState.update_score(boss_config.score)
	
	# Remove all enemy bullets on death
	var extras_node = GameState.get_game_scene_node("Extras")
	if extras_node:
		for node in extras_node.get_children():
			if node is EnemyBullet:
				node.queue_free()
	
	# Boss go out, not in a whimper, but a BANG!
	var tween = create_tween()
	tween.tween_property(
		sprite,
		"modulate",
		Color.BLUE,
		2.0
	)
	
	for i in range(20):
		var explosion = EXPLOSION_SCENE.instantiate() as Explosion
		GameState.add_child_to_game_scene(explosion, "Extras")
		explosion.activate(
			position + Vector2(
				randf_range(-32, 32),
				randf_range(-32, 32)
			)
		)
		
		await get_tree().create_timer(0.1).timeout
		
		if not is_instance_valid(self):
			print("invalid")
			return
	
	if is_instance_valid(self):
		hide()


# SIGNAL CALLBACK FUNCTIONS

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	await get_tree().create_timer(3.0).timeout
	
	if is_instance_valid(self):
		queue_free()
