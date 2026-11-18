extends CanvasLayer

# PROPERTIES

@onready var score_label = $VBoxContainer/ScoreLabel
@onready var lives_label = $VBoxContainer/LivesLabel


# FUNCTIONS

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameState.did_update_score.connect(_update_score)


func _update_score(new_score: int) -> void:
	score_label.text = str(new_score)
