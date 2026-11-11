extends Enemy
class_name EnemyCross

# PROPERTIES

const CROSS_SCENE = preload("res://enemy/enemy_cross.tscn")
const CROSS_CONFIG = preload("res://resources/enemy_cross.tres")

var clone_rows: int = 3
var clone_cols: int = 2
var clone_spacing: float = 30.0


# FUNCTIONS

func _ready() -> void:
	if is_leader:
		await get_tree().process_frame
		initial_position = position
		_spawn_clones(initial_position)


func _move(_delta: float) -> void:
	# Move down
	velocity.y = enemy_config.speed
	
	# Move across
	# TODO: - L/R MOVEMENT


func _spawn_clones(_initial_position: Vector2) -> void:
	for row in range(clone_rows):
		for col in range(clone_cols):
			# Reserved for leader
			if row == 0 and col == 0:
				continue
			
			var spacing = Vector2(col * clone_spacing, -row * clone_spacing)
			initial_position = _initial_position + spacing
			
			var clone = CROSS_SCENE.instantiate() as EnemyCross
			clone.is_leader = false
			
			GameState.add_child_to_game_scene(clone, "Enemies")
			
			clone.enemy_config = enemy_config.duplicate()
			clone.setup()
			clone.position = initial_position
			
			clones.append(clone)
