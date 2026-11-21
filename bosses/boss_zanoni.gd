extends Boss
class_name BossZanoni

# PROPERTIES

var dip_count: int = 0


# FUNCTIONS

func _init() -> void:
	scene = preload("res://bosses/boss_zanoni.tscn")
	config = preload("res://resources/boss_zanoni.tres")


func _move(delta: float) -> void:
	super._move(delta)
	
	match move_type:
		MoveType.ATTACK1:
			if not is_instance_valid(player):
				return
			
			var texture = sprite.texture
			
			if texture == null:
				return
			
			var sprite_height = texture.region.size.y
			var dir := position.direction_to(player.position)
			
			if position.y <= sprite_height / 2 + 2:
				# Downward movement
				if dip_count % 4 == 0 or dip_count % 4 == 3:
					velocity.x = boss_config.speed * dir.x * 2
				else:
					velocity.x = 0
				
				velocity.y = boss_config.speed
			elif position.y >= sprite_height:
				# Upward movement
				velocity.y = -boss_config.speed
				dip_count += 1
		MoveType.ATTACK2:
			pass
