extends LevelBase

# PROPERTIES

var spawn_form_a: bool = false
var spawn_form_ar: bool = false
var spawn_form_b: Array[bool] = [false, false]
var spawn_form_br: bool = false
var spawn_form_c: Array[bool] = [false, false, false]
var spawn_form_cr: Array[bool] = [false, false]
var spawn_form_d: Array[bool] = [
	false, false, false, false, false,
	false, false, false, false,
	false, false, false
]
var spawn_form_d2: Array[bool] = [
	false, false, false,
	false, false, false, false,
	false, false, false, false, false, false,
	false, false
]
var spawn_form_d8: bool = false
var spawn_form_d8r: bool = false
var spawn_form_e: bool = false
var spawn_form_e2: Array[bool] = [false, false]
var spawn_form_e3: Array[bool] = [false, false]
var spawn_form_f: Array[bool] = [
	false, false, false, false,
	false, false, false, false
]
var spawn_form_g: Array[bool] = [false, false, false, false]
var spawn_form_gr: Array[bool] = [false, false, false, false]
var spawn_form_h: Array[bool] = [false, false, false, false, false, false]


# FUNCTIONS

func _spawn_enemies() -> void:
	# GLIDERS
	if checkpoint < 100 and position.y >= 100 and not spawn_form_ar:
		spawn_form_ar = true
		
		_spawn_enemy_helper(
			EnemyConfig.Type.FORM_AR,
			Vector2(GameState.screen_size.x / 2, -8.0)
		)
	
	if checkpoint < 200 and position.y >= 200 and not spawn_form_a:
		spawn_form_a = true
		
		_spawn_enemy_helper(
			EnemyConfig.Type.FORM_A,
			Vector2(GameState.screen_size.x / 2, -8.0)
		)
	
	# PINK BALLS
	if checkpoint < 260 and position.y >= 260 and not spawn_form_d[0]:
		spawn_form_d[0] = true
		
		_spawn_enemy_helper(
			EnemyConfig.Type.FORM_D,
			Vector2(GameState.screen_size.x / 6, -8.0)
		)
	
	if checkpoint < 320 and position.y >= 320 and not spawn_form_d[1]:
		spawn_form_d[1] = true
		
		_spawn_enemy_helper(
			EnemyConfig.Type.FORM_D,
			Vector2(2 * GameState.screen_size.x / 3, -8.0)
		)
	
	if checkpoint < 380 and position.y >= 380 and not spawn_form_d[2]:
		spawn_form_d[2] = true
		
		_spawn_enemy_helper(
			EnemyConfig.Type.FORM_D,
			Vector2(GameState.screen_size.x / 3, -8.0)
		)
	
	if checkpoint < 440 and position.y >= 440 and not spawn_form_d[3]:
		spawn_form_d[3] = true
		
		_spawn_enemy_helper(
			EnemyConfig.Type.FORM_D,
			Vector2(GameState.screen_size.x / 3, -8.0)
		)
	
	# CROSSES
	if checkpoint < 500 and position.y >= 500 and not spawn_form_e:
		spawn_form_e = true
		
		_spawn_enemy_helper(
			EnemyConfig.Type.FORM_E,
			Vector2(GameState.screen_size.x / 2 - 15.0, -8.0)
		)
	
	if checkpoint < 600 and position.y >= 600 and not spawn_form_e2[0]:
		spawn_form_e2[0] = true
		
		_spawn_enemy_helper(
			EnemyConfig.Type.FORM_E2,
			Vector2(3 * GameState.screen_size.x / 4, -8.0)
		)
	
	if checkpoint < 660 and position.y >= 660 and not spawn_form_e2[1]:
		spawn_form_e2[1] = true
		
		_spawn_enemy_helper(
			EnemyConfig.Type.FORM_E2,
			Vector2(GameState.screen_size.x / 4, -8.0)
		)
	
	# S-GLIDER
	if checkpoint < 800 and position.y >= 800 and not spawn_form_b[0]:
		spawn_form_b[0] = true
		
		_spawn_enemy_helper(
			EnemyConfig.Type.FORM_B,
			Vector2(GameState.screen_size.x / 2, -8.0)
		)
	
	# PINK BALLS
	if checkpoint < 850 and position.y >= 850 and not spawn_form_d[4]:
		spawn_form_d[4] = true
		
		_spawn_enemy_helper(
			EnemyConfig.Type.FORM_D,
			Vector2(GameState.screen_size.x / 3, -8.0)
		)
	
	if checkpoint < 900 and position.y >= 900 and not spawn_form_d2[0]:
		spawn_form_d2[0] = true
		
		_spawn_enemy_helper(
			EnemyConfig.Type.FORM_D2,
			Vector2(GameState.screen_size.x / 4, -8.0)
		)
	
	if checkpoint < 930 and position.y >= 930 and not spawn_form_d2[1]:
		spawn_form_d2[1] = true
		
		_spawn_enemy_helper(
			EnemyConfig.Type.FORM_D2,
			Vector2(GameState.screen_size.x / 4, -8.0)
		)
	
	if checkpoint < 960 and position.y >= 960 and not spawn_form_d2[2]:
		spawn_form_d2[2] = true
		
		_spawn_enemy_helper(
			EnemyConfig.Type.FORM_D2,
			Vector2(GameState.screen_size.x / 4, -8.0)
		)
	
	# C-GLIDER
	if checkpoint < 1000 and position.y >= 1000 and not spawn_form_c[0]:
		spawn_form_c[0] = true
		
		_spawn_enemy_helper(
			EnemyConfig.Type.FORM_C,
			Vector2(GameState.screen_size.x / 2, -8.0)
		)
	
	# BLUE BALLS
	if checkpoint < 1050 and position.y >= 1050 and not spawn_form_f[0]:
		spawn_form_f[0] = true
		
		_spawn_enemy_helper(
			EnemyConfig.Type.FORM_F,
			Vector2(GameState.screen_size.x / 3.1, -8.0)
		)
	
	if checkpoint < 1100 and position.y >= 1100 and not spawn_form_f[1]:
		spawn_form_f[1] = true
		
		_spawn_enemy_helper(
			EnemyConfig.Type.FORM_FR,
			Vector2(GameState.screen_size.x / 3.1, -8.0)
		)
	
	if checkpoint < 1150 and position.y >= 1150 and not spawn_form_f[2]:
		spawn_form_f[2] = true
		
		_spawn_enemy_helper(
			EnemyConfig.Type.FORM_F2,
			Vector2(GameState.screen_size.x / 3.1, -8.0)
		)
	
	if checkpoint < 1200 and position.y >= 1200 and not spawn_form_f[3]:
		spawn_form_f[3] = true
		
		_spawn_enemy_helper(
			EnemyConfig.Type.FORM_F2R,
			Vector2(GameState.screen_size.x / 3.1, -8.0)
		)
	
	# - CHECKPOINT - 1200
	
	# S-GLIDER
	if checkpoint < 1250 and position.y >= 1250 and not spawn_form_br:
		spawn_form_br = true
		
		_spawn_enemy_helper(
			EnemyConfig.Type.FORM_BR,
			Vector2(GameState.screen_size.x / 2, -8.0)
		)
	
	# PINK BALLS
	if checkpoint < 1310 and position.y >= 1310 and not spawn_form_d2[3]:
		spawn_form_d2[3] = true
		
		_spawn_enemy_helper(
			EnemyConfig.Type.FORM_D2,
			Vector2(GameState.screen_size.x / 4, -8.0)
		)
	
	if checkpoint < 1340 and position.y >= 1340 and not spawn_form_d2[4]:
		spawn_form_d2[4] = true
		
		_spawn_enemy_helper(
			EnemyConfig.Type.FORM_D2,
			Vector2(GameState.screen_size.x / 4, -8.0)
		)
	
	if checkpoint < 1370 and position.y >= 1370 and not spawn_form_d2[5]:
		spawn_form_d2[5] = true
		
		_spawn_enemy_helper(
			EnemyConfig.Type.FORM_D2,
			Vector2(GameState.screen_size.x / 4, -8.0)
		)
	
	if checkpoint < 1400 and position.y >= 1400 and not spawn_form_d2[6]:
		spawn_form_d2[6] = true
		
		_spawn_enemy_helper(
			EnemyConfig.Type.FORM_D2,
			Vector2(GameState.screen_size.x / 4, -8.0)
		)
	
	# C-GLIDER
	if checkpoint < 1460 and position.y >= 1460 and not spawn_form_c[1]:
		spawn_form_c[1] = true
		
		_spawn_enemy_helper(
			EnemyConfig.Type.FORM_C,
			Vector2(GameState.screen_size.x / 2, -8.0)
		)
	
	# TIE FIGHTERS
	if checkpoint < 1500 and position.y >= 1500 and not spawn_form_g[0]:
		spawn_form_g[0] = true
		
		_spawn_enemy_helper(
			EnemyConfig.Type.FORM_G,
			Vector2(0.0, -8.0)
		)
	
	if checkpoint < 1550 and position.y >= 1550 and not spawn_form_gr[0]:
		spawn_form_gr[0] = true
		
		_spawn_enemy_helper(
			EnemyConfig.Type.FORM_GR,
			Vector2(0.0, -8.0)
		)
	
	if checkpoint < 1600 and position.y >= 1600 and not spawn_form_g[1]:
		spawn_form_g[1] = true
		
		_spawn_enemy_helper(
			EnemyConfig.Type.FORM_G,
			Vector2(0.0, -8.0)
		)
	
	if checkpoint < 1650 and position.y >= 1650 and not spawn_form_gr[1]:
		spawn_form_gr[1] = true
		
		_spawn_enemy_helper(
			EnemyConfig.Type.FORM_GR,
			Vector2(0.0, -8.0)
		)
	
	# CROSSES
	if checkpoint < 1700 and position.y >= 1700 and not spawn_form_e3[0]:
		spawn_form_e3[0] = true
		
		_spawn_enemy_helper(
			EnemyConfig.Type.FORM_E3,
			Vector2(GameState.screen_size.x / 4, -8.0)
		)
	
	if checkpoint < 1800 and position.y >= 1800 and not spawn_form_e3[1]:
		spawn_form_e3[1] = true
		
		_spawn_enemy_helper(
			EnemyConfig.Type.FORM_E3,
			Vector2(3 * GameState.screen_size.x / 4, -8.0)
		)
	
	# PINK BALLS
	if checkpoint < 1900 and position.y >= 1900 and not spawn_form_d8:
		spawn_form_d8 = true
		
		_spawn_enemy_helper(
			EnemyConfig.Type.FORM_D8,
			Vector2(0.0, -8.0)
		)
	
	if checkpoint < 1960 and position.y >= 1960 and not spawn_form_d8r:
		spawn_form_d8r = true
		
		_spawn_enemy_helper(
			EnemyConfig.Type.FORM_D8R,
			Vector2(GameState.screen_size.x, -8.0)
		)
	
	if checkpoint < 2020 and position.y >= 2020 and not spawn_form_d2[7]:
		spawn_form_d2[7] = true
		
		_spawn_enemy_helper(
			EnemyConfig.Type.FORM_D2,
			Vector2(GameState.screen_size.x / 4, -8.0)
		)
	
	if checkpoint < 2040 and position.y >= 2040 and not spawn_form_d2[8]:
		spawn_form_d2[8] = true
		
		_spawn_enemy_helper(
			EnemyConfig.Type.FORM_D2,
			Vector2(GameState.screen_size.x / 4, -8.0)
		)
	
	if checkpoint < 2060 and position.y >= 2060 and not spawn_form_d2[9]:
		spawn_form_d2[9] = true
		
		_spawn_enemy_helper(
			EnemyConfig.Type.FORM_D2,
			Vector2(GameState.screen_size.x / 4, -8.0)
		)
	
	if checkpoint < 2100 and position.y >= 2100 and not spawn_form_d2[10]:
		spawn_form_d2[10] = true
		
		_spawn_enemy_helper(
			EnemyConfig.Type.FORM_D2,
			Vector2(GameState.screen_size.x / 4, -8.0)
		)
	
	if checkpoint < 2120 and position.y >= 2120 and not spawn_form_d2[11]:
		spawn_form_d2[11] = true
		
		_spawn_enemy_helper(
			EnemyConfig.Type.FORM_D2,
			Vector2(GameState.screen_size.x / 4, -8.0)
		)
	
	if checkpoint < 2140 and position.y >= 2140 and not spawn_form_d2[12]:
		spawn_form_d2[12] = true
		
		_spawn_enemy_helper(
			EnemyConfig.Type.FORM_D2,
			Vector2(GameState.screen_size.x / 4, -8.0)
		)
	
	# BLUE BALLS
	if checkpoint < 2180 and position.y >= 2180 and not spawn_form_f[4]:
		spawn_form_f[4] = true
		
		_spawn_enemy_helper(
			EnemyConfig.Type.FORM_F,
			Vector2(GameState.screen_size.x / 3.1, -8.0)
		)
	
	if checkpoint < 2230 and position.y >= 2230 and not spawn_form_f[5]:
		spawn_form_f[5] = true
		
		_spawn_enemy_helper(
			EnemyConfig.Type.FORM_FR,
			Vector2(GameState.screen_size.x / 3.1, -8.0)
		)
	
	if checkpoint < 2280 and position.y >= 2280 and not spawn_form_f[6]:
		spawn_form_f[6] = true
		
		_spawn_enemy_helper(
			EnemyConfig.Type.FORM_F2,
			Vector2(GameState.screen_size.x / 3.1, -8.0)
		)
	
	if checkpoint < 2330 and position.y >= 2330 and not spawn_form_f[7]:
		spawn_form_f[7] = true
		
		_spawn_enemy_helper(
			EnemyConfig.Type.FORM_F2R,
			Vector2(GameState.screen_size.x / 3.1, -8.0)
		)
	
	# S-GLIDER
	if checkpoint < 2400 and position.y >= 2400 and not spawn_form_b[1]:
		spawn_form_b[1] = true
		
		_spawn_enemy_helper(
			EnemyConfig.Type.FORM_B,
			Vector2(GameState.screen_size.x / 2, -8.0)
		)
	
	# PINK BALLS
	if checkpoint < 2460 and position.y >= 2460 and not spawn_form_d[5]:
		spawn_form_d[5] = true
		
		_spawn_enemy_helper(
			EnemyConfig.Type.FORM_D,
			Vector2(0.0, -8.0)
		)
	
	if checkpoint < 2480 and position.y >= 2480 and not spawn_form_d[6]:
		spawn_form_d[6] = true
		
		_spawn_enemy_helper(
			EnemyConfig.Type.FORM_D,
			Vector2(GameState.screen_size.x / 2, -8.0)
		)
	
	if checkpoint < 2540 and position.y >= 2540 and not spawn_form_d[7]:
		spawn_form_d[7] = true
		
		_spawn_enemy_helper(
			EnemyConfig.Type.FORM_D,
			Vector2(GameState.screen_size.x / 2, -8.0)
		)
	
	if checkpoint < 2560 and position.y >= 2560 and not spawn_form_d[8]:
		spawn_form_d[8] = true
		
		_spawn_enemy_helper(
			EnemyConfig.Type.FORM_D,
			Vector2(0.0, -8.0)
		)
	
	# C-GLIDER
	if checkpoint < 2600 and position.y >= 2600 and not spawn_form_cr[0]:
		spawn_form_cr[0] = true
		
		_spawn_enemy_helper(
			EnemyConfig.Type.FORM_CR,
			Vector2(GameState.screen_size.x / 2, -8.0)
		)
	
	# PINK BALLS
	if checkpoint < 2660 and position.y >= 2660 and not spawn_form_d[9]:
		spawn_form_d[9] = true
		
		_spawn_enemy_helper(
			EnemyConfig.Type.FORM_D,
			Vector2(GameState.screen_size.x / 3, -8.0)
		)
	
	if checkpoint < 2690 and position.y >= 2690 and not spawn_form_d[10]:
		spawn_form_d[10] = true
		
		_spawn_enemy_helper(
			EnemyConfig.Type.FORM_D,
			Vector2(2 * GameState.screen_size.x / 3, -8.0)
		)
	
	# C-GLIDER
	if checkpoint < 2740 and position.y >= 2740 and not spawn_form_c[2]:
		spawn_form_c[2] = true
		
		_spawn_enemy_helper(
			EnemyConfig.Type.FORM_C,
			Vector2(GameState.screen_size.x / 2, -8.0)
		)
	
	# PINK BALLS
	if checkpoint < 2800 and position.y >= 2800 and not spawn_form_d[11]:
		spawn_form_d[11] = true
		
		_spawn_enemy_helper(
			EnemyConfig.Type.FORM_D,
			Vector2(GameState.screen_size.x / 3, -8.0)
		)
	
	if checkpoint < 2820 and position.y >= 2820 and not spawn_form_d2[13]:
		spawn_form_d2[13] = true
		
		_spawn_enemy_helper(
			EnemyConfig.Type.FORM_D2,
			Vector2(GameState.screen_size.x / 4, -8.0)
		)
	
	if checkpoint < 2840 and position.y >= 2840 and not spawn_form_d2[14]:
		spawn_form_d2[14] = true
		
		_spawn_enemy_helper(
			EnemyConfig.Type.FORM_D2,
			Vector2(GameState.screen_size.x / 4, -8.0)
		)
	
	# C-GLIDER
	if checkpoint < 2880 and position.y >= 2880 and not spawn_form_cr[1]:
		spawn_form_cr[1] = true
		
		_spawn_enemy_helper(
			EnemyConfig.Type.FORM_CR,
			Vector2(GameState.screen_size.x / 2, -8.0)
		)
	
	# TIE FIGHTERS
	if checkpoint < 2930 and position.y >= 2930 and not spawn_form_g[2]:
		spawn_form_g[2] = true
		
		_spawn_enemy_helper(
			EnemyConfig.Type.FORM_G,
			Vector2(0.0, -8.0)
		)
	
	if checkpoint < 2980 and position.y >= 2980 and not spawn_form_gr[2]:
		spawn_form_gr[2] = true
		
		_spawn_enemy_helper(
			EnemyConfig.Type.FORM_GR,
			Vector2(0.0, -8.0)
		)
	
	if checkpoint < 3030 and position.y >= 3030 and not spawn_form_gr[3]:
		spawn_form_gr[3] = true
		
		_spawn_enemy_helper(
			EnemyConfig.Type.FORM_GR,
			Vector2(0.0, -8.0)
		)
	
	if checkpoint < 3080 and position.y >= 3080 and not spawn_form_g[3]:
		spawn_form_g[3] = true
		
		_spawn_enemy_helper(
			EnemyConfig.Type.FORM_G,
			Vector2(0.0, -8.0)
		)
	
	# TODO: - PINWHEELS
	if checkpoint < 3100 and position.y >= 3100 and not spawn_form_h[0]:
		spawn_form_h[0] = true
		
		_spawn_enemy_helper(
			EnemyConfig.Type.FORM_H,
			Vector2.ZERO
		)
