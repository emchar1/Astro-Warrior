extends LevelBase

# PROPERTIES

var spawn_form_a: bool = false
var spawn_form_ar: bool = false
var spawn_form_d: Array[bool] = [false, false, false, false]
var spawn_form_e: bool = false
var spawn_form_f: Array[bool] = [false, false]


# FUNCTIONS

func _spawn_enemies() -> void:
	# GLIDERS
	if position.y >= 100:
		if not spawn_form_a:
			spawn_form_a = true
			
			_spawn_enemy_helper(
				ENEMY_GLIDER_SCENE,
				ENEMY_GLIDER_CONFIG,
				EnemyConfig.Type.FORM_A,
				Vector2(GameState.screen_size.x / 2, -4.0)
			)
	
	if position.y >= 200:
		if not spawn_form_ar:
			spawn_form_ar = true
			
			_spawn_enemy_helper(
				ENEMY_GLIDER_SCENE,
				ENEMY_GLIDER_CONFIG,
				EnemyConfig.Type.FORM_AR,
				Vector2(GameState.screen_size.x / 2, -4.0)
			)
	
	# PINK BALLS
	if position.y >= 260:
		if not spawn_form_d[0]:
			spawn_form_d[0] = true
			
			_spawn_enemy_helper(
				ENEMY_PINK_BALL_SCENE,
				ENEMY_PINK_BALL_CONFIG,
				EnemyConfig.Type.FORM_D,
				Vector2(GameState.screen_size.x / 6, -8.0)
			)
	
	if position.y >= 320:
		if not spawn_form_d[1]:
			spawn_form_d[1] = true
			
			_spawn_enemy_helper(
				ENEMY_PINK_BALL_SCENE,
				ENEMY_PINK_BALL_CONFIG,
				EnemyConfig.Type.FORM_D,
				Vector2(2 * GameState.screen_size.x / 3, -8.0)
			)
	
	if position.y >= 380:
		if not spawn_form_d[2]:
			spawn_form_d[2] = true
			
			_spawn_enemy_helper(
				ENEMY_PINK_BALL_SCENE,
				ENEMY_PINK_BALL_CONFIG,
				EnemyConfig.Type.FORM_D,
				Vector2(GameState.screen_size.x / 3, -8.0)
			)
	
	if position.y >= 440:
		if not spawn_form_d[3]:
			spawn_form_d[3] = true
			
			_spawn_enemy_helper(
				ENEMY_PINK_BALL_SCENE,
				ENEMY_PINK_BALL_CONFIG,
				EnemyConfig.Type.FORM_D,
				Vector2(GameState.screen_size.x / 3, -8.0)
			)
	
	# CROSSES
	if position.y >= 500:
		if not spawn_form_e:
			spawn_form_e = true
			
			_spawn_enemy_helper(
				ENEMY_CROSS_SCENE,
				ENEMY_CROSS_CONFIG,
				EnemyConfig.Type.FORM_E,
				Vector2(GameState.screen_size.x / 2 - 15.0, -8.0)
			)
	
	if position.y >= 600:
		if not spawn_form_f[0]:
			spawn_form_f[0] = true
			
			_spawn_enemy_helper(
				ENEMY_CROSS_SCENE,
				ENEMY_CROSS_CONFIG,
				EnemyConfig.Type.FORM_F,
				Vector2(3 * GameState.screen_size.x / 4, -8.0)
			)
	
	if position.y >= 660:
		if not spawn_form_f[1]:
			spawn_form_f[1] = true
			
			_spawn_enemy_helper(
				ENEMY_CROSS_SCENE,
				ENEMY_CROSS_CONFIG,
				EnemyConfig.Type.FORM_F,
				Vector2(GameState.screen_size.x / 4, -8.0)
			)
