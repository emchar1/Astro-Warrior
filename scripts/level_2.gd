extends LevelBase

# PROPERTIES

var spawn_form_i: Array[bool] = [false, false]
var spawn_form_j: Array[bool] = [false]


# FUNCTIONS

func _spawn_enemies() -> void:
	# ASTEROIDS
	if checkpoint < 100 and position.y >= 100 and not spawn_form_i[0]:
		spawn_form_i[0] = true
		
		for i in range(15):
			_spawn_enemy_helper(
				EnemyConfig.Type.FORM_I,
				Vector2(randf_range(0, GameState.screen_size.x), -8.0)
			)
			
			await get_tree().create_timer(0.15).timeout
	
	if checkpoint < 200 and position.y >= 200 and not spawn_form_i[1]:
		spawn_form_i[1] = true
		
		for i in range(15):
			_spawn_enemy_helper(
				EnemyConfig.Type.FORM_I,
				Vector2(randf_range(0, GameState.screen_size.x), -8.0)
			)
			
			await get_tree().create_timer(0.15).timeout
	
	# ICICLES
	if checkpoint < 300 and position.y >= 300 and not spawn_form_j[0]:
		spawn_form_j[0] = true
		
		_spawn_enemy_helper(
			EnemyConfig.Type.FORM_J,
			Vector2(randf_range(0, GameState.screen_size.x), -8.0)
		)
