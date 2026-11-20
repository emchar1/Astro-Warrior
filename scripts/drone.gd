extends Area2D
class_name Drone

# PROPERTIES

const BULLET_SCENE = preload("res://scenes/bullet.tscn")

@export var player: Player

var speed: float
var is_unlocked: bool = false

var trail_delay: int


# FUNCTIONS

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if is_instance_valid(player):
		player.did_shoot.connect(_shoot)
	
	if not is_unlocked:
		hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	if not is_unlocked:
		return
	
	if not is_instance_valid(player):
		return
	
	speed = player.speed
	
	if player.position_history.size() >= trail_delay:
		position = position.lerp(player.position_history[trail_delay - 1], 0.3)


func unlock(_trail_delay: int) -> void:
	is_unlocked = true
	trail_delay = _trail_delay
	
	if is_instance_valid(player):
		position = player.position + Vector2(20.0, 0.0)
	
	show()


func _shoot() -> void:
	if not is_unlocked:
		return
	
	if not is_instance_valid(player):
		return
	
	var bullet = BULLET_SCENE.instantiate() as Bullet
	bullet.powerup_manager = player.powerup_manager
	bullet.should_silence = true
	
	GameState.add_child_to_game_scene(bullet, "Extras")
	
	bullet.global_position = global_position
