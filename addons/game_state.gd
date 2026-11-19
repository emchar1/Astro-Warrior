extends Node

# PROPERTIES

const STARTING_LIVES = 2
const EXTRA_LIVES_SFX = preload("res://assets/sounds/unused.ogg")

signal did_update_score(total_score: int)
signal did_update_lives(total_lives: int)

var audio_stream: AudioStreamPlayer
var screen_size: Vector2

var high_score: int = 0
var score: int = 0
var lives: int = STARTING_LIVES
var powerup_count: int = 0


# FUNCTIONS

func _ready() -> void:
	screen_size = get_viewport().get_visible_rect().size
	
	audio_stream = AudioStreamPlayer.new()
	audio_stream.stream = EXTRA_LIVES_SFX
	add_child(audio_stream)


func add_child_to_game_scene(node: Node, node_name: String) -> void:
	var main_scene := get_tree().current_scene
	var game_scene_node := main_scene.get_node_or_null("GameScene/" + node_name)
	
	if game_scene_node == null:
		print("Node name: ", node_name, " does not exist.")
		return
	
	game_scene_node.add_child(node)


func get_high_score_str() -> String:
	return str(high_score).pad_zeros(6)


func get_score_str() -> String:
	return str(score).pad_zeros(6)


func update_score(score_to_add: int) -> void:
	# Execute this BEFORE updating score
	_reward_lives(score_to_add)
	
	score += score_to_add
	
	if score > high_score:
		high_score = score
	
	did_update_score.emit(score)


func _reward_lives(score_to_add: int) -> void:
	if (
		score < 50000 and score + score_to_add >= 50000
		or score < 100000 and score + score_to_add >= 100000
		or score < 150000 and score + score_to_add >= 150000
		or score < 200000 and score + score_to_add >= 200000
		or score < 250000 and score + score_to_add >= 250000
		or score < 300000 and score + score_to_add >= 300000
		or score < 350000 and score + score_to_add >= 350000
	):
		update_lives(1)
		audio_stream.play()


func update_lives(lives_to_add: int) -> void:
	lives += lives_to_add
	did_update_lives.emit(lives)


func reset_all() -> void:
	score = 0
	lives = STARTING_LIVES
	powerup_count = 0
