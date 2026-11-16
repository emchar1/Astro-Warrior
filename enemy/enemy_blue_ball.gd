extends Enemy
class_name EnemyBlueBall

# PROPERTIES

const SCENE = preload("res://enemy/enemy_blue_ball.tscn")
const CONFIG = preload("res://resources/enemy_blue_ball.tres")

var clone_spacing: float = 30.0


# FUNCTIONS

func _ready() -> void:
	clones_count = 3
	
	if is_leader:
		await get_tree().process_frame
		_spawn_clones()


func _move(_delta: float) -> void:
	velocity.y = enemy_config.speed


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
