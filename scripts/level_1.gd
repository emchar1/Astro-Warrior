extends LevelBase

# PROPERTIES

var spawn_form_a: bool = false
var spawn_form_ar: bool = false
var spawn_form_b: bool = false
var spawn_form_br: bool = false
var spawn_form_c: Array[bool] = [false, false]
var spawn_form_cr: bool = false
var spawn_form_d: Array[bool] = [false, false, false, false, false]
var spawn_form_d2: Array[bool] = [
	false, false, false,
	false, false, false, false
]
var spawn_form_e: bool = false
var spawn_form_e2: Array[bool] = [false, false]
var spawn_form_e3: Array[bool] = [false, false]
var spawn_form_f: Array[bool] = [false, false, false, false]
var spawn_form_g: Array[bool] = [false, false]
var spawn_form_gr: Array[bool] = [false, false]

# FUNCTIONS

func _spawn_enemies() -> void:
	# GLIDERS
	if checkpoint < 100 and position.y >= 100:
		if not spawn_form_ar:
			spawn_form_ar = true
			
			_spawn_enemy_helper(
				EnemyGlider.SCENE,
				EnemyGlider.CONFIG,
				EnemyConfig.Type.FORM_AR,
				Vector2(GameState.screen_size.x / 2, -4.0)
			)
	
	if checkpoint < 200 and position.y >= 200:
		if not spawn_form_a:
			spawn_form_a = true
			
			_spawn_enemy_helper(
				EnemyGlider.SCENE,
				EnemyGlider.CONFIG,
				EnemyConfig.Type.FORM_A,
				Vector2(GameState.screen_size.x / 2, -4.0)
			)
	
	# PINK BALLS
	if checkpoint < 260 and position.y >= 260:
		if not spawn_form_d[0]:
			spawn_form_d[0] = true
			
			_spawn_enemy_helper(
				EnemyPinkBall.SCENE,
				EnemyPinkBall.CONFIG,
				EnemyConfig.Type.FORM_D,
				Vector2(GameState.screen_size.x / 6, -8.0)
			)
	
	if checkpoint < 320 and position.y >= 320:
		if not spawn_form_d[1]:
			spawn_form_d[1] = true
			
			_spawn_enemy_helper(
				EnemyPinkBall.SCENE,
				EnemyPinkBall.CONFIG,
				EnemyConfig.Type.FORM_D,
				Vector2(2 * GameState.screen_size.x / 3, -8.0)
			)
	
	if checkpoint < 380 and position.y >= 380:
		if not spawn_form_d[2]:
			spawn_form_d[2] = true
			
			_spawn_enemy_helper(
				EnemyPinkBall.SCENE,
				EnemyPinkBall.CONFIG,
				EnemyConfig.Type.FORM_D,
				Vector2(GameState.screen_size.x / 3, -8.0)
			)
	
	if checkpoint < 440 and position.y >= 440:
		if not spawn_form_d[3]:
			spawn_form_d[3] = true
			
			_spawn_enemy_helper(
				EnemyPinkBall.SCENE,
				EnemyPinkBall.CONFIG,
				EnemyConfig.Type.FORM_D,
				Vector2(GameState.screen_size.x / 3, -8.0)
			)
	
	# CROSSES
	if checkpoint < 500 and position.y >= 500:
		if not spawn_form_e:
			spawn_form_e = true
			
			_spawn_enemy_helper(
				EnemyCross.SCENE,
				EnemyCross.CONFIG,
				EnemyConfig.Type.FORM_E,
				Vector2(GameState.screen_size.x / 2 - 15.0, -8.0)
			)
	
	if checkpoint < 600 and position.y >= 600:
		if not spawn_form_e2[0]:
			spawn_form_e2[0] = true
			
			_spawn_enemy_helper(
				EnemyCross.SCENE,
				EnemyCross.CONFIG,
				EnemyConfig.Type.FORM_E2,
				Vector2(3 * GameState.screen_size.x / 4, -8.0)
			)
	
	if checkpoint < 660 and position.y >= 660:
		if not spawn_form_e2[1]:
			spawn_form_e2[1] = true
			
			_spawn_enemy_helper(
				EnemyCross.SCENE,
				EnemyCross.CONFIG,
				EnemyConfig.Type.FORM_E2,
				Vector2(GameState.screen_size.x / 4, -8.0)
			)
	
	# S-GLIDER
	if checkpoint < 800 and position.y >= 800:
		if not spawn_form_b:
			
			spawn_form_b = true
			
			_spawn_enemy_helper(
				EnemyGlider.SCENE,
				EnemyGlider.CONFIG,
				EnemyConfig.Type.FORM_B,
				Vector2(GameState.screen_size.x / 2, -4.0)
			)
	
	# PINK BALLS
	if checkpoint < 850 and position.y >= 850:
		if not spawn_form_d[4]:
			spawn_form_d[4] = true
			
			_spawn_enemy_helper(
				EnemyPinkBall.SCENE,
				EnemyPinkBall.CONFIG,
				EnemyConfig.Type.FORM_D,
				Vector2(GameState.screen_size.x / 3, -8.0)
			)
	
	if checkpoint < 900 and position.y >= 900:
		if not spawn_form_d2[0]:
			spawn_form_d2[0] = true
			
			_spawn_enemy_helper(
				EnemyPinkBall.SCENE,
				EnemyPinkBall.CONFIG,
				EnemyConfig.Type.FORM_D2,
				Vector2(GameState.screen_size.x / 4, -8.0)
			)
	
	if checkpoint < 930 and position.y >= 930:
		if not spawn_form_d2[1]:
			spawn_form_d2[1] = true
			
			_spawn_enemy_helper(
				EnemyPinkBall.SCENE,
				EnemyPinkBall.CONFIG,
				EnemyConfig.Type.FORM_D2,
				Vector2(GameState.screen_size.x / 4, -8.0)
			)
	
	if checkpoint < 960 and position.y >= 960:
		if not spawn_form_d2[2]:
			spawn_form_d2[2] = true
			
			_spawn_enemy_helper(
				EnemyPinkBall.SCENE,
				EnemyPinkBall.CONFIG,
				EnemyConfig.Type.FORM_D2,
				Vector2(GameState.screen_size.x / 4, -8.0)
			)
	
	# GLIDER
	if checkpoint < 1000 and position.y >= 1000:
		if not spawn_form_c[0]:
			spawn_form_c[0] = true
			
			_spawn_enemy_helper(
				EnemyGlider.SCENE,
				EnemyGlider.CONFIG,
				EnemyConfig.Type.FORM_C,
				Vector2(GameState.screen_size.x / 2, -4.0)
			)
	
	# BLUE BALLS
	if checkpoint < 1050 and position.y >= 1050:
		if not spawn_form_f[0]:
			spawn_form_f[0] = true
			
			_spawn_enemy_helper(
				EnemyBlueBall.SCENE,
				EnemyBlueBall.CONFIG,
				EnemyConfig.Type.FORM_F,
				Vector2(GameState.screen_size.x / 3.1, -8.0)
			)
	
	if checkpoint < 1100 and position.y >= 1100:
		if not spawn_form_f[1]:
			spawn_form_f[1] = true
			
			_spawn_enemy_helper(
				EnemyBlueBall.SCENE,
				EnemyBlueBall.CONFIG,
				EnemyConfig.Type.FORM_FR,
				Vector2(GameState.screen_size.x / 3.1, -8.0)
			)
	
	if checkpoint < 1150 and position.y >= 1150:
		if not spawn_form_f[2]:
			spawn_form_f[2] = true
			
			_spawn_enemy_helper(
				EnemyBlueBall.SCENE,
				EnemyBlueBall.CONFIG,
				EnemyConfig.Type.FORM_F2,
				Vector2(GameState.screen_size.x / 3.1, -8.0)
			)
	
	if checkpoint < 1200 and position.y >= 1200:
		if not spawn_form_f[3]:
			spawn_form_f[3] = true
			
			_spawn_enemy_helper(
				EnemyBlueBall.SCENE,
				EnemyBlueBall.CONFIG,
				EnemyConfig.Type.FORM_F2R,
				Vector2(GameState.screen_size.x / 3.1, -8.0)
			)
	
	# - CHECKPOINT - 1200
	
	# GLIDER
	if checkpoint < 1250 and position.y >= 1250:
		if not spawn_form_br:
			spawn_form_br = true
			
			_spawn_enemy_helper(
				EnemyGlider.SCENE,
				EnemyGlider.CONFIG,
				EnemyConfig.Type.FORM_BR,
				Vector2(GameState.screen_size.x / 2, -4.0)
			)
	
	# PINK BALLS
	if checkpoint < 1310 and position.y >= 1310:
		if not spawn_form_d2[3]:
			spawn_form_d2[3] = true
			
			_spawn_enemy_helper(
				EnemyPinkBall.SCENE,
				EnemyPinkBall.CONFIG,
				EnemyConfig.Type.FORM_D2,
				Vector2(GameState.screen_size.x / 4, -8.0)
			)
	
	if checkpoint < 1340 and position.y >= 1340:
		if not spawn_form_d2[4]:
			spawn_form_d2[4] = true
			
			_spawn_enemy_helper(
				EnemyPinkBall.SCENE,
				EnemyPinkBall.CONFIG,
				EnemyConfig.Type.FORM_D2,
				Vector2(GameState.screen_size.x / 4, -8.0)
			)
	
	if checkpoint < 1370 and position.y >= 1370:
		if not spawn_form_d2[5]:
			spawn_form_d2[5] = true
			
			_spawn_enemy_helper(
				EnemyPinkBall.SCENE,
				EnemyPinkBall.CONFIG,
				EnemyConfig.Type.FORM_D2,
				Vector2(GameState.screen_size.x / 4, -8.0)
			)
	
	if checkpoint < 1400 and position.y >= 1400:
		if not spawn_form_d2[6]:
			spawn_form_d2[6] = true
			
			_spawn_enemy_helper(
				EnemyPinkBall.SCENE,
				EnemyPinkBall.CONFIG,
				EnemyConfig.Type.FORM_D2,
				Vector2(GameState.screen_size.x / 4, -8.0)
			)
	
	# GLIDER
	if checkpoint < 1460 and position.y >= 1460:
		if not spawn_form_c[1]:
			spawn_form_c[1] = true
			
			_spawn_enemy_helper(
				EnemyGlider.SCENE,
				EnemyGlider.CONFIG,
				EnemyConfig.Type.FORM_C,
				Vector2(GameState.screen_size.x / 2, -4.0)
			)
	
	# TIE FIGHTERS
	if checkpoint < 1500 and position.y >= 1500:
		if not spawn_form_g[0]:
			spawn_form_g[0] = true
			
			_spawn_enemy_helper(
				EnemyTieFighter.SCENE,
				EnemyTieFighter.CONFIG,
				EnemyConfig.Type.FORM_G,
				Vector2(0.0, -8.0)
			)
	
	if checkpoint < 1550 and position.y >= 1550:
		if not spawn_form_gr[0]:
			spawn_form_gr[0] = true
			
			_spawn_enemy_helper(
				EnemyTieFighter.SCENE,
				EnemyTieFighter.CONFIG,
				EnemyConfig.Type.FORM_GR,
				Vector2(0.0, -8.0)
			)
	
	if checkpoint < 1600 and position.y >= 1600:
		if not spawn_form_g[1]:
			spawn_form_g[1] = true
			
			_spawn_enemy_helper(
				EnemyTieFighter.SCENE,
				EnemyTieFighter.CONFIG,
				EnemyConfig.Type.FORM_G,
				Vector2(0.0, -8.0)
			)
	
	if checkpoint < 1650 and position.y >= 1650:
		if not spawn_form_gr[1]:
			spawn_form_gr[1] = true
			
			_spawn_enemy_helper(
				EnemyTieFighter.SCENE,
				EnemyTieFighter.CONFIG,
				EnemyConfig.Type.FORM_GR,
				Vector2(0.0, -8.0)
			)
	
	# CROSSES
	if checkpoint < 1700 and position.y >= 1700:
		if not spawn_form_e3[0]:
			spawn_form_e3[0] = true
			
			_spawn_enemy_helper(
				EnemyCross.SCENE,
				EnemyCross.CONFIG,
				EnemyConfig.Type.FORM_E3,
				Vector2(GameState.screen_size.x / 4, -8.0)
			)
	
	if checkpoint < 1800 and position.y >= 1800:
		if not spawn_form_e3[1]:
			spawn_form_e3[1] = true
			
			_spawn_enemy_helper(
				EnemyCross.SCENE,
				EnemyCross.CONFIG,
				EnemyConfig.Type.FORM_E3,
				Vector2(3 * GameState.screen_size.x / 4, -8.0)
			)
