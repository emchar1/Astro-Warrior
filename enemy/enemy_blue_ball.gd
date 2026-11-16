extends Enemy
class_name EnemyBlueBall

# PROPERTIES

enum MoveType {
	DESCEND, CIRCLE, EXIT
}

enum Direction {
	CLOCKWISE, COUNTERCLOCKWISE
}

const SCENE = preload("res://enemy/enemy_blue_ball.tscn")
const CONFIG = preload("res://resources/enemy_blue_ball.tres")

var move_type: MoveType = MoveType.DESCEND
var rotation_dir: Direction = Direction.CLOCKWISE
var clone_spacing: float = 30.0
var elapsed_time: float

# Circle Movement Properties
var circle_radius: float = 20.0
var angular_speed: float = 3.0 * PI
var circle_duration: float = 2.35 * TAU / angular_speed
var dir: float = 1.0 if rotation_dir == Direction.CLOCKWISE else -1.0


# FUNCTIONS

func _ready() -> void:
	clones_count = 3
	
	if is_leader:
		await get_tree().process_frame
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
			
			var circle_speed := circle_radius * angular_speed
			var elapsed_speed := elapsed_time * angular_speed
			
			velocity.x = -circle_speed * sin(elapsed_speed) * dir
			velocity.y = circle_speed * cos(elapsed_speed)
			
			if elapsed_time > circle_duration:
				move_type = MoveType.EXIT
		MoveType.EXIT:
			var circle_speed := circle_radius * angular_speed
			var exit_speed := 2.0
			
			velocity.x = -circle_speed * sin(2 * PI / 3) * exit_speed * dir
			velocity.y = circle_speed * cos(2 * PI / 3) * exit_speed


func _spawn_clones() -> void:
	for i in range(clones_count):
		var clone = SCENE.instantiate() as EnemyBlueBall
		clone.is_leader = false
		
		GameState.add_child_to_game_scene(clone, "Enemies")
		
		clone.enemy_config = enemy_config.duplicate()
		clone.position = position + Vector2((i + 1) * clone_spacing, 0.0)
		clone.initial_position = clone.position
		clone.setup()
		
		clones.append(clone)
