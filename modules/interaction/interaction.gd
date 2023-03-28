extends Area3D

@export var interaction_parent : NodePath

signal interactable_changed(newInteractable)

var interaction_target : Node

# Called when the node enters the scene tree for the first time.
func _ready():
	interactable_changed.connect(get_node("/root/Scene/UI/Textbox")._on_interactable_changed)
	
	pass # Replace with function body.


# Called every frame
func _process(_delta):
	# Check whether the player is trying to interact
	if (interaction_target != null and Input.is_action_just_pressed("ui_accept")):
		# If so, we'll call interaction_interact() if our target supports it
		if (interaction_target.has_method("interaction_interact")):
			interaction_target.interaction_interact(self)

func _on_area_entered(area):
	var canInteract := false
	
	# GDScript lacks the concept of interfaces, so we can't check whether the body implements an interface
	# Instead, we'll see if it has the methods we need
	if (area.has_method("interaction_can_interact")):
		# Interactables tell us whether we're allowed to interact with them.
		canInteract = area.interaction_can_interact(get_node(interaction_parent))
	
	if not canInteract:
		return
		
	if interaction_target != null:
		interaction_target.get_node("Notify").hide()
	
	# Store the thing we'll be interacting with, so we can trigger it from _process
	area.get_node("Notify").show()
	interaction_target = area
	emit_signal("interactable_changed", interaction_target)


func _on_area_exited(area):
	if (area == interaction_target):
		interaction_target.get_node("Notify").hide()
		interaction_target = null
		emit_signal("interactable_changed", null)
