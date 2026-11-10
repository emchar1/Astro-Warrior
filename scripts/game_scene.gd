extends Node2D

# PROPERTIES

@onready var player = $Player
@onready var intro_stream = $IntroAudioStreamPlayer
@onready var loop_stream = $LoopAudioStreamPlayer
@onready var death_stream = $DeathAudioStreamPlayer


# FUNCTIONS

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.did_die.connect(player_did_die)
	
	intro_stream.play()
	intro_stream.finished.connect(_play_bgm_loop)
	
	if intro_stream.stream == null:
		_play_bgm_loop()


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
	
	await get_tree().create_timer(4.0).timeout
	
	queue_free()
	get_parent().restart_game()
