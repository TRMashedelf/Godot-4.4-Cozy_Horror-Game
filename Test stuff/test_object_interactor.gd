extends MeshInstance3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



func interact(interaction: String) -> void:
	if interaction == "left_click":
		queue_free()
	elif interaction == "right_click":
		print("GG")
	elif interaction == "scroll_up":
		position.y += 0.05
	elif interaction == "scroll_down":
		position.y -= 0.05
