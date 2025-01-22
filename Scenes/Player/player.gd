extends CharacterBody3D
class_name Player


@export var camera: Marker3D
var state = true
#movement variables
var speed = 0
var MAX_SPEED = 10
const ACCEL = 20
const MAX_GRAVITY= 500
#gravity variables
var gravity = 0
const GRAV_ACCEL_UP = 65
const GRAV_ACCEL_DOWN = 100 
var jump_force = -20

var sens = .0025

var new_mouse_pos = Vector2.ZERO

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta: float) -> void:
	
	if Input.is_action_just_pressed("esc"):
		get_tree().quit()
	if state:
		jump(delta)
		var dir = Vector2.ZERO
		#get that movement vector anf nomalize it
		dir.x = Input.get_action_strength("right") - Input.get_action_strength("left")
		dir.y =  Input.get_action_strength("backward") - Input.get_action_strength("forward")
		dir = dir.normalized()
		#makes speed build up over time as opposed to being full strength all the time
		if dir != Vector2.ZERO and speed < MAX_SPEED:
			speed += ACCEL * delta
		elif speed >= MAX_SPEED:
			speed = MAX_SPEED #stops speed from getting too strong
		else:
			speed = 0
		#.x and .y are used as oppesed to a vec3 and dir is a vec2
		velocity = global_basis * Vector3(dir.x, 0, dir.y) * speed
	else:
		velocity = Vector3.ZERO
	move_and_slide()

func jump(delta):
	#makes gravity stronger as time goes on
	if not is_on_floor() and gravity < MAX_GRAVITY and velocity.y < 0:
		gravity += GRAV_ACCEL_DOWN * delta #gravity is stronger when going down
	elif not is_on_floor() and gravity < MAX_GRAVITY and velocity.y >= 0:
		gravity += GRAV_ACCEL_UP * delta #gravity is weaker when going up (like after jumping)
	elif gravity >= MAX_GRAVITY:
		gravity = MAX_GRAVITY #stops gravity from getting too strong
	elif is_on_floor():
		gravity = 0
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		speed = speed / 2 #makes movement slower in air
		gravity = jump_force
	#position is used instead of velocity for no real reason
	position.y -= gravity * delta 
#mmmm camera
func _input(event) -> void:
	if event is InputEventMouseMotion and state:
		rotate_object_local(Vector3.UP, event.relative.x * -sens)
		camera.rotate_x(event.relative.y * -sens)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-45), deg_to_rad(25))
		
