extends Enemy
class_name EnemyPinkBall

# PROPERTIES

const PINK_BALL_SCENE = preload("res://enemy/enemy_pink_ball.tscn")
const PINK_BALL_CONFIG = preload("res://resources/enemy_pink_ball.tres")

var clones: Array[EnemyPinkBall] = []
var is_leader: bool = true
var clone_count: int = 3
var clone_spacing: float = 30.0
var initial_position: Vector2
var rand_speed: float = randf_range(0.0, 10.0)


# FUNCTIONS

func _ready() -> void:
	if is_leader:
		await get_tree().process_frame
		_spawn_clones()


func _move(_delta: float) -> void:
	var dir := -1.0 if initial_position.x > GameState.screen_size.x / 2 else 1.0
	
	velocity.x = dir * (enemy_config.speed / (randi_range(1, 3)) + rand_speed)
	velocity.y = enemy_config.speed + rand_speed


func _spawn_clones() -> void:
	for i in range(clone_count):
		var pink_ball = PINK_BALL_SCENE.instantiate() as EnemyPinkBall
		pink_ball.is_leader = false
		get_tree().current_scene.add_child(pink_ball)
		
		pink_ball.enemy_config = enemy_config.duplicate()
		pink_ball.position = position + Vector2((i + 1) * clone_spacing, 0.0)
		pink_ball.initial_position = pink_ball.position
		pink_ball.setup()
		
		clones.append(pink_ball)
