extends Enemy
class_name EnemyPinwheel

# PROPERTIES

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
		MoveType.RETREAT:
			pass
