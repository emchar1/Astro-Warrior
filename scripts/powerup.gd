extends Area2D
class_name Powerup

# PROPERTIES

enum Type {
	SPEED, TRIPLE, LASER, DRONE
}

const INCREMENT = 12

@onready var anim_sprite = $AnimatedSprite2D
@onready var audio_stream = $AudioStreamPlayer

var current_type: Type = Type.SPEED
var speed: float = 60.0


# FUNCTIONS

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position.x = GameState.screen_size.x / 2
	
	match current_type:
		Type.SPEED:
			anim_sprite.animation = "speed"
		Type.TRIPLE:
			anim_sprite.animation = "triple"
		Type.LASER:
			anim_sprite.animation = "laser"
		Type.DRONE:
			anim_sprite.animation = "drone"
	
	anim_sprite.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += speed * delta


# SIGNAL CALLBACK FUNCTIONS

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if current_type == Type.TRIPLE or current_type == Type.LASER:
			var powerup_level: Bullet.Type
			
			match current_type:
				Type.TRIPLE:
					powerup_level = Bullet.Type.TRIPLE
				Type.LASER:
					powerup_level = Bullet.Type.LASER
			
			body.increase_level(powerup_level)
		elif current_type == Type.SPEED:
			body.increase_speed()
		
		audio_stream.play()
		
		# Disable powerup
		hide()
		set_deferred("monitoring", false)


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	await get_tree().create_timer(3.0).timeout
	queue_free()
