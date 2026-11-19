extends Resource
class_name EnemyConfig

# PROPERTIES

enum Type { 
	FORM_A, FORM_AR, FORM_B, FORM_BR, FORM_C, FORM_CR, # Glider
	FORM_D, FORM_D2, # Pink Ball
	FORM_E, FORM_E2, FORM_E3, # Cross
	FORM_F, FORM_FR, FORM_F2, FORM_F2R, # Blue Ball
	FORM_G, FORM_GR # Tie Fighter
}

enum TypeReadable {
	# Level 1
	GLIDER, PINK_BALL, CROSS, BLUE_BALL, TIE_FIGHTER
}

@export var type: Type
@export var speed: float
@export var score: int


# FUNCTIONS

static func get_type_readable(_type: Type) -> TypeReadable:
	var type_readable: TypeReadable
	
	match _type:
		Type.FORM_A, Type.FORM_AR, \
		Type.FORM_B, Type.FORM_BR, \
		Type.FORM_C, Type.FORM_CR:
			type_readable = TypeReadable.GLIDER
		Type.FORM_D, Type.FORM_D2:
			type_readable = TypeReadable.PINK_BALL
		Type.FORM_E, Type.FORM_E2, Type.FORM_E3:
			type_readable = TypeReadable.CROSS
		Type.FORM_F, Type.FORM_FR, Type.FORM_F2, Type.FORM_F2R:
			type_readable = TypeReadable.BLUE_BALL
		Type.FORM_G, Type.FORM_GR:
			type_readable = TypeReadable.TIE_FIGHTER
	
	return type_readable


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
		Type.FORM_E, Type.FORM_E2, Type.FORM_E3:
			anim_name = "form_e"
		Type.FORM_F, Type.FORM_FR, Type.FORM_F2, Type.FORM_F2R:
			anim_name = "form_f"
		Type.FORM_G, Type.FORM_GR:
			anim_name = "form_g"
	
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
		Type.FORM_E, Type.FORM_E2, Type.FORM_E3:
			scene = load("res://enemy/enemy_cross.tscn")
		Type.FORM_F, Type.FORM_FR, Type.FORM_F2, Type.FORM_F2R:
			scene = load("res://enemy/enemy_blue_ball.tscn")
		Type.FORM_G, Type.FORM_GR:
			scene = load("res://enemy/enemy_tie_fighter.tscn")
	
	return scene
