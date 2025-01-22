extends Marker2D

@onready var lockpicking_ui: Control = $"../.."
var sens = .01
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
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
