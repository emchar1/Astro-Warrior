extends CharacterBody2D
class_name Player

# PROPERTIES

signal did_die
signal did_shoot

enum EscapeState {
	NONE, MOVE_TO_CENTER, PULL_BACK, LAUNCH_FORWARD
}

const SPRITE_LEN = 10.0
const TRAIL_LENGTH = 15
const BULLET_SCENE = preload("res://scenes/bullet.tscn")
const EXPLOSION_SCENE = preload("res://scenes/explosion.tscn")

@export var speed: float = 80.0

@onready var sprite = $Sprite2D
@onready var hurtbox = $Hurtbox
@onready var shoot_timer = $ShootTimer
@onready var main_timer = $MainShootTimer
@onready var laser_timer = $LaserShootTimer

var powerup_manager: PowerupManager
var escape_state: EscapeState = EscapeState.NONE
var move_dir: Vector2
var is_dead: bool = false

var position_history: Array[Vector2] = []


# FUNCTIONS

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	_read_input()
	_read_movement()
	
	move_and_slide()


func setup(_powerup_manager: PowerupManager) -> void:
	powerup_manager = _powerup_manager
	update_weapon()


# POWERUP FUNCTIONS

func update_weapon() -> void:
	var sprite_offset_x: float
	
	match powerup_manager.bullet_type:
		Powerup.Type.LASER:
			sprite_offset_x = 34.0
			shoot_timer.wait_time = 0.4
			shoot_timer.start()
		Powerup.Type.TRIPLE:
			sprite_offset_x = 17.0
			shoot_timer.wait_time = 0.2
			shoot_timer.start()
		_:
			sprite_offset_x = 0.0
			shoot_timer.wait_time = 0.4
			shoot_timer.start()
	
	sprite.texture.region = Rect2(sprite_offset_x, 0.0, 16.0, 16.0)


func increase_speed() -> void:
	speed += 30.0


func escape() -> void:
	escape_state = EscapeState.MOVE_TO_CENTER
	
	await get_tree().create_timer(3.0).timeout
	if is_instance_valid(self):
		escape_state = EscapeState.LAUNCH_FORWARD


# HELPER FUNCTIONS

func _read_input() -> void:
	if escape_state != EscapeState.NONE:
		return
	
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
		if (
			powerup_manager.bullet_type == Powerup.Type.LASER
			and not laser_timer.is_stopped()
		) or (
			powerup_manager.bullet_type == Powerup.Type.MAIN
			and not main_timer.is_stopped()
		):
			return
		
		_shoot()
		shoot_timer.start()
		main_timer.start()
		laser_timer.start()


func _read_movement() -> void:
	# Escape movement
	if escape_state != EscapeState.NONE:
		match escape_state:
			EscapeState.MOVE_TO_CENTER:
				var center := GameState.screen_size / 2.0
				velocity = position.direction_to(center) * 120.0
				
				if position.distance_to(center) < 2.0:
					escape_state = EscapeState.PULL_BACK
			EscapeState.PULL_BACK:
				velocity = Vector2.DOWN * 10.0
			EscapeState.LAUNCH_FORWARD:
				velocity = Vector2.UP * 1000.0
		
		_add_to_position_history()
		return
	
	# Input movement
	velocity = move_dir * speed
	
	if position.x <= SPRITE_LEN and velocity.x < 0:
		velocity.x = 0
	
	if position.x >= GameState.screen_size.x - SPRITE_LEN and velocity.x > 0:
		velocity.x = 0
	
	if position.y <= SPRITE_LEN and velocity.y < 0:
		velocity.y = 0
	
	if position.y >= GameState.screen_size.y - SPRITE_LEN and velocity.y > 0:
		velocity.y = 0
	
	# For Drone pathing...
	if velocity != Vector2.ZERO:
		_add_to_position_history()


func _add_to_position_history() -> void:
	position_history.push_front(position)
	
	if position_history.size() > TRAIL_LENGTH * 2:
		position_history.pop_back()


func _shoot() -> void:
	var bullet = BULLET_SCENE.instantiate() as Bullet
	bullet.powerup_manager = powerup_manager
	
	GameState.add_child_to_game_scene(bullet, "Extras")
	
	bullet.global_position = global_position
	
	did_shoot.emit()


func _die() -> void:
	if is_dead:
		return
	
	is_dead = true
	set_physics_process(false)
	hurtbox.set_deferred("monitoring", false)
	hide()
	did_die.emit()
	
	# Add explosion
	var explosion = EXPLOSION_SCENE.instantiate() as Explosion
	GameState.add_child_to_game_scene(explosion, "Extras")
	explosion.activate(position)


# SIGNAL CALLBACK FUNCTIONS

func _on_hurtbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		if body is Enemy or body is Boss:
			_die()


func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy_bullet"):
		if area is EnemyBullet:
			_die()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	await get_tree().create_timer(3.0).timeout
	
	if is_instance_valid(self):
		queue_free()
