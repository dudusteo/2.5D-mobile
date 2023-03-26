extends Area3D

var master_node

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
	pass # Replace with function body.

	
func interaction_can_interact(interactionComponentParent : Node) -> bool:
	return interactionComponentParent is CharacterBody3D

func interaction_interact(_interactionComponentParent : Node) -> void:
	print("Interacted with object!")
	master_node.queue_free()


func _on_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton:
		print("mouse", self)
