extends Area3D

signal interaction_interacted(source)

var master_node
var interactionParent

# Called when the node enters the scene tree for the first time.
func _ready():
	master_node = get_parent()
	
	if master_node is CollisionObject3D:
		master_node.input_ray_pickable = false

	for child in master_node.get_children():
		if child is CollisionShape3D:
			$CollisionShape3D.shape = child.shape
	if !is_instance_valid($CollisionShape3D.shape):
		$CollisionShape3D.shape = BoxShape3D.new()
		
	interaction_interacted.connect(get_node("/root/Scene/UI/Textbox")._on_interaction_interacted)
	
	pass # Replace with function body.

	
func interaction_can_interact(interactionComponentParent : Node) -> bool:
	interactionParent = interactionComponentParent
	return interactionComponentParent is CharacterBody3D

func interaction_interact(_interactionComponentParent : Node) -> void:
	emit_signal("interaction_interacted", master_node)


func _on_input_event(_camera, event, _position, _normal, _shape_idx):
	if event is InputEventScreenTouch and event.pressed and $Notify.visible:
		interaction_interact(interactionParent)
