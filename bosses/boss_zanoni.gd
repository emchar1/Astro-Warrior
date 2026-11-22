extends Boss
class_name BossZanoni

# PROPERTIES

@onready var shield1 = $Hurtboxes/BossShield
@onready var shield2 = $Hurtboxes/BossShield2
@onready var shield3 = $Hurtboxes/BossShield3
@onready var shield4 = $Hurtboxes/BossShield4
@onready var shield5 = $Hurtboxes/BossShield5

var dip_count: int = 0


# FUNCTIONS

func _init() -> void:
	scene = preload("res://bosses/boss_zanoni.tscn")
	config = preload("res://resources/boss_zanoni.tres")


func _ready() -> void:
	shield1.can_target = false
	shield2.can_target = false
	shield3.can_target = false
	shield4.can_target = false
	shield5.can_target = false
	
	shield1.did_die.connect(_enable_shield3)
	shield2.did_die.connect(_enable_shield4)
	shield3.did_die.connect(_enable_shield5)
	shield4.did_die.connect(_enable_shield5)
	shield5.did_die.connect(_die)


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
			
			# Enable shield targeting
			if is_instance_valid(shield1) and not shield1.can_target:
				shield1.can_target = true
			if is_instance_valid(shield2) and not shield2.can_target:
				shield2.can_target = true
		MoveType.ATTACK2:
			pass


func _enable_shield3() -> void:
	shield3.can_target = true


func _enable_shield4() -> void:
	shield4.can_target = true


func _enable_shield5() -> void:
	if is_instance_valid(shield1) and not shield1.is_dead:
		return
	if is_instance_valid(shield2) and not shield2.is_dead:
		return
	if is_instance_valid(shield3) and not shield3.is_dead:
		return
	if is_instance_valid(shield4) and not shield4.is_dead:
		return
	
	shield5.can_target = true


# SIGNAL CALLBACK FUNCTIONS

func _on_attack_timer_timeout() -> void:
	if not is_instance_valid(player):
		return
	
	if move_type != MoveType.ATTACK1:
		return
	
	if is_instance_valid(shield1) and not shield1.is_dead:
		shield1.attack(player.position)
	if is_instance_valid(shield2) and not shield2.is_dead:
		shield2.attack(player.position)
	if is_instance_valid(shield3) and not shield3.is_dead:
		shield3.attack(player.position)
	if is_instance_valid(shield4) and not shield4.is_dead:
		shield4.attack(player.position)
	if is_instance_valid(shield5) and not shield5.is_dead:
		shield5.attack(player.position)


func _on_attack_spread_timer_timeout() -> void:
	if not is_instance_valid(player):
		return
	
	if move_type != MoveType.ATTACK1:
		return
	
	if is_instance_valid(shield5) and shield5.can_target \
	and not shield5.is_dead:
		shield5.attack2(player.position)
