extends Resource
class_name EnemyConfig

# PROPERTIES

enum Type { 
	FORM_A, FORM_AR, FORM_B, FORM_BR, FORM_C, FORM_CR, # Gliders
	FORM_D, FORM_D2, # Pink Balls
	FORM_E, FORM_E2, # Crosses
	FORM_F, FORM_FR, FORM_F2, FORM_F2R # Blue Balls
}

@export var type: Type
@export var speed: float
@export var score: int


# FUNCTIONS

func get_anim_name() -> String:
	var anim_name: String
	
	match type:
		Type.FORM_A:
			anim_name = "form_a"
		Type.FORM_AR:
			anim_name = "form_ar"
		Type.FORM_B:
			anim_name = "form_b"
		Type.FORM_BR:
			anim_name = "form_br"
		Type.FORM_C:
			anim_name = "form_c"
		Type.FORM_CR:
			anim_name = "form_cr"
		Type.FORM_D, Type.FORM_D2:
			anim_name = "form_d"
		Type.FORM_E, Type.FORM_E2:
			anim_name = "form_e"
		Type.FORM_F, Type.FORM_FR, Type.FORM_F2, Type.FORM_F2R:
			anim_name = "form_f"
	
	return anim_name


func get_scene() -> PackedScene:
	var scene: PackedScene
	
	match type:
		Type.FORM_A, Type.FORM_AR, \
		Type.FORM_B, Type.FORM_BR, \
		Type.FORM_C, Type.FORM_CR:
			scene = load("res://scenes/enemy_glider.tscn")
		Type.FORM_D, Type.FORM_D2:
			scene = load("res://enemy/enemy_pink_ball.tscn")
		Type.FORM_E, Type.FORM_E2:
			scene = load("res://enemy/enemy_cross.tscn")
		Type.FORM_F, Type.FORM_FR, Type.FORM_F2, Type.FORM_F2R:
			scene = load("res://enemy/enemy_blue_ball.tscn")
	
	return scene
