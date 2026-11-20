extends Enemy
class_name EnemyPinwheel

# PROPERTIES

const ENEMY_BULLET = preload("res://scenes/enemy_bullet.tscn")

enum SpawnPosition { 
	LEFT, TOP, RIGHT
}

enum MoveType { 
	APPEAR, ATTACK, RETREAT
}

var spawn_pos: SpawnPosition
var move_type: MoveType = MoveType.APPEAR
var move_distance: float
var dir_to_player: Vector2
var did_fire_bullet: bool = false


# FUNCTIONS

func _init() -> void:
	scene = preload("res://enemy/enemy_pinwheel.tscn")
	config = preload("res://resources/enemy_pinwheel.tres")


func _ready() -> void:
	spawn_pos = SpawnPosition.values().pick_random()
	move_distance = randf_range(30.0, 80.0)


func setup() -> void:
	super.setup()
	
	# Override the enemy position that gets set in level_base.
	match spawn_pos:
		SpawnPosition.LEFT:
			position = Vector2(
				-8.0,
				randf_range(0.0, GameState.screen_size.y / 4)
			)
		SpawnPosition.TOP:
			position = Vector2(randf_range(0.0, GameState.screen_size.x), -8.0)
		SpawnPosition.RIGHT:
			position = Vector2(
				GameState.screen_size.x + 8.0,
				randf_range(0.0, GameState.screen_size.y / 4)
			)
	
	initial_position = position
	
	if player:
		dir_to_player = position.direction_to(player.position)


func _move(_delta: float) -> void:
	match move_type:
		MoveType.APPEAR:
			if player == null:
				return
			
			velocity = dir_to_player * enemy_config.speed
			
			if position.distance_to(initial_position) >= move_distance:
				move_type = MoveType.ATTACK
		MoveType.ATTACK:
			velocity = Vector2.ZERO
			
			if did_fire_bullet:
				return
			
			for i in range(2):
				var enemy_bullet = ENEMY_BULLET.instantiate() as EnemyBullet
				
				if enemy_bullet == null:
					print("error")
					break
				
				did_fire_bullet = true
				
				enemy_bullet.position = position
				enemy_bullet.destination = player.position
				
				GameState.add_child_to_game_scene(enemy_bullet, "Enemies")
				
				await get_tree().create_timer(1.0).timeout
				did_fire_bullet = false
			
			move_type = MoveType.RETREAT
		MoveType.RETREAT:
			pass
