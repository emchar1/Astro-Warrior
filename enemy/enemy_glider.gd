extends Enemy

func _move(delta: float) -> void:
	super(delta)
	
	var pivot: float = 30.0
	var speed_coefficient: float = 30.0
	
	elapsed_time += delta
	
	match enemy_config.type:
		EnemyConfig.Type.FORM_A:
			velocity.y = speed
			
			if position.y > pivot:
				velocity.x = -speed_coefficient * pow(elapsed_time, 2)
		EnemyConfig.Type.FORM_AR:
			velocity.y = speed
			
			if position.y > pivot:
				velocity.x = speed_coefficient * pow(elapsed_time, 2)
