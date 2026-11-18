extends Area2D
class_name Powerup

# PROPERTIES

enum Type {
	MAIN, TRIPLE, LASER, # Bullet Types
	SPEED, DRONE # Other
}

@onready var anim_sprite = $AnimatedSprite2D
@onready var audio_stream = $AudioStreamPlayer

var powerup_manager: PowerupManager
var type: Type
var speed: float = 60.0


# FUNCTIONS

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position.x = GameState.screen_size.x / 2
	
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
func _process(delta: float) -> void:
	position.y += speed * delta


# SIGNAL CALLBACK FUNCTIONS

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		var player = body as Player
		
		if player == null:
			return
		
		powerup_manager.collect_powerup(type)
		
		match type:
			Powerup.Type.TRIPLE, Powerup.Type.LASER:
				player.update_weapon()
			Powerup.Type.SPEED:
				player.increase_speed()
			Powerup.Type.DRONE:
				# TODO: - Make Drones
				pass
		
		audio_stream.play()
		
		# Disable powerup
		hide()
		set_deferred("monitoring", false)


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	await get_tree().create_timer(3.0).timeout
	queue_free()
