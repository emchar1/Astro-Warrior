extends Enemy
class_name EnemyBlueBall

# PROPERTIES

enum MoveType {
	DESCEND, CIRCLE, LEAVE
}

enum Direction {
	CLOCKWISE, COUNTERCLOCKWISE
}

var move_type: MoveType = MoveType.DESCEND
var rotation_dir: Direction
var clone_spacing: float = 30.0
var elapsed_time: float
var index: int = 0

# Circle Movement Properties
var circle_radius: float = 20.0
var angular_speed: float = 3.0 * PI
var circle_duration: float = 1.5 * TAU / angular_speed
var circle_speed := circle_radius * angular_speed
var exit_speed := 1.0
var dir: float


# FUNCTIONS

func _init() -> void:
	scene = preload("res://enemy/enemy_blue_ball.tscn")
	config = preload("res://resources/enemy_blue_ball.tres")


func _ready() -> void:
	await get_tree().process_frame
	
	clones_count = 3
	
	match enemy_config.type:
		EnemyConfig.Type.FORM_F:
			rotation_dir = Direction.COUNTERCLOCKWISE
		EnemyConfig.Type.FORM_FR:
			rotation_dir = Direction.CLOCKWISE
		EnemyConfig.Type.FORM_F2:
			rotation_dir = Direction.COUNTERCLOCKWISE
			
			if index == 2 or index == 3:
				rotation_dir = Direction.CLOCKWISE
		EnemyConfig.Type.FORM_F2R:
			rotation_dir = Direction.CLOCKWISE
			
			if index == 2 or index == 3:
				rotation_dir = Direction.COUNTERCLOCKWISE
	
	dir = 1.0 if rotation_dir == Direction.CLOCKWISE else -1.0
	
	if is_leader:
		_spawn_clones()


func _move(delta: float) -> void:
	match move_type:
		MoveType.DESCEND:
			elapsed_time = 0.0
			velocity.y = enemy_config.speed
			
			if position.y >= GameState.screen_size.y * 3/5:
				move_type = MoveType.CIRCLE
		MoveType.CIRCLE:
			elapsed_time += delta
			
			var elapsed_speed := elapsed_time * angular_speed
			
			velocity.x = -circle_speed * sin(elapsed_speed) * dir
			velocity.y = circle_speed * cos(elapsed_speed)
			
			if elapsed_time > circle_duration:
				move_type = MoveType.LEAVE
		MoveType.LEAVE:
			velocity.x = circle_speed * sin(2 * PI / 3) * exit_speed * dir
			velocity.y = circle_speed * cos(2 * PI / 3) * exit_speed


func _spawn_clones() -> void:
	for i in range(clones_count):
		var clone = scene.instantiate() as EnemyBlueBall
		clone.is_leader = false
		
		GameState.add_child_to_game_scene(clone, "Enemies")
		
		clone.enemy_config = enemy_config.duplicate()
		clone.position = position + Vector2((i + 1) * clone_spacing, 0.0)
		clone.initial_position = clone.position
		clone.index = i + 1
		clone.setup()
		
		clones.append(clone)
