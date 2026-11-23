extends LevelBase

# PROPERTIES

signal credits_did_finish

@onready var coming_soon_control = $CanvasLayer/ComingSoon
@onready var credits_control = $CanvasLayer/Credits
@onready var fade_rect = $CanvasLayer/FadeRect
@onready var coming_soon_label = $CanvasLayer/ComingSoon/ComingSoonLabel
@onready var l2_label = $CanvasLayer/ComingSoon/Level2Label
@onready var blink_timer = $CanvasLayer/Credits/BlinkTimer


# FUNCTIONS

func _ready() -> void:
	super._ready()
	
	await get_tree().create_timer(2.0).timeout
	
	if is_instance_valid(self):
		_show_level2()
	
	await get_tree().create_timer(3.0).timeout
	
	if not is_instance_valid(self):
		return
	
	var scroll_duration := 10.0
	var tween := create_tween()
	tween.set_parallel()
	
	tween.tween_property(
		coming_soon_control,
		"position:y",
		-GameState.screen_size.y,
		scroll_duration
	)
	
	tween.tween_property(
		credits_control,
		"position:y",
		-GameState.screen_size.y,
		2 * scroll_duration
	)
	
	await tween.finished
	
	if is_instance_valid(self):
		credits_did_finish.emit()


func _show_level2() -> void:
	l2_label.show()
	
	var tween := create_tween()
	tween.tween_method(
		func(size: float) -> void:
			l2_label.add_theme_font_size_override("font_size", roundi(size)),
		
		l2_label.get_theme_font_size("font_size"),
		16.0,
		1.0
	)


func fade_to_black(duration: float) -> void:
	var tween := create_tween()
	tween.tween_property(fade_rect, "modulate", Color.BLACK, duration)
	await tween.finished


func _on_blink_timer_timeout() -> void:
	blink_timer.start()
	coming_soon_label.visible = !coming_soon_label.visible
