extends Enemy
class_name EnemyPinkBall

# PROPERTIES

const PINK_BALL_SCENE = preload("res://enemy/enemy_pink_ball.tscn")
const PINK_BALL_CONFIG = preload("res://resources/enemy_pink_ball.tres")

var clone_spacing: float = 30.0
var rand_speed: float = randf_range(0.0, 10.0)


# FUNCTIONS

func _ready() -> void:
	clones_count = 3
	
	if is_leader:
		await get_tree().process_frame
		_spawn_clones()


func _move(_delta: float) -> void:
	var right_side: bool = initial_position.x > GameState.screen_size.x / 2
	var dir := -1.0 if right_side else 1.0
	
	velocity.x = dir * (enemy_config.speed / randf_range(1, 3) + rand_speed)
	velocity.y = enemy_config.speed + rand_speed


func _spawn_clones() -> void:
	for i in range(clones_count):
		var clone = PINK_BALL_SCENE.instantiate() as EnemyPinkBall
		clone.is_leader = false
		
		GameState.add_child_to_game_scene(clone, "Enemies")
		
		clone.enemy_config = enemy_config.duplicate()
		clone.position = position + Vector2((i + 1) * clone_spacing, 0.0)
		clone.initial_position = clone.position
		clone.setup()
		
		clones.append(clone)
