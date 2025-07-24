extends Control

@onready var ui_controller = get_parent()
@onready var version_label = $CenterContainer/MarginContainer/Panel/MarginContainer/VBoxContainer/Version_Label

func _ready():
	version_label.text = "v" + ProjectSettings.get_setting("application/config/version")


func _on_resume_button_pressed() -> void:
	ui_controller.close_guis()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _on_settings_button_pressed() -> void:
	ui_controller.open_settings_gui()


func _on_quit_button_pressed() -> void:
	get_tree().quit()
