extends LevelBase

# PROPERTIES

var spawn_form_a: bool = false
var spawn_form_ar: bool = false


# FUNCTIONS

func _spawn_enemies() -> void:
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
