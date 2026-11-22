extends Node2D
class_name GameScene

# PROPERTIES

const TITLE_SCENE = preload("res://scenes/title.tscn")

# Level Properties
@onready var level = $Level1
@onready var player = $Player
@onready var drone1 = $Drone
@onready var drone2 = $Drone2
@onready var enemies = $Enemies
@onready var extras = $Extras
@onready var powerup_manager = %PowerupManager

# HUD Properties
@onready var hud = $Hud
@onready var game_over_hud = $GameOverHud
@onready var game_over_score_label = $GameOverHud/Control/ScoreLabel
@onready var boss_warning_hud = $BossWarningHud
@onready var warning_label = $BossWarningHud/Control/WarningLabel
@onready var blink_timer = $BossWarningHud/BlinkTimer

# Sound Properties
@onready var intro_stream = $IntroAudioStreamPlayer
@onready var loop_stream = $LoopAudioStreamPlayer
@onready var boss_stream = $BossAudioStreamPlayer
@onready var death_stream = $DeathAudioStreamPlayer
@onready var game_over_stream = $GameOverAudioStreamPlayer


# FUNCTIONS

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level.boss_triggered.connect(approach_boss)
	level.drone_collected.connect(collect_drone)
	level.boss_defeated.connect(did_defeat_boss)
	player.did_die.connect(player_did_die)
	
	level.setup(player, powerup_manager)
	player.setup(powerup_manager)
	
	intro_stream.play()
	intro_stream.finished.connect(_play_bgm_loop)
	
	if intro_stream.stream == null:
		_play_bgm_loop()
	
	await get_tree().create_timer(3.0).timeout
	
	if is_instance_valid(self):
		hud.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# DEBUG: - Debug purposes.
	if level.debug_checkpoint > 0.0:
		hud.update_debug_label(level.position.y)


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
	boss_stream.stop()
	death_stream.play()
	
	await get_tree().create_timer(3.5).timeout
	
	if not is_instance_valid(self):
		return
	
	GameState.update_lives(-1)
	GameState.powerup_count = 0
	
	if GameState.lives >= 0:
		var main := get_parent() as Main
		
		if is_instance_valid(main):
			main.restart_game(self)
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
	
	if is_instance_valid(self):
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


func approach_boss() -> void:
	boss_warning_hud.show()
	
	_fade_out_music(intro_stream, 16.0)
	_fade_out_music(loop_stream, 16.0)
	
	await get_tree().create_timer(3.0).timeout
	if is_instance_valid(self):
		boss_warning_hud.hide()
	
	await get_tree().create_timer(4.0).timeout
	if is_instance_valid(self):
		boss_stream.play()


func did_defeat_boss() -> void:
	boss_stream.stop()


func _fade_out_music(stream_player: AudioStreamPlayer, duration: float) -> void:
	var tween := create_tween()
	tween.tween_property(stream_player, "volume_db", -80.0, duration)
	
	await tween.finished
	stream_player.stop()


func collect_drone() -> void:
	if not drone1.is_unlocked:
		drone1.unlock(Player.TRAIL_LENGTH)
	elif not drone2.is_unlocked:
		drone2.unlock(Player.TRAIL_LENGTH * 2)


func _on_blink_timer_timeout() -> void:
	blink_timer.start()
	warning_label.visible = !warning_label.visible
