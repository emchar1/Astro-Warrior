extends Node2D

# PROPERTIES

const STAR = preload("res://scenes/star.tscn")

@export var density: int = 400
@export var colors: Array[Color] = [
	Color(0.25, 0.75, 1.0, 1.0),
	Color(0.0, 0.35, 1.0, 1.0),
	Color(0.75, 0.75, 1.0, 1.0),
	Color(0.35, 0.35, 1.0, 1.0)
]
@export var twinkle_speed: float = 1.0
@export var height: float = 1920.0


# FUNCTIONS

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in colors.size():
		_generate_stars(colors[i], i * 0.5)


func _generate_stars(star_color: Color, starting_visibility: float) -> void:
	var star_positions: Array[Vector2] = []
	var loop_count: int = 0
	
	for i in range(density):
		var proposed_position: Vector2 = Vector2(
			randf_range(0, GameState.screen_size.x),
			randf_range(GameState.screen_size.y, -height)
		)
		
		while not _is_far_enough_away(proposed_position, star_positions, 10):
			proposed_position = Vector2(
				randf_range(0, GameState.screen_size.x),
				randf_range(GameState.screen_size.y, -height)
			)
			
			loop_count += 1
			
			if loop_count > density:
				break
		
		var star = STAR.instantiate()
		star.star_color = star_color
		star.twinkle_speed = twinkle_speed
		star.starting_visibility = starting_visibility
		star.position = proposed_position
		add_child(star)
		
		star_positions.append(proposed_position)


func _is_far_enough_away(
	proposed_position: Vector2,
	star_positions: Array[Vector2],
	min_distance: float
) -> bool:
	for star_position in star_positions:
		if proposed_position.distance_to(star_position) < min_distance:
			return false
	
	return true
