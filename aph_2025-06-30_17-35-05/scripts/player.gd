extends CharacterBody2D



const SPEED = 500.0
const JUMP_VELOCITY = -1250.0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var weapon_rotation = ["severum","calibrum","gravitum","infernum","crescendum"] 
var support_var = 0
var severum_durability:int = 5
var calibrum_durability:int = 5 
var gravitum_durability:int = 5 
var infernum_durability:int = 5 
var crescendum_durability:int = 5
#rotation after weapon is consumed
func _rotation():
	support_var = weapon_rotation[0]
	var i=0
	while i<4 :
		weapon_rotation[i] = weapon_rotation[i+1]
		i=i+1
	weapon_rotation[4] = support_var
# function to swap the weapons in the first slot of the array
func swap_weapons():
	
	support_var = weapon_rotation[0]
	weapon_rotation[0] = weapon_rotation[1]
	weapon_rotation[1] = support_var
	print(weapon_rotation[0])
#all is_action_pressed have to here
func _input(event):
	if event.is_action_pressed("swap_weapon"):
		swap_weapons()
	if event.is_action_pressed("shoot"):
		shoot()
		print(weapon_rotation)
#shoots upon pressing E
func shoot():
	print("shoot")
	if weapon_rotation[0] == "calibrum":
		calibrum_durability -= 1
		if calibrum_durability == 0:
			_rotation()
			calibrum_durability = 5
	elif weapon_rotation[0] == "severum":
		severum_durability -= 1
		if severum_durability == 0:
			_rotation()
			severum_durability = 5
	elif weapon_rotation[0] == "gravitum":
		gravitum_durability -= 1
		if gravitum_durability == 0:
			_rotation()
			gravitum_durability = 5
	elif weapon_rotation[0] == "infernum":
		infernum_durability -= 1
		if infernum_durability == 0:
			_rotation()
			infernum_durability = 5
	elif weapon_rotation[0] == "crescendum":
		crescendum_durability -= 1
		if crescendum_durability == 0:
			_rotation()
			crescendum_durability = 5
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
