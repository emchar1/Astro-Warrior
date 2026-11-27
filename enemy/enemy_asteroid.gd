extends Enemy
class_name EnemyAsteroid

# PROPERTIES

var dir_to_player: Vector2


# FUNCTIONS

func _init() -> void:
	scene = preload("res://enemy/enemy_asteroid.tscn")
	config = preload("res://resources/enemy_asteroid.tres")


func setup() -> void:
	super.setup()
	
	if player:
		dir_to_player = position.direction_to(player.position)


func _move(_delta: float) -> void:
	velocity = dir_to_player * enemy_config.speed * randf_range(0.25, 2.0)
