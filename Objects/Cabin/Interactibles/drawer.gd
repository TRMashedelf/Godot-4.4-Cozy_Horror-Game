extends MeshInstance3D

@onready var office_desk = get_parent()
@onready var Is_Open: bool = false

func interact(interaction: String) -> void:
	if interaction == "left_click":
		if office_desk.timer.is_stopped():
			office_desk.timer.start()
			if Is_Open == true:
				Is_Open = false
				office_desk.update(Is_Open, self)
			else:
				Is_Open = true
				office_desk.update(Is_Open, self)
