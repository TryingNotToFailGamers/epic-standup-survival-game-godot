extends CharacterBody3D

const MAX_SPEED = 400	
const ACCELERATION_SMOOTHING_FOR_MOVEMENT = 13
const ACCELERATION_SMOOTHING_FOR_DASH = 30
const  GRAVITY = 80
const  JUMP_POWER = 1200
const DASH_POWER = 15000

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
	
	velocity = velocity.lerp(target_velocity, 1 - exp(-delta * ACCELERATION_SMOOTHING_FOR_MOVEMENT))
	
	velocity.y -= GRAVITY
	if is_on_floor() == true:
		velocity.y = 0
	
	jump()
	dash(delta)
	move_and_slide()
	


func get_movement_vector():
	var x_movement = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	return Vector3(x_movement, 0, 0)


func jump(): 
	if Input.is_action_just_pressed("jump") and velocity.y == 0:
		velocity.y = JUMP_POWER
		print("just jumped")


func dash(delta):
	var dash_direction
	if Input.is_action_just_pressed("dash") and velocity.y == 0:
		if Input.is_action_pressed("move_right"):
			dash_left(delta, Vector3.LEFT)
	
		elif Input.is_action_pressed("move_left"):
			dash_left(delta, Vector3.RIGHT)


func dash_left(delta, dash_direction: Vector3):
	velocity = velocity.lerp(dash_direction * JUMP_POWER, - exp(-delta * ACCELERATION_SMOOTHING_FOR_DASH))
	print("just dashed")
	print(velocity)

func dash_right(delta, dash_direction: Vector3):
	velocity = velocity.lerp(dash_direction * JUMP_POWER, - exp(-delta * ACCELERATION_SMOOTHING_FOR_DASH))
	print("just dashed")
	print(velocity)
