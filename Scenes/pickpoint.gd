extends Marker2D
@onready var lockpicking_ui: Control = $"../../.."
var rng = RandomNumberGenerator.new
var number_set = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if lockpicking_ui.visible == true:
		#makes it so code only runs once
		if number_set != true:
			var Lock_pick_success_rot = randf_range(-85, 85)
			rotation = deg_to_rad(Lock_pick_success_rot)
			number_set = true
		else:
			pass
	else:
		number_set = false
		pass
