extends CharacterBody2D


class_name entity


@export var name_entity : String 
@export var helth = 100 
@export var speed = 500


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * 0.05
