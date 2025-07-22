extends Node3D

@onready var animPlayer = $AnimationPlayer
@onready var timer = $Timer
@onready var Drawer = $Drawer
@onready var Drawer1 = $Drawer_001
@onready var Drawer2 = $Drawer_002
@onready var Drawer3 = $Drawer_003



func _ready():
	update(Drawer.Is_Open, Drawer)
	update(Drawer1.Is_Open, Drawer1)
	update(Drawer2.Is_Open, Drawer2)
	update(Drawer3.Is_Open, Drawer3)


func update(On_off: bool, Target: Node3D):
	if On_off == true:
		if Target == $Drawer:
			animPlayer.play("Open")
		elif Target == $Drawer_001:
			animPlayer.play("Open_1")
		elif Target == $Drawer_002:
			animPlayer.play("Open_2")
		elif Target == $Drawer_003:
			animPlayer.play("Open_3")
	else:
		if Target == $Drawer:
			animPlayer.play("Close")
		elif Target == $Drawer_001:
			animPlayer.play("Close_1")
		elif Target == $Drawer_002:
			animPlayer.play("Close_2")
		elif Target == $Drawer_003:
			animPlayer.play("Close_3")


func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	timer.stop()
