extends Enemy
class_name EnemyGlider

# PROPERTIES

const GLIDER_SCENE = preload("res://enemy/enemy_glider.tscn")
const GLIDER_CONFIG = preload("res://resources/enemy_glider.tres")

var clones: Array[EnemyGlider] = []

var is_leader: bool = true
var did_nullify_cascade: bool = false

var elapsed_time: float = 0.0
var clone_count: int = 5
var clone_spacing: float = 0.2


# OVERRIDEN FUNCTIONS

func _ready() -> void:
	did_die.connect(_set_nullify_cascade)
	did_die.connect(_die_cascade)
	
	die_scale = Vector2(0.5, 0.5)
	
	if is_leader:
		await get_tree().process_frame
		_spawn_gliders()


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

func _spawn_gliders() -> void:
	var initial_position := Vector2(GameState.screen_size.x / 2, -4.0)
	
	# Set up gliders
	for i in range(clone_count):
		var clone = GLIDER_SCENE.instantiate() as EnemyGlider
		clone.is_leader = false
		get_tree().current_scene.get_node("GameScene/Enemies").add_child(clone)
		
		clone.set_physics_process(false)
		clone.enemy_config = enemy_config.duplicate()
		clone.position = initial_position
		
		clones.append(clone)
	
	# Animate in cascading fashion
	for i in range(clone_count):
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
