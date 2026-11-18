extends Node
class_name PowerupManager

# PROPERTIES

const POWERUP_SCENE = preload("res://scenes/powerup.tscn")
const THRESHOLD = 12

signal powerup_did_earn(type: Powerup.Type)

var bullet_type: Powerup.Type = Powerup.Type.MAIN


# FUNCTIONS

func increment_powerup_count() -> void:
	GameState.powerup_count += 1
	
	if GameState.powerup_count > 0 and GameState.powerup_count % THRESHOLD == 0:
		_offer_powerup(int(float(GameState.powerup_count) / float(THRESHOLD)))


func collect_powerup(type: Powerup.Type) -> void:
	if type == Powerup.Type.TRIPLE:
		bullet_type = Powerup.Type.TRIPLE
	elif type == Powerup.Type.LASER:
		bullet_type = Powerup.Type.LASER


# HELPER FUNCTIONS

func _offer_powerup(index: int) -> void:
	var type: Powerup.Type
	
	# == OFFERINGS ==
	# 1 - Speed
	# 2 - Triple
	# 3 - Speed
	# 4 - Laser (or Triple if not gotten yet)
	# 5 - Speed
	# 6 - Drone
	# 7 - Speed
	# 8 - Drone
	# 9 - Speed
	# 10 - Speed
	# 11+ - Triple or Laser (if not gotten yet)
	
	match index:
		1: type = Powerup.Type.SPEED
		2: type = Powerup.Type.TRIPLE
		3: type = Powerup.Type.SPEED
		4:
			if bullet_type == Powerup.Type.TRIPLE:
				type = Powerup.Type.LASER
			else:
				type = Powerup.Type.TRIPLE
		5: type = Powerup.Type.SPEED
		6: pass # TODO: - Drone
		7: type = Powerup.Type.SPEED
		8: pass # TODO: - Drone
		9: type = Powerup.Type.SPEED
		10: type = Powerup.Type.SPEED
		11, 12, 13, 14, 15, 16, 17, 18, 19, 20:
			if bullet_type == Powerup.Type.TRIPLE:
				type = Powerup.Type.LASER
			elif bullet_type == Powerup.Type.MAIN:
				type = Powerup.Type.TRIPLE
	
	if type:
		powerup_did_earn.emit(type)
