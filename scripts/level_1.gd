extends LevelBase

# PROPERTIES

var spawn_form_a: bool = false
var spawn_form_ar: bool = false


# FUNCTIONS

func _spawn_enemies() -> void:
	var glider_count := 6
	var glider_spacing := 0.2
	
	if position.y >= 100:
		if not spawn_form_a:
			spawn_form_a = true
			
			for i in range(glider_count):
				var enemy = ENEMY_GLIDER_SCENE.instantiate()
				get_tree().current_scene.add_child(enemy)
				
				enemy.enemy_config = ENEMY_GLIDER_CONFIG.duplicate()
				enemy.enemy_config.type = EnemyConfig.Type.FORM_A
				enemy.position = Vector2(GameState.screen_size.x / 2, 0)
				enemy.setup()
				
				await get_tree().create_timer(glider_spacing).timeout
	
	if position.y >= 200:
		if not spawn_form_ar:
			spawn_form_ar = true
			
			for i in range(glider_count):
				var enemy = ENEMY_GLIDER_SCENE.instantiate()
				get_tree().current_scene.add_child(enemy)
				
				enemy.enemy_config = ENEMY_GLIDER_CONFIG.duplicate()
				enemy.enemy_config.type = EnemyConfig.Type.FORM_AR
				enemy.position = Vector2(GameState.screen_size.x / 2, 0)
				enemy.setup()
				
				await get_tree().create_timer(glider_spacing).timeout
