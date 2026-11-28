extends Enemy
class_name EnemyIcicles

# PROPERTIES

var clone_spacing: float = 8.0
var is_paired: bool = true
var leader: EnemyIcicles


# FUNCTIONS

func _init() -> void:
	scene = preload("res://enemy/enemy_icicles.tscn")
	config = preload("res://resources/enemy_icicles.tres")


func _ready() -> void:
	did_die.connect(kill_enemy)
	clones_count = 1
	
	await get_tree().process_frame
	
	if is_leader:
		_spawn_clones()


func _move(_delta: float) -> void:
	velocity.y = enemy_config.speed


func _spawn_clones() -> void:
	for i in range(clones_count):
		var clone = scene.instantiate() as EnemyIcicles
		clone.leader = self
		clone.is_leader = false
		
		GameState.add_child_to_game_scene(clone, "Enemies")
		
		clone.enemy_config = enemy_config.duplicate()
		clone.position = position + Vector2((i + 1) * clone_spacing, 0.0)
		clone.initial_position = clone.position
		clone.setup()
		
		clones.append(clone)


func kill_enemy() -> void:
	var leader_temp: EnemyIcicles
	var clone_temp: EnemyIcicles
	var single_speed := 3.0
	
	if not is_paired:
		return
	
	should_explode = false
	enemy_config.score = 0
	
	if is_leader:
		clone_temp = clones[0] as EnemyIcicles
		clone_temp.is_paired = false
		clone_temp.enemy_config.speed *= single_speed
	else:
		leader_temp = leader
		leader_temp.is_paired = false
		leader_temp.enemy_config.speed *= single_speed
