extends Node2D
class_name Main

# PROPERTIES

enum Scene {
	GODOT, TITLE, GAME
}

const TITLE_SCENE = preload("res://scenes/title.tscn")
const GAME_SCENE = preload("res://scenes/game_scene.tscn")

@onready var godot_scene = $Godot
var title_scene: Node2D

var current_scene: Scene


# FUNCTIONS

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_scene = Scene.GODOT
	godot_scene.animation_finished.connect(_transition_to_title)


func _input(event: InputEvent) -> void:
	if current_scene != Scene.TITLE:
		return
	
	if event.is_action_pressed("ui_accept"):
		if title_scene != null:
			var game_scene = GAME_SCENE.instantiate()
			_swap_scene(title_scene, game_scene)
			current_scene = Scene.GAME


# HELPER FUNCTIONS

func _swap_scene(from_scene: Node2D, to_scene: Node2D) -> void:
	from_scene.queue_free()
	await get_tree().process_frame
	add_child(to_scene)


func _transition_to_title() -> void:
	title_scene = TITLE_SCENE.instantiate()
	_swap_scene(godot_scene, title_scene)
	current_scene = Scene.TITLE


func restart_game(old_game: Node2D) -> void:
	old_game.queue_free()
	await get_tree().process_frame
	
	var game_scene = GAME_SCENE.instantiate()
	add_child(game_scene)
