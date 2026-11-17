extends Node2D
class_name LevelBase

# PROPERTIES

const POWERUP_SCENE = preload("res://scenes/powerup.tscn")

@export var level_name: String
@export var scroll_speed: float = 20.0

@onready var canvas_layer = $CanvasLayer
@onready var level_label = $CanvasLayer/Control/LevelLabel
@onready var score_label = $CanvasLayer/Control/ScoreLabel
@onready var lives_label = $CanvasLayer/Control/LivesLabel

var player: Player


# FUNCTIONS

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameState.powerup_count_did_change.connect(_spawn_powerup)
	
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


func _spawn_powerup(count: int) -> void:
	var powerup_type: Powerup.Type
	
	match count:
		Powerup.INCREMENT * 1:
			powerup_type = Powerup.Type.SPEED
		Powerup.INCREMENT * 2:
			if player:
				powerup_type = Powerup.Type.TRIPLE
			else:
				print("Error finding player! Here's a speed boost.")
				powerup_type = Powerup.Type.SPEED
		Powerup.INCREMENT * 3:
			powerup_type = Powerup.Type.SPEED
		Powerup.INCREMENT * 4:
			if player:
				if player.current_powerup_level == Powerup.Type.TRIPLE:
					powerup_type = Powerup.Type.LASER
				else:
					powerup_type = Powerup.Type.TRIPLE
			else:
				print("Error finding player! Here's a speed boost again.")
				powerup_type = Powerup.Type.SPEED
		Powerup.INCREMENT * 5:
			powerup_type = Powerup.Type.SPEED
	
	if count % Powerup.INCREMENT == 0:
		var powerup = POWERUP_SCENE.instantiate() as Powerup
		powerup.current_type = powerup_type
		GameState.call_deferred("add_child_to_game_scene", powerup, "Extras")
