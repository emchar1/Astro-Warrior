extends Enemy
class_name EnemyGlider

# PROPERTIES

const SCENE = preload("res://enemy/enemy_glider.tscn")
const CONFIG = preload("res://resources/enemy_glider.tres")

var did_nullify_cascade: bool = false
var elapsed_time: float = 0.0
var clone_spacing: float = 0.2

# Form C Properties
var angle: float = 0.0
var form_c_phase: int = 0
var form_c_phase_time: float = 0.0
var form_c_start_position: Vector2 = Vector2.ZERO
var form_c_loop_center: Vector2 = Vector2.ZERO
var form_c_initialized: bool = false


# OVERRIDEN FUNCTIONS

func _init() -> void:
	scene = preload("res://enemy/enemy_glider.tscn")
	config = preload("res://resources/enemy_glider.tres")


func _ready() -> void:
	did_die.connect(_set_nullify_cascade)
	did_die.connect(_die_cascade)
	
	await get_tree().process_frame
	
	die_scale = Vector2(0.5, 0.5)
	clones_count = 5
	enemy_config.score = 10
	
	if is_leader:
		initial_position = position
		_spawn_gliders(initial_position)


func _move(delta: float) -> void:
	elapsed_time += delta
	
	match enemy_config.type:
		EnemyConfig.Type.FORM_A:
			var pivot := 30.0
			var speed_coefficient := 30.0
			
			velocity.y = enemy_config.speed
			
			if position.y > pivot:
				velocity.x = -speed_coefficient * pow(elapsed_time, 2)
		EnemyConfig.Type.FORM_AR:
			var pivot := 30.0
			var speed_coefficient := 30.0
			
			velocity.y = enemy_config.speed
			
			if position.y > pivot:
				velocity.x = speed_coefficient * pow(elapsed_time, 2)
		EnemyConfig.Type.FORM_B:
			var amplitude := 30.0
			var frequency := 2.0
			
			velocity.y = enemy_config.speed
			velocity.x = amplitude * frequency * cos(elapsed_time * frequency)
		EnemyConfig.Type.FORM_BR:
			var amplitude := 30.0
			var frequency := 2.0
			
			velocity.y = enemy_config.speed
			velocity.x = -amplitude * frequency * cos(elapsed_time * frequency)
		EnemyConfig.Type.FORM_C:
			_move_form_c(false, delta)
		EnemyConfig.Type.FORM_CR:
			_move_form_c(true, delta)


# HELPER FUNCTIONS

func _spawn_gliders(_initial_position: Vector2) -> void:
	# Set up gliders
	for i in range(clones_count):
		var clone = SCENE.instantiate() as EnemyGlider
		clone.is_leader = false
		clone.did_die.connect(_on_clone_died)
		
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


func _move_form_c(reverse: bool, delta: float):
	var dir := 1.0 if not reverse else -1.0
	
	var radius := 30.0
	var angular_speed := 3.0
	var entry_duration := 1.0
	var entry_distance := radius * angular_speed * entry_duration / 2.0
	
	if not form_c_initialized:
		var screen_mid_y := GameState.screen_size.y * 0.3
		
		form_c_initialized = true
		form_c_start_position = position
		form_c_loop_center = Vector2(
			form_c_start_position.x - dir * entry_distance,
			screen_mid_y + radius
		)
	
	match form_c_phase:
		0:
			# Parabolic entry to the bottom of the loop.
			var t := minf(form_c_phase_time / entry_duration, 1.0)
			var bottom_y := form_c_loop_center.y + radius
			
			form_c_phase_time += delta
			
			velocity.x = -dir * entry_distance / entry_duration
			velocity.y = (
				(bottom_y - form_c_start_position.y)
				* 2.0 * (1.0 - t) / entry_duration
			)
			
			if t >= 1.0:
				form_c_phase = 1
				angle = PI * 0.5
		1:
			# One circular revolution. The top reaches screen midpoint.
			velocity.x = -dir * radius * angular_speed * sin(angle)
			velocity.y = radius * angular_speed * cos(angle)
			angle += angular_speed * delta
			
			if angle >= PI * 0.2 + TAU: # 0.2 seems better.
				form_c_phase = 2
				form_c_phase_time = 0.0
		2:
			form_c_phase_time += delta
			
			velocity.x = -dir * 120.0
			velocity.y = maxf(0.0, 120.0 - 30.0 * pow(form_c_phase_time, 2))


# SIGNAL CALLBACK FUNCTIONS

func _set_nullify_cascade() -> void:
	if is_leader:
		return
	
	did_nullify_cascade = true


func _die_cascade() -> void:
	if not is_leader or did_nullify_cascade:
		return
	
	enemy_config.score = 100
	
	for clone in clones:
		if is_instance_valid(clone):
			clone.enemy_config.score = 0
			
			await get_tree().create_timer(0.08).timeout
			
			if is_instance_valid(clone):
				clone._die()


# Need to nullify cascade if clone dies first.
func _on_clone_died() -> void:
	did_nullify_cascade = true
