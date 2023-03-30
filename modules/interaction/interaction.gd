extends Area3D

@export var interaction_parent : NodePath

signal interactable_changed(newInteractable)

var interaction_target : Node

func _ready():
	interactable_changed.connect(get_node("/root/Scene/UI/Textbox")._on_interactable_changed)

func _input(event):
	if event.is_action_pressed("ui_select") and interaction_target != null:
		if (interaction_target.has_method("interaction_interact")):
			interaction_target.interaction_interact(self)

func _on_area_entered(area):
	var canInteract := false

	if (area.has_method("interaction_can_interact")):
		canInteract = area.interaction_can_interact(get_node(interaction_parent))
	
	if not canInteract:
		return
		
	if interaction_target != null:
		interaction_target.get_node("Notify").hide()
	
	area.get_node("Notify").show()
	interaction_target = area
	emit_signal("interactable_changed", interaction_target)

func _on_area_exited(area):
	if (area == interaction_target):
		interaction_target.get_node("Notify").hide()
		interaction_target = null
		emit_signal("interactable_changed", null)
