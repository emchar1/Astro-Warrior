extends CharacterBody2D

# PROPERTIES

signal did_die

const SPRITE_LEN = 10.0
const BULLET_SCENE = preload("res://scenes/bullet.tscn")
const EXPLOSION_SCENE = preload("res://scenes/explosion.tscn")

@export var speed: float = 80.0

@onready var hurtbox = $Hurtbox
@onready var shoot_timer = $ShootTimer

var move_dir: Vector2


# FUNCTIONS

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
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
	var bullet = BULLET_SCENE.instantiate() as Bullet
	get_parent().add_child(bullet)
	bullet.global_position = global_position


func _die() -> void:
	set_physics_process(false)
	hurtbox.set_deferred("monitoring", false)
	hide()
	did_die.emit()
	
	var explosion = EXPLOSION_SCENE.instantiate() as Explosion
	get_tree().current_scene.add_child(explosion)
	explosion.activate(position)


# SIGNAL CALLBACK FUNCTIONS

func _on_hurtbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		if body is Enemy:
			_die()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	await get_tree().create_timer(3.0).timeout
	queue_free()
