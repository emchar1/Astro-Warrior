extends CharacterBody2D
class_name Boss

# PROPERTIES

signal did_die

const EXPLOSION_SCENE = preload("res://scenes/explosion.tscn")

@onready var hurtboxes = $Hurtboxes

var score: float = 10000
var is_dead: bool = false


# FUNCTIONS

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	_move(delta)
	
	move_and_slide()


func setup() -> void:
	pass


# HELPER FUNCTIONS

func _move(_delta: float) -> void:
	# You should override this function with specific enemy move implementation
	pass


func _die() -> void:
	if is_dead:
		return
	
	is_dead = true
	
	set_collision_layer_value(2, 0)
	#hurtbox.set_deferred("monitoring", false)
	hide()
	did_die.emit()
	
	# MUST come after did_die signal for glider scoring.
	GameState.update_score(score)
	
	# Add explosion
	var explosion = EXPLOSION_SCENE.instantiate() as Explosion
	GameState.add_child_to_game_scene(explosion, "Extras")
	explosion.activate(position, Vector2(4.0, 4.0))


# SIGNAL CALLBACK FUNCTIONS

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	await get_tree().create_timer(1.0).timeout
	
	if is_instance_valid(self):
		queue_free()
