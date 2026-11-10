extends Enemy

# PROPERTIES

var elapsed_time: float = 0.0


# OVERRIDEN FUNCTIONS

func _ready() -> void:
	die_scale = Vector2(0.5, 0.5)


func _move(delta: float) -> void:
	var pivot: float = 30.0
	var speed_coefficient: float = 30.0
	
	elapsed_time += delta
	
	match enemy_config.type:
		EnemyConfig.Type.FORM_A:
			velocity.y = enemy_config.speed
			
			if position.y > pivot:
				velocity.x = -speed_coefficient * pow(elapsed_time, 2)
		EnemyConfig.Type.FORM_AR:
			velocity.y = enemy_config.speed
			
			if position.y > pivot:
				velocity.x = speed_coefficient * pow(elapsed_time, 2)
