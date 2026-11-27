extends Enemy
class_name EnemyIcicles

# PROPERTIES



# FUNCTIONS

func _init() -> void:
	scene = preload("res://enemy/enemy_icicles.tscn")
	config = preload("res://resources/enemy_icicles.tres")


func _move(_delta: float) -> void:
	velocity.y = enemy_config.speed
