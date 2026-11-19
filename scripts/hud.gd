extends CanvasLayer

# PROPERTIES

@onready var score_label = $VBoxContainer/ScoreLabel
@onready var lives_label = $VBoxContainer/LivesLabel


# FUNCTIONS

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameState.did_update_score.connect(_update_score)
	GameState.did_update_lives.connect(_update_lives)
	
	_update_score(GameState.score)
	_update_lives(GameState.lives)


func _update_score(_total_score: int) -> void:
	score_label.text = GameState.get_score_str()


func _update_lives(total_lives: int) -> void:
	lives_label.text = str(" x ", total_lives)
