extends Marker2D
@onready var lockpicking_ui: Control = $".."
@export var pick : Marker2D
#how difficult lock is to pick higher the number, the easier
var difficulty = 5
#how soon the lock will bigin to rotate even if it pick placement is incorrect
var start_rotation = .5 #bigger the number the more exact your pick placment needs to be before the lock will rotate

func _process(delta: float) -> void:
	#allows for picking even if pick placment isn't exact(increase number to decrease difficulty and vise versa)
	var upper_limit = pick.target_rotation + deg_to_rad(difficulty)
	var lower_limit = pick.target_rotation - deg_to_rad(difficulty)
	print(pick.target_rotation)
	var rotation_diff = pick.rotation / pick.target_rotation
	var max_lock_rotation
	#get difference between pick location and where the pick needs to be
	#allows for the lock to rotate even if pick isn't placed correctly
	if rotation_diff > 1:
		rotation_diff = pick.target_rotation / pick.rotation
	else: #swaps the fraction so rotation_diff is always < 1
		rotation_diff = pick.rotation / pick.target_rotation
	#how far the lock can rotate is based on above eqautions
	max_lock_rotation = rotation_diff * 90
	
	if pick.rotation > lower_limit and pick.rotation < upper_limit:
		#max lock rotation overridden so lock can be picked it placement of pick is within range
		max_lock_rotation = 100
	if Input.is_action_pressed("lockpickRotate") != true:
		#resets override 
		max_lock_rotation = rotation_diff * 90
	else:
		pass

	if Input.is_action_pressed("lockpickRotate") and lockpicking_ui.visible == true:
		if rotation_diff > start_rotation and rotation <= deg_to_rad(max_lock_rotation):
			rotation += delta * 1 
			#pick.rotation -= delta * 1 <-- boroke the code, if you can make it work then epic! it will improve asethetics
		elif rotation >= deg_to_rad(90):
			print("unlocked!")
			lockpicking_ui.visible = false
			get_tree().get_first_node_in_group("Player").state = !get_tree().get_first_node_in_group("Player").state
		else:
			pass
	elif lockpicking_ui.visible == true:
		#resets lock rotation when wasd is no longer being pressed
		if rotation > 0:
			rotation -= delta * 3
			pick.rotation = 0
		else:
			pass
	else:
		#resets lock rotation when menu is exited
		rotation = 0
		pick.rotation = 0
		pass
	
