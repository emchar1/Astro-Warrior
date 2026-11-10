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
				_spawn_enemy_helper(
					ENEMY_GLIDER_SCENE,
					ENEMY_GLIDER_CONFIG,
					EnemyConfig.Type.FORM_A
				)
				
				await get_tree().create_timer(glider_spacing).timeout
	
	if position.y >= 200:
		if not spawn_form_ar:
			spawn_form_ar = true
			
			for i in range(glider_count):
				_spawn_enemy_helper(
					ENEMY_GLIDER_SCENE,
					ENEMY_GLIDER_CONFIG,
					EnemyConfig.Type.FORM_AR
				)
				
				await get_tree().create_timer(glider_spacing).timeout
