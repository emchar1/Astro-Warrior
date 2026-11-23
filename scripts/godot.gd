extends Node2D

# PROPERTIES

signal animation_finished

@onready var g_label = $Control/GLabel
@onready var o_label = $Control/OLabel
@onready var d_label = $Control/DLabel
@onready var o_label2 = $Control/OLabel2
@onready var t_label = $Control/TLabel

@onready var g_rect = $Control/GLabel/GRect
@onready var o_rect = $Control/OLabel/ORect
@onready var d_rect = $Control/DLabel/DRect
@onready var o_rect2 = $Control/OLabel2/ORect2
@onready var t_rect = $Control/TLabel/TRect

@onready var master_system = $Control/MasterSystemLabel
@onready var audio_stream = $AudioStreamPlayer


# FUNCTIONS

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play_animation()
	audio_stream.play()
	
	await get_tree().create_timer(5.0).timeout
	
	if is_instance_valid(self):
		animation_finished.emit()


func play_animation() -> void:
	_move_letter(g_label, g_rect)
	_move_letter(o_label, o_rect)
	_move_letter(d_label, d_rect)
	_move_letter(o_label2, o_rect2)
	_move_letter(t_label, t_rect)
	
	await get_tree().create_timer(1.33).timeout
	
	if is_instance_valid(self):
		master_system.show()


func _move_letter(label: Node, rect: Node) -> void:
	var tween := create_tween()
	tween.set_parallel()
	tween.tween_property(label, "position:x", label.position.x + 23.0, 0.674)
	tween.tween_property(rect, "position:x", rect.position.x - 23.0, 0.674)
