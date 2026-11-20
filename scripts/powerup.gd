extends Area2D
class_name Powerup

# PROPERTIES

signal did_collect_drone

enum Type {
	MAIN, TRIPLE, LASER, # Bullet Types
	SPEED, DRONE # Other
}

@onready var anim_sprite = $AnimatedSprite2D
@onready var status_label = $StatusLabel
@onready var audio_stream = $AudioStreamPlayer

var powerup_manager: PowerupManager
var type: Type
var status_tween: Tween
var status_color_tween: Tween
var speed: float = 60.0


# FUNCTIONS

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position.x = GameState.screen_size.x / 2
	status_label.modulate.a = 0.0
	
	if type == null:
		print("Powerup type not set!")
		return
	
	match type:
		Type.TRIPLE:
			anim_sprite.animation = "triple"
		Type.LASER:
			anim_sprite.animation = "laser"
		Type.SPEED:
			anim_sprite.animation = "speed"
		Type.DRONE:
			anim_sprite.animation = "drone"
	
	anim_sprite.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position.y += speed * delta


func show_status(text: String) -> void:
	status_label.text = text
	status_label.position.y = 0
	status_label.modulate.a = 1.0
	
	# Movement Tween
	if status_tween:
		status_tween.kill()
	
	status_tween = create_tween()
	status_tween.tween_property(status_label, "position:y", -10.0, 0.5)
	status_tween.tween_property(status_label, "modulate:a", 0.0, 0.5)
	
	# Color Tween
	var setter = Callable(self, "_set_status_outline_color")
	var _speed := 0.1

	if status_color_tween:
		status_tween.kill()
	
	status_color_tween = create_tween()
	status_color_tween.set_loops()
	status_color_tween.tween_method(setter, Color.MAGENTA, Color.CYAN, _speed)
	status_color_tween.tween_method(setter, Color.CYAN, Color.YELLOW, _speed)
	status_color_tween.tween_method(setter, Color.YELLOW, Color.GREEN, _speed)
	status_color_tween.tween_method(setter, Color.GREEN, Color.MAGENTA, _speed)


func _set_status_outline_color(color: Color) -> void:
	status_label.add_theme_color_override(
		"font_outline_color",
		color.darkened(0.3)
	)


# SIGNAL CALLBACK FUNCTIONS

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		var player = body as Player
		
		if player == null or player.is_dead:
			return
		
		powerup_manager.collect_powerup(type)
		
		match type:
			Powerup.Type.TRIPLE, Powerup.Type.LASER:
				player.update_weapon()
				show_status("WEAPON UP!")
			Powerup.Type.SPEED:
				player.increase_speed()
				show_status("SPEED UP!")
			Powerup.Type.DRONE:
				did_collect_drone.emit()
				show_status("+DRONE!")
		
		audio_stream.play()
		
		# Disable powerup
		speed = 0.0
		anim_sprite.hide()
		set_deferred("monitoring", false)


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	await get_tree().create_timer(3.0).timeout
	
	if is_instance_valid(self):
		queue_free()
