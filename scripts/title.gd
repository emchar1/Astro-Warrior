extends Node2D

# PROPERTIES

@onready var high_score = $Labels/HighScore


# FUNCTIONS

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	high_score.text = GameState.get_high_score_str() + " PTS."
