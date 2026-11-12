extends Enemy
class_name EnemyCross

# PROPERTIES

const CROSS_SCENE = preload("res://enemy/enemy_cross.tscn")
const CROSS_CONFIG = preload("res://resources/enemy_cross.tres")

var clone_rows: int = 10
var clone_cols: int = 2
var clone_spacing: float = 30.0
var horiz_dir: float = 1.0


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
	var horiz_speed := 3.0 * enemy_config.speed
	var horiz_limit := clone_spacing / 2
	
	if position.x >= initial_position.x + horiz_limit:
		horiz_dir = -1.0
	elif position.x <= initial_position.x - horiz_limit:
		horiz_dir = 1.0
	
	velocity.x = horiz_speed * horiz_dir
	


func _spawn_clones(_initial_position: Vector2) -> void:
	for row in range(clone_rows):
		for col in range(clone_cols):
			# Reserved for leader
			if row == 0 and col == 0:
				continue
			
			var spacing = Vector2(col * clone_spacing, -row * clone_spacing)
			var offset = Vector2(clone_spacing / 2 * row, 0.0)
			
			var clone = CROSS_SCENE.instantiate() as EnemyCross
			clone.is_leader = false
			
			GameState.add_child_to_game_scene(clone, "Enemies")
			
			clone.enemy_config = enemy_config.duplicate()
			clone.setup()
			clone.horiz_dir = -1.0 if row % 2 == 0 else 1.0
			clone.initial_position = _initial_position + spacing
			clone.position = clone.initial_position + offset
			
			clones.append(clone)
