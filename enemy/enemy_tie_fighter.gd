extends Enemy
class_name EnemyTieFighter

# PROPERTIES

enum MoveType {
	DESCEND, RETREAT, ATTACK
}

const SCENE = preload("res://enemy/enemy_tie_fighter.tscn")
const CONFIG = preload("res://resources/enemy_tie_fighter.tres")

var move_type: MoveType = MoveType.DESCEND
var clone_spacing: float = 0.5
var lr_margin: float = 30.0
var attack_speed: float = 2.0


# FUNCTIONS

func _init() -> void:
	scene = preload("res://enemy/enemy_tie_fighter.tscn")
	config = preload("res://resources/enemy_tie_fighter.tres")


func _ready() -> void:
	await get_tree().process_frame
	
	clones_count = 3
	
	if enemy_config.type == EnemyConfig.Type.FORM_G:
		position.x = lr_margin
	elif enemy_config.type == EnemyConfig.Type.FORM_GR:
		position.x = GameState.screen_size.x - lr_margin
	
	if is_leader:
		_spawn_clones()


func _move(_delta: float) -> void:
	match move_type:
		MoveType.DESCEND:
			velocity.x = 0.0
			velocity.y = enemy_config.speed
			
			if position.y > GameState.screen_size.y - 16.0:
				move_type = MoveType.RETREAT
		MoveType.RETREAT:
			if player == null:
				return
			
			var dir := global_position.direction_to(player.global_position)
			var player_reached := false
			
			velocity.x = enemy_config.speed * signf(dir.x)
			velocity.y = -enemy_config.speed
			
			if enemy_config.type == EnemyConfig.Type.FORM_G:
				player_reached = dir.x <= 0.0
			elif enemy_config.type == EnemyConfig.Type.FORM_GR:
				player_reached = dir.x >= 0.0
			
			if position.y < 16.0 or player_reached:
				velocity = Vector2.ZERO
				anim_sprite.speed_scale = 2.0
				
				await get_tree().create_timer(0.2).timeout
				move_type = MoveType.ATTACK
		MoveType.ATTACK:
			velocity.x = 0.0
			velocity.y = enemy_config.speed * attack_speed


func _spawn_clones() -> void:
	for i in range(clones_count):
		var clone = SCENE.instantiate() as EnemyTieFighter
		clone.is_leader = false
		clone.player = player
		
		GameState.add_child_to_game_scene(clone, "Enemies")
		
		clone.set_physics_process(false)
		clone.enemy_config = enemy_config.duplicate()
		clone.position = position
		
		clones.append(clone)
	
	for i in range(clones_count):
		await get_tree().create_timer(clone_spacing).timeout
		
		var clone = clones[i]
		clone.set_physics_process(true)
		clone.setup()
