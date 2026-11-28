extends LevelBase

# PROPERTIES

var spawn_form_i: Array[bool] = [false, false]
var spawn_form_j: Array[bool] = [false, false, false, false]


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
		
		for i in randi_range(5, 8):
			_spawn_enemy_helper(
				EnemyConfig.Type.FORM_J,
				Vector2(randf_range(16.0, GameState.screen_size.x - 16.0), -8.0)
			)
			
			await get_tree().create_timer(0.5).timeout
	
	if checkpoint < 400 and position.y >= 400 and not spawn_form_j[1]:
		spawn_form_j[1] = true
		
		for i in randi_range(5, 8):
			_spawn_enemy_helper(
				EnemyConfig.Type.FORM_J,
				Vector2(randf_range(16.0, GameState.screen_size.x - 16.0), -8.0)
			)
			
			await get_tree().create_timer(0.5).timeout
	
	if checkpoint < 500 and position.y >= 500 and not spawn_form_j[2]:
		spawn_form_j[2] = true
		
		for i in randi_range(5, 8):
			_spawn_enemy_helper(
				EnemyConfig.Type.FORM_J,
				Vector2(randf_range(16.0, GameState.screen_size.x - 16.0), -8.0)
			)
			
			await get_tree().create_timer(0.5).timeout
	
	if checkpoint < 600 and position.y >= 600 and not spawn_form_j[3]:
		spawn_form_j[3] = true
		
		for i in randi_range(5, 8):
			_spawn_enemy_helper(
				EnemyConfig.Type.FORM_J,
				Vector2(randf_range(16.0, GameState.screen_size.x - 16.0), -8.0)
			)
			
			await get_tree().create_timer(0.5).timeout
