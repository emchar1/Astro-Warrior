extends Enemy
class_name EnemyGlider

# PROPERTIES

const GLIDER_SCENE = preload("res://enemy/enemy_glider.tscn")
const GLIDER_CONFIG = preload("res://resources/enemy_glider.tres")

var did_nullify_cascade: bool = false
var elapsed_time: float = 0.0
var clone_spacing: float = 0.2


# OVERRIDEN FUNCTIONS

func _ready() -> void:
	did_die.connect(_set_nullify_cascade)
	did_die.connect(_die_cascade)
	
	die_scale = Vector2(0.5, 0.5)
	clones_count = 5
	
	if is_leader:
		await get_tree().process_frame
		initial_position = position
		_spawn_gliders(initial_position)


func _move(delta: float) -> void:
	var pivot: float = 30.0
	var speed_coefficient: float = 30.0
	
	elapsed_time += delta
	
	match enemy_config.type:
		EnemyConfig.Type.FORM_A:
			velocity.y = enemy_config.speed
			
			if position.y > pivot:
				velocity.x = -speed_coefficient * pow(elapsed_time, 2)
		EnemyConfig.Type.FORM_AR:
			velocity.y = enemy_config.speed
			
			if position.y > pivot:
				velocity.x = speed_coefficient * pow(elapsed_time, 2)


# HELPER FUNCTIONS

func _spawn_gliders(_initial_position: Vector2) -> void:
	# Set up gliders
	for i in range(clones_count):
		var clone = GLIDER_SCENE.instantiate() as EnemyGlider
		clone.is_leader = false
		
		GameState.add_child_to_game_scene(clone, "Enemies")
		
		clone.set_physics_process(false)
		clone.enemy_config = enemy_config.duplicate()
		clone.position = _initial_position
		
		clones.append(clone)
	
	# Animate in cascading fashion
	for i in range(clones_count):
		await get_tree().create_timer(clone_spacing).timeout
		
		var clone = clones[i]
		clone.set_physics_process(true)
		clone.setup()


# SIGNAL CALLBACK FUNCTIONS

func _set_nullify_cascade() -> void:
	if is_leader:
		return
	
	did_nullify_cascade = true


func _die_cascade() -> void:
	if not is_leader:
		return
	
	for clone in clones:
		if clone.did_nullify_cascade:
			return
	
	for clone in clones:
		await get_tree().create_timer(0.08).timeout
		clone._die()
