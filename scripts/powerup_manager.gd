extends Node
class_name PowerupManager

# PROPERTIES

const POWERUP_SCENE = preload("res://scenes/powerup.tscn")

signal powerup_count_did_increment(total_count: int)


# FUNCTIONS

func increment_powerup_count() -> void:
	GameState.powerup_count += 1
	powerup_count_did_increment.emit(GameState.powerup_count)
