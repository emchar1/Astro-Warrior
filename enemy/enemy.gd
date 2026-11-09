extends CharacterBody2D
class_name Enemy

# PROPERTIES

enum Type { 
	FORM_A, FORM_B
}

@onready var anim_sprite = $AnimatedSprite2D

var type: Type
var speed: float
var elapsed_time: float = 0.0


# FUNCTIONS

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_move(delta)
	
	move_and_slide()


func setup(_type: Type) -> void:
	type = _type
	
	match type:
		Type.FORM_A:
			anim_sprite.animation = "formation_a"
			speed = 60.0
		Type.FORM_B:
			anim_sprite.animation = "formation_b"
			speed = 60.0
	
	anim_sprite.play()


func _move(delta: float) -> void:
	var pivot: float = 30.0
	var speed_coefficient: float = 30.0
	
	elapsed_time += delta
	
	match type:
		Type.FORM_A:
			velocity.y = speed
			
			if position.y > pivot:
				velocity.x = -speed_coefficient * pow(elapsed_time, 2)
		Type.FORM_B:
			velocity.y = speed
			
			if position.y > pivot:
				velocity.x = speed_coefficient * pow(elapsed_time, 2)


func _die() -> void:
	queue_free()


# SIGNAL FUNCTIONS

func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullet"):
		if area is Bullet:
			area.die()
		
		_die()
