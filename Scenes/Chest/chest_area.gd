extends Area3D

@export var lockpick_ui: Control
var interactable = false

func _process(_delta: float) -> void:
	if interactable and Input.is_action_just_pressed("interact"):
		lockpick_ui.visible = !lockpick_ui.visible
		get_tree().get_first_node_in_group("Player").state = !get_tree().get_first_node_in_group("Player").state

func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		interactable = true

func _on_body_exited(body: Node3D) -> void:
	if body is Player:
		lockpick_ui.visible = false
		interactable = false
