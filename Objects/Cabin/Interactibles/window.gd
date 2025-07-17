extends Node3D

@onready var animPlayer = $AnimationPlayer

@export var Is_Open: bool

func _ready():
	update(Is_Open)

func interact(interaction: String) -> void:
	if interaction == "left_click":
		if Is_Open == true:
			Is_Open = false
			update(Is_Open)
		else:
			Is_Open = true
			update(Is_Open)

func update(On_off: bool):
	if On_off == true:
		animPlayer.play("Open")
	else:
		animPlayer.play("Close")
