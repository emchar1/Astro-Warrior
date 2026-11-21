extends Resource
class_name BossConfig

# PROPERTIES

enum Type {
	ZANONI, NEBIROS, BELZEBUL
}

@export var type: Type
@export var speed: float
@export var score: int
