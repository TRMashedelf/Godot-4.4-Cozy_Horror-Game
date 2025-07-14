extends Node3D

@export var Is_On := true
@export var Target := Node3D
@export var Energy := 2.0

@onready var animPlayer = $AnimationPlayer

func _ready():
	update(true)


func interact(interaction: String) -> void:
	if interaction == "left_click":
		if Is_On == true:
			Is_On = false
			update(false)
		else:
			Is_On = true
			update(true)

func update(On_off: bool):
	if Target:
		if On_off == true:
			Target.light_energy = Energy
			animPlayer.play("switch_on")
		else:
			Target.light_energy = 0.0
			animPlayer.play("switch_off")
			
	
