extends Control

@onready var ui_controller = get_parent()


func _on_resume_button_pressed() -> void:
	ui_controller.close_guis()


func _on_settings_button_pressed() -> void:
	ui_controller.open_settings_gui()


func _on_quit_button_pressed() -> void:
	get_tree().quit()
