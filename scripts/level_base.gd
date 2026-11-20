extends Node2D
class_name LevelBase

# PROPERTIES

@warning_ignore("unused_signal") signal boss_triggered
signal drone_collected

@export var level_name: String
@export var scroll_speed: float = 20.0

@export var checkpoint_mid: float = 0.0
@export var checkpoint_boss: float = 0.0
@export var boss_fight: float = 0.0
@export var debug_checkpoint: float = 0.0

@onready var canvas_layer = $CanvasLayer
@onready var level_label = $CanvasLayer/Control/LevelLabel
@onready var score_label = $CanvasLayer/Control/ScoreLabel
@onready var lives_label = $CanvasLayer/Control/LivesLabel

var player: Player
var powerup_manager: PowerupManager
var checkpoint: float # This prevents enemies spawning after checkpoints
var did_trigger_boss: bool = false


# FUNCTIONS

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level_label.text = level_name
	score_label.text = GameState.get_score_str()
	lives_label.text = str(" x ", GameState.lives)
	
	# Read from checkpoints
	if GameState.checkpoint_boss_reached:
		position.y = checkpoint_boss
		checkpoint = checkpoint_boss
	elif GameState.checkpoint_mid_reached:
		position.y = checkpoint_mid
		checkpoint = checkpoint_mid
	else:
		position.y = 0.0
		checkpoint = 0.0
	
	if debug_checkpoint > 0.0:
		position.y = debug_checkpoint
		checkpoint = debug_checkpoint
	
	await get_tree().create_timer(3.0).timeout
	
	if is_instance_valid(self):
		canvas_layer.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	_scroll_level(delta)
	_spawn_enemies()


func setup(_player: Player, _powerup_manager: PowerupManager) -> void:
	player = _player
	powerup_manager = _powerup_manager
	powerup_manager.powerup_did_earn.connect(_spawn_powerup)


func _scroll_level(delta: float) -> void:
	position.y += delta * scroll_speed
	#print("position.y: ", position.y)
	
	# Set Checkpoints
	if debug_checkpoint <= 0.0:
		if position.y >= checkpoint_boss:
			if not GameState.checkpoint_boss_reached:
				checkpoint = checkpoint_boss
				GameState.checkpoint_boss_reached = true
		elif position.y >= checkpoint_mid:
			if not GameState.checkpoint_mid_reached:
				checkpoint = checkpoint_mid
				GameState.checkpoint_mid_reached = true


func stop_scrolling() -> void:
	scroll_speed = 0.0


func _spawn_enemies() -> void:
	# You should override this function with specific Level _spawn_enemies()
	# implementation.
	pass


func _spawn_enemy_helper(type: EnemyConfig.Type, pos: Vector2) -> void:
	if not is_instance_valid(player):
		return
	
	var enemy_class: Enemy
	var enemy: Enemy
	
	match EnemyConfig.get_type_readable(type):
		EnemyConfig.TypeReadable.GLIDER:
			enemy_class = EnemyGlider.new()
		EnemyConfig.TypeReadable.PINK_BALL:
			enemy_class = EnemyPinkBall.new()
		EnemyConfig.TypeReadable.CROSS:
			enemy_class = EnemyCross.new()
		EnemyConfig.TypeReadable.BLUE_BALL:
			enemy_class = EnemyBlueBall.new()
		EnemyConfig.TypeReadable.TIE_FIGHTER:
			enemy_class = EnemyTieFighter.new()
		EnemyConfig.TypeReadable.PINWHEEL:
			enemy_class = EnemyPinwheel.new()
	
	enemy = enemy_class.scene.instantiate() as Enemy
	enemy.player = player
	
	GameState.add_child_to_game_scene(enemy, "Enemies")
	
	enemy.enemy_config = enemy_class.config.duplicate()
	enemy.enemy_config.type = type
	enemy.position = pos
	enemy.setup()


func _spawn_powerup(type: Powerup.Type) -> void:
	var powerup = PowerupManager.POWERUP_SCENE.instantiate() as Powerup
	powerup.did_collect_drone.connect(drone_collected.emit)
	powerup.powerup_manager = powerup_manager
	powerup.type = type
	GameState.call_deferred("add_child_to_game_scene", powerup, "Extras")
