extends Node2D

# PROPERTIES

const GAME_SCENE = preload("res://scenes/game_scene.tscn")

@onready var title_scene = $Title


# FUNCTIONS

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") and title_scene != null:
		var game_scene = GAME_SCENE.instantiate()
		_swap_scene(title_scene, game_scene)


# HELPER FUNCTIONS

func _swap_scene(from_scene: Node2D, to_scene: Node2D) -> void:
	from_scene.queue_free()
	await get_tree().process_frame
	add_child(to_scene)


func restart_game(old_game: Node2D) -> void:
	old_game.queue_free()
	await get_tree().process_frame
	
	var game_scene = GAME_SCENE.instantiate()
	add_child(game_scene)
