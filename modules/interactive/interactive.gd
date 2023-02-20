extends Area3D

var master_node

# Called when the node enters the scene tree for the first time.
func _ready():
	var parent = get_parent()
	if parent is StaticBody3D or parent is CharacterBody3D:
		master_node = parent
		for child in parent.get_children():
			if child is CollisionShape3D:
				$CollisionShape3D.shape = child.shape
	if master_node == null:
		master_node = self
		$CollisionShape3D.shape = BoxShape3D.new()
	pass # Replace with function body.

	
func interaction_can_interact(interactionComponentParent : Node) -> bool:
	return interactionComponentParent is CharacterBody3D

func interaction_interact(_interactionComponentParent : Node) -> void:
	print("Interacted with object!")
	master_node.queue_free()
