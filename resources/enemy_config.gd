extends Resource
class_name EnemyConfig

# PROPERTIES

enum Type { 
	# LEVEL 1 ENEMIES
	FORM_A, FORM_AR, FORM_B, FORM_BR, FORM_C, FORM_CR, # Glider
	FORM_D, FORM_D2, FORM_D8, FORM_D8R, # Pink Ball
	FORM_E, FORM_E2, FORM_E3, # Cross
	FORM_F, FORM_FR, FORM_F2, FORM_F2R, # Blue Ball
	FORM_G, FORM_GR, # Tie Fighter
	FORM_H, # Pinwheel
	
	# LEVEL 2 ENEMIES
	FORM_I, # Asteroid
	FORM_J # Icicles
}

enum TypeReadable {
	# Level 1
	GLIDER, PINK_BALL, CROSS, BLUE_BALL, TIE_FIGHTER, PINWHEEL,
	
	# LEVEL 2
	ASTEROID, ICICLES
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
		Type.FORM_D, Type.FORM_D2, Type.FORM_D8, Type.FORM_D8R:
			type_readable = TypeReadable.PINK_BALL
		Type.FORM_E, Type.FORM_E2, Type.FORM_E3:
			type_readable = TypeReadable.CROSS
		Type.FORM_F, Type.FORM_FR, Type.FORM_F2, Type.FORM_F2R:
			type_readable = TypeReadable.BLUE_BALL
		Type.FORM_G, Type.FORM_GR:
			type_readable = TypeReadable.TIE_FIGHTER
		Type.FORM_H:
			type_readable = TypeReadable.PINWHEEL
		Type.FORM_I:
			type_readable = TypeReadable.ASTEROID
		Type.FORM_J:
			type_readable = TypeReadable.ICICLES
	
	return type_readable


static func get_anim_name(_type: Type) -> String:
	var anim_name: String
	
	match _type:
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
		Type.FORM_D, Type.FORM_D2, Type.FORM_D8, Type.FORM_D8R:
			anim_name = "form_d"
		Type.FORM_E, Type.FORM_E2, Type.FORM_E3:
			anim_name = "form_e"
		Type.FORM_F, Type.FORM_FR, Type.FORM_F2, Type.FORM_F2R:
			anim_name = "form_f"
		Type.FORM_G, Type.FORM_GR:
			anim_name = "form_g"
		Type.FORM_H:
			anim_name = "form_h"
		Type.FORM_I:
			anim_name = "form_i"
		Type.FORM_J:
			anim_name = "form_j"
	
	return anim_name
