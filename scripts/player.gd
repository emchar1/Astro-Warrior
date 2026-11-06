extends CharacterBody2D

# PROPERTIES

const SPRITE_LEN = 10.0
const BULLET_SCENE = preload("res://scenes/bullet.tscn")

@export var speed: float = 80.0
@onready var shoot_timer = $ShootTimer

var move_dir: Vector2


# FUNCTIONS

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	_read_input()
	_read_movement()
	
	move_and_slide()


# HELPER FUNCTIONS

func _read_input() -> void:
	move_dir = Input.get_vector(
		"move_left",
		"move_right",
		"move_up",
		"move_down"
	)
	
	var shoot_pressed = (
		Input.is_action_just_pressed("shoot")
		or Input.is_action_just_pressed("shoot2")
	)
	
	var shoot_held = (
		Input.is_action_pressed("shoot")
		or Input.is_action_pressed("shoot2")
	) and shoot_timer.is_stopped()
	
	if shoot_pressed or shoot_held:
		_shoot()
		shoot_timer.start()


func _read_movement() -> void:
	velocity = move_dir * speed
	
	if position.x <= SPRITE_LEN and velocity.x < 0:
		velocity.x = 0
	
	if position.x >= GameState.screen_size.x - SPRITE_LEN and velocity.x > 0:
		velocity.x = 0
	
	if position.y <= SPRITE_LEN and velocity.y < 0:
		velocity.y = 0
	
	if position.y >= GameState.screen_size.y - SPRITE_LEN and velocity.y > 0:
		velocity.y = 0


func _shoot() -> void:
	var bullet = BULLET_SCENE.instantiate()
	get_parent().add_child(bullet)
	bullet.global_position = global_position
