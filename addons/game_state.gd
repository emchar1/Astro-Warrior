extends Node

# PROPERTIES

var screen_size: Vector2
var score: int
var lives: int = 2


# FUNCTIONS

func _ready() -> void:
	screen_size = get_viewport().get_visible_rect().size


func add_child_to_game_scene(node: Node, node_name: String) -> void:
	var main_scene := get_tree().current_scene
	var game_scene_node := main_scene.get_node_or_null("GameScene/" + node_name)
	
	if game_scene_node == null:
		print("Node name: ", node_name, " does not exist.")
		return
	
	game_scene_node.add_child(node)
