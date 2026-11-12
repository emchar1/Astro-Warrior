extends Node2D
class_name LevelBase

# PROPERTIES

const ENEMY_GLIDER_SCENE = preload("res://enemy/enemy_glider.tscn")
const ENEMY_PINK_BALL_SCENE = preload("res://enemy/enemy_pink_ball.tscn")
const ENEMY_CROSS_SCENE = preload("res://enemy/enemy_cross.tscn")

const ENEMY_GLIDER_CONFIG = preload("res://resources/enemy_glider.tres")
const ENEMY_PINK_BALL_CONFIG = preload("res://resources/enemy_pink_ball.tres")
const ENEMY_CROSS_CONFIG = preload("res://resources/enemy_cross.tres")

@export var level_name: String
@export var scroll_speed: float = 20.0

@onready var canvas_layer = $CanvasLayer
@onready var level_label = $CanvasLayer/Control/LevelLabel
@onready var score_label = $CanvasLayer/Control/ScoreLabel
@onready var lives_label = $CanvasLayer/Control/LivesLabel


# FUNCTIONS

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level_label.text = level_name
	score_label.text = str(GameState.score)
	lives_label.text = " x " + str(GameState.lives)
	
	await get_tree().create_timer(3.0).timeout
	canvas_layer.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_scroll_level(delta)
	_spawn_enemies()


func _scroll_level(delta: float) -> void:
	position.y += delta * scroll_speed


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
