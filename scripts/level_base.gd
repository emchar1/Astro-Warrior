extends Node2D
class_name LevelBase

# PROPERTIES

@export var level_name: String
@export var scroll_speed: float = 20.0
@export var checkpoint: float = 0.0

@onready var canvas_layer = $CanvasLayer
@onready var level_label = $CanvasLayer/Control/LevelLabel
@onready var score_label = $CanvasLayer/Control/ScoreLabel
@onready var lives_label = $CanvasLayer/Control/LivesLabel

var player: Player
var powerup_manager: PowerupManager


# FUNCTIONS

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level_label.text = level_name
	score_label.text = str(GameState.score).pad_zeros(6)
	lives_label.text = str(" x ", GameState.lives)
	
	position.y = checkpoint
	
	await get_tree().create_timer(3.0).timeout
	canvas_layer.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_scroll_level(delta)
	_spawn_enemies()


func setup(_player: Player, _powerup_manager: PowerupManager) -> void:
	player = _player
	powerup_manager = _powerup_manager
	powerup_manager.powerup_did_earn.connect(_spawn_powerup)


func _scroll_level(delta: float) -> void:
	position.y += delta * scroll_speed
	#print("position.y: ", position.y)


func _spawn_enemies() -> void:
	# You should override this function with specific Level _spawn_enemies()
	# implementation.
	pass


func _spawn_enemy_helper(
	scene: PackedScene,
	config: EnemyConfig,
	type: EnemyConfig.Type,
	pos: Vector2 = Vector2(GameState.screen_size.x / 2, 0.0)
) -> void:
	var enemy = scene.instantiate() as Enemy
	
	GameState.add_child_to_game_scene(enemy, "Enemies")
	
	enemy.enemy_config = config
	enemy.enemy_config.type = type
	enemy.position = pos
	enemy.setup()


func _spawn_powerup(type: Powerup.Type) -> void:
	var powerup = PowerupManager.POWERUP_SCENE.instantiate() as Powerup
	powerup.powerup_manager = powerup_manager
	powerup.type = type
	GameState.call_deferred("add_child_to_game_scene", powerup, "Extras")
