extends Node2D
class_name GameScene

# PROPERTIES

const TITLE_SCENE = preload("res://scenes/title.tscn")

@onready var level = $Level1
@onready var player = $Player
@onready var enemies = $Enemies
@onready var extras = $Extras
@onready var hud = $Hud
@onready var game_over_hud = $GameOverHud
@onready var game_over_score_label = $GameOverHud/Control/ScoreLabel
@onready var powerup_manager = %PowerupManager
@onready var intro_stream = $IntroAudioStreamPlayer
@onready var loop_stream = $LoopAudioStreamPlayer
@onready var death_stream = $DeathAudioStreamPlayer
@onready var game_over_stream = $GameOverAudioStreamPlayer


# FUNCTIONS

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.did_die.connect(player_did_die)
	
	level.setup(player, powerup_manager)
	player.setup(powerup_manager)
	
	intro_stream.play()
	intro_stream.finished.connect(_play_bgm_loop)
	
	if intro_stream.stream == null:
		_play_bgm_loop()
	
	await get_tree().create_timer(3.0).timeout
	hud.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _play_bgm_loop():
	loop_stream.play()


func fade_music(duration: float = 6.0):
	var tween = create_tween()
	tween.tween_property(
		loop_stream,
		"volume_db",
		-80.0,
		duration
	)


func player_did_die() -> void:
	intro_stream.stop()
	loop_stream.stop()
	death_stream.play()
	
	await get_tree().create_timer(3.5).timeout
	
	GameState.update_lives(-1)
	GameState.powerup_count = 0
	
	if GameState.lives >= 0:
		get_parent().restart_game(self)
	else:
		_play_game_over()


func _play_game_over() -> void:
	level.stop_scrolling()
	
	game_over_hud.show()
	hud.hide()
	enemies.hide()
	extras.hide()
	
	game_over_score_label.text = GameState.get_score_str()
	game_over_stream.play()
	
	await get_tree().create_timer(6.0).timeout
	_return_to_title()


func _return_to_title() -> void:
	var main_scene = get_parent() as Main
	
	if main_scene == null:
		return
	
	GameState.reset_all()
	
	queue_free()
	
	var title_scene = TITLE_SCENE.instantiate()
	main_scene.add_child(title_scene)
	main_scene.title_scene = title_scene
