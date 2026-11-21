extends Boss
class_name BossZanoni

# PROPERTIES



# FUNCTIONS

func _init() -> void:
	scene = preload("res://bosses/boss_zanoni.tscn")
	config = preload("res://resources/boss_zanoni.tres")


func _move(delta: float) -> void:
	super._move(delta)
	
	match move_type:
		MoveType.ATTACK1:
			velocity.y = boss_config.speed
		MoveType.ATTACK2:
			pass
