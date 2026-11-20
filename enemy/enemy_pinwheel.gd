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

var move_distance: float # Travel distance before stopping to attack
var retreat_position: Vector2 # Retreat position
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
	position = _get_random_position(spawn_pos)
	initial_position = position
	
	# Set retreat position
	retreat_position = _get_random_position(spawn_pos)
	
	if player:
		dir_to_player = position.direction_to(player.position)


func _get_random_position(pos: SpawnPosition) -> Vector2:
	var rand_pos: Vector2
	var offset := 16.0
	
	match pos:
		SpawnPosition.LEFT:
			rand_pos = Vector2(
				-offset,
				randf_range(0.0, GameState.screen_size.y / 4)
			)
		SpawnPosition.TOP:
			rand_pos = Vector2(
				randf_range(0.0, GameState.screen_size.x),
				-offset
			)
		SpawnPosition.RIGHT:
			rand_pos = Vector2(
				GameState.screen_size.x + offset,
				randf_range(0.0, GameState.screen_size.y / 4)
			)
	
	return rand_pos


func _move(_delta: float) -> void:
	match move_type:
		MoveType.APPEAR:
			if not is_instance_valid(player):
				return
			
			velocity = dir_to_player * enemy_config.speed
			
			if position.distance_to(initial_position) >= move_distance:
				move_type = MoveType.ATTACK
		MoveType.ATTACK:
			velocity = Vector2.ZERO
			
			if did_fire_bullet:
				return
			
			for i in range(randi_range(2, 3)):
				if not is_instance_valid(player) or is_dead:
					return
				
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
			var dir_to_retreat := position.direction_to(retreat_position)
			velocity = dir_to_retreat * enemy_config.speed
