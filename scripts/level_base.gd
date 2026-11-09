extends Node2D

# PROPERTIES

const ENEMY_SCENE = preload("res://enemy/enemy.tscn")

@export var scroll_speed: float = 200.0

var spawn_form_a: bool = false
var spawn_form_b: bool = false


# FUNCTIONS

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_scroll_level(delta)
	_spawn_enemies()


func _scroll_level(delta: float) -> void:
	position.y += delta * scroll_speed


func _spawn_enemies() -> void:
	if position.y >= 100:
		if not spawn_form_a:
			spawn_form_a = true
			
			for i in range(6):
				var enemy = ENEMY_SCENE.instantiate()
				get_tree().current_scene.add_child(enemy)
				
				enemy.setup(Enemy.Type.FORM_A)
				enemy.position = Vector2(GameState.screen_size.x / 2, 0)
				await get_tree().create_timer(0.2).timeout
	
	if position.y >= 150:
		if not spawn_form_b:
			spawn_form_b = true
			
			for i in range(6):
				var enemy = ENEMY_SCENE.instantiate()
				get_tree().current_scene.add_child(enemy)
				
				enemy.setup(Enemy.Type.FORM_B)
				enemy.position = Vector2(GameState.screen_size.x / 2, 0)
				await get_tree().create_timer(0.2).timeout
