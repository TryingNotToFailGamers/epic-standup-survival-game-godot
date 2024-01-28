extends CharacterBody3D

const MAX_SPEED = 280	
const ACCELERATION_SMOOTHING = 12
const  GRAVITY = 10
const  JUMP_POWER = 300

@onready var collition_shape = $CollisionShape3D
@onready var health_component = $HealthComponent
@onready var health_bar = $HealthBar

var number_colliding_bodies = 0

func  _ready():
	pass



func _process(delta):
	var gravity
	var momvement_vector = get_movement_vector()
	var direction = momvement_vector.normalized()
	var target_velocity = direction * MAX_SPEED 
	
	velocity = velocity.lerp(target_velocity, 1 - exp(-delta * ACCELERATION_SMOOTHING))
	
	velocity.y -= GRAVITY
	if is_on_floor() == true:
		velocity.y = 0
	
	jump()
	move_and_slide()
	


func get_movement_vector():
	var x_movement = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	return Vector3(x_movement, 0, 0)


func jump():
	if Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_POWER
		print("just jumped")
		
