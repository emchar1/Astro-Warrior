extends CharacterBody2D
class_name Enemy

# PROPERTIES

@onready var anim_sprite = $AnimatedSprite2D

var enemy_config: EnemyConfig
var speed: float
var elapsed_time: float = 0.0


# FUNCTIONS

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_move(delta)
	
	move_and_slide()


func setup() -> void:
	speed = enemy_config.speed
	
	anim_sprite.animation = enemy_config.get_anim_name()
	anim_sprite.play()


func _move(delta: float) -> void:
	# You should override this function with specific enemy move implementation
	pass


func _die() -> void:
	hide()


# SIGNAL FUNCTIONS

func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullet"):
		if area is Bullet:
			area.die()
		
		_die()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	print("Enemy queue_free().")
	queue_free()
