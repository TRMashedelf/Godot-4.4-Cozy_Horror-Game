extends RayCast3D

@onready var colliding_interactable = false

func _physics_process(_delta: float) -> void:
	force_raycast_update()
	
	if is_colliding():
		var colliding_object = get_collider()
		var _collision_point = get_collision_point()
		var colliding_parent = colliding_object.get_parent()
		var colliding_far_parent = colliding_object.get_parent().get_parent()
		var colliding_even_farther_parent = colliding_object.get_parent().get_parent().get_parent()
		
		if colliding_parent.has_method("interact"):
			colliding_interactable = true
		elif colliding_object.has_method("interact"):
			colliding_interactable = true
		elif colliding_far_parent.has_method("interact"):
			colliding_interactable = true
		elif colliding_even_farther_parent.has_method("interact"):
			colliding_interactable = true
		else:
			colliding_interactable = false

func _interact(interaction: String) -> void:
	force_raycast_update()
	
	if is_colliding():
		var colliding_object = get_collider()
		var _collision_point = get_collision_point()
		var colliding_parent = colliding_object.get_parent()
		var colliding_far_parent = colliding_object.get_parent().get_parent()
		var colliding_even_farther_parent = colliding_object.get_parent().get_parent().get_parent()
		
		if colliding_parent.has_method("interact"):
			colliding_parent.interact(interaction)
			print("Interacted with object: ", colliding_object, " parent: ", colliding_parent)
			print("Interaction type of: ", interaction)
		elif colliding_object.has_method("interact"):
			colliding_object.interact(interaction)
			print("Interacted with object: ", colliding_object, " parent: ", colliding_parent)
			print("Interaction type of: ", interaction)
		elif colliding_far_parent.has_method("interact"):
			colliding_far_parent.interact(interaction)
			print("Interacted with object: ", colliding_object, " far parent: ", colliding_far_parent)
			print("Interaction type of: ", interaction)
		elif colliding_even_farther_parent.has_method("interact"):
			colliding_even_farther_parent.interact(interaction)
			print("Interacted with object: ", colliding_object, " far parent: ", colliding_even_farther_parent)
			print("Interaction type of: ", interaction)
