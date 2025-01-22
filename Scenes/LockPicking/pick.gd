extends Marker2D

@onready var lockpicking_ui: Control = $"../.."
var rng = RandomNumberGenerator.new()
var target_rotation_set = false

var sens = .01
var target_rotation = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if lockpicking_ui.visible == true and target_rotation_set == false:
		target_rotation = rng.randf_range(deg_to_rad(-90), deg_to_rad(90))
		target_rotation_set = true
	elif lockpicking_ui.visible == false:
		target_rotation_set = false
	pass
func _input(event) -> void:
	if !Input.is_action_pressed("lockpickRotate"):
		if event is InputEventMouseMotion and lockpicking_ui.visible == true:
			#rotates pick based on mouse movements
			rotate(event.relative.x * sens)
			rotation = clamp(rotation, deg_to_rad(-90), deg_to_rad(90))
		else:
			pass
	else:
		pass
