extends CharacterBody2D

# PROPERTIES

@export var speed: float = 80.0

var move_dir: Vector2


# FUNCTIONS

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_read_input()
	_read_movement()
	move_and_slide()


# HELPER FUNCTIONS

func _read_input() -> void:
	move_dir = Input.get_vector(
		"move_left",
		"move_right",
		"move_up",
		"move_down"
	)


func _read_movement() -> void:
	if not _check_bounds(position):
		return
	
	velocity.x = move_dir.x * speed
	velocity.y = move_dir.y * speed


func _check_bounds(pos: Vector2) -> bool:
	if pos.x <= 8 or pos.x >= 248 or pos.y <= 8 or pos.y >= 184:
		return false
	
	return true
