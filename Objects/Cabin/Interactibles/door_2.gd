extends Node3D

@onready var animPlayer = $AnimationPlayer
@onready var timer = $Timer

@export var Is_Open: bool = true


func interact(interaction: String) -> void:
	if interaction == "left_click":
		if timer.is_stopped():
			timer.start()
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



func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	timer.stop()
