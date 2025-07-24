extends Node3D


@onready var animPlayer = $AnimationPlayer
@onready var timer = $Timer

@export var Is_Open: bool
@export var invert: bool



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
		if invert == false:
			animPlayer.play("Open")
		else:
			animPlayer.play("Open_invert")
	else:
		if invert == false:
			animPlayer.play("Close")
		else:
			animPlayer.play("Close_invert")


func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	timer.stop()
