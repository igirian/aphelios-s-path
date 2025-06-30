extends CharacterBody2D

#XD

const SPEED = 500.0
const JUMP_VELOCITY = -1250.0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


var weapon_rotation = ["severum","calibrum","gravitum","infernum","crescendum"] 
var support_var = 0

# function to swap the weapons in the first slot of the array
func _input(event):
	if event.is_action_pressed("swap_weapon"):
		support_var = weapon_rotation[0]
		weapon_rotation[0] = weapon_rotation[1]
		weapon_rotation[1] = support_var
#change the sprite depending of the main weapon
func _sprite_detect(direction):
	if weapon_rotation[0] == "calibrum":
		#idel_calibrum
		if direction == 0:
			animated_sprite_2d.play("idle_calibrum")   
		else:
			animated_sprite_2d.play("run_calibrum")
	elif weapon_rotation[0] == "severum":
		#idel_severum
		if direction == 0:
			animated_sprite_2d.play("idle_severum")   
		else:
			animated_sprite_2d.play("run_severum")
	elif weapon_rotation[0] == "gravitum":
		#idel_gravitum
		if direction == 0:
			animated_sprite_2d.play("idle_gravitum")   
		else:
			animated_sprite_2d.play("run_gravitum")
	elif weapon_rotation[0] == "infernum":
		#idel_infernum
		if direction == 0:
			animated_sprite_2d.play("idle_infernum")   
		else:
			animated_sprite_2d.play("run_infernum")
	elif weapon_rotation[0] == "crescendum":
		#idel_crescendum
		if direction == 0:
			animated_sprite_2d.play("idle_crescendum")   
		else:
			animated_sprite_2d.play("run_crescendum")
#adds physics & flips the sprite 



func _physics_process(delta: float) -> void:
		
		# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * 0.05

		# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	#	it makes the caracter move, when it moves it gets the values of 1 ,0 ,-1
	var direction := Input.get_axis("move_left", "move_right")
	
	_sprite_detect(direction)
	#it flips the image
	if direction > 0:
		animated_sprite_2d.flip_h = false
	elif direction < 0:
		animated_sprite_2d.flip_h = true


	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
