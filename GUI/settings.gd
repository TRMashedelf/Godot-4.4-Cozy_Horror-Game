extends Control

@onready var window_mode = $"CenterContainer/MarginContainer/VBoxContainer/TabContainer/Graphics/Window mode/WindowMode_option"
@onready var window_resolution = $CenterContainer/MarginContainer/VBoxContainer/TabContainer/Graphics/HBoxContainer/Resolution_option
@onready var fov = $CenterContainer/MarginContainer/VBoxContainer/TabContainer/Graphics/Fov/FOV_slider
@onready var fov_label = $CenterContainer/MarginContainer/VBoxContainer/TabContainer/Graphics/Fov/FOV_Label


@onready var master = $CenterContainer/MarginContainer/VBoxContainer/TabContainer/Audio/Master/Master_Slider
@onready var master_label = $CenterContainer/MarginContainer/VBoxContainer/TabContainer/Audio/Master/Master_label
@onready var sfx = $CenterContainer/MarginContainer/VBoxContainer/TabContainer/Audio/SFX/SFX_Slider
@onready var sfx_label = $CenterContainer/MarginContainer/VBoxContainer/TabContainer/Audio/SFX/SFX_label
@onready var ambient = $CenterContainer/MarginContainer/VBoxContainer/TabContainer/Audio/Ambient/Ambient_Slider
@onready var ambient_label = $CenterContainer/MarginContainer/VBoxContainer/TabContainer/Audio/Ambient/Ambient_label
@onready var music = $CenterContainer/MarginContainer/VBoxContainer/TabContainer/Audio/Music/Music_Slider
@onready var music_label = $CenterContainer/MarginContainer/VBoxContainer/TabContainer/Audio/Music/Music_label

@onready var mouse_sensitivity = $"CenterContainer/MarginContainer/VBoxContainer/TabContainer/Controls/Mouse Sensitivity/MouseSensitivity_Slider"

func _ready() -> void:
	if Globals.window_type == "windowed":
		window_mode.select(0)
	elif Globals.window_type == "fullscreen":
		window_mode.select(1)
	elif Globals.window_type == "borderless":
		window_mode.select(2)
	
	if Globals.window_resolution == "1920x1080":
		window_resolution.select(0)
	elif Globals.window_resolution == "1792x1008":
		window_resolution.select(1)
	elif Globals.window_resolution == "1664x936":
		window_resolution.select(2)
	elif Globals.window_resolution == "1536x864":
		window_resolution.select(3)
	elif Globals.window_resolution == "1408x792":
		window_resolution.select(4)
	elif Globals.window_resolution == "1280x720":
		window_resolution.select(5)
	elif Globals.window_resolution == "1152x648":
		window_resolution.select(6)
	elif Globals.window_resolution == "1024x567":
		window_resolution.select(7)
	elif Globals.window_resolution == "896x504":
		window_resolution.select(8)
	elif Globals.window_resolution == "768x432":
		window_resolution.select(9)
	elif Globals.window_resolution == "640x360":
		window_resolution.select(10)
	
	fov.set_value_no_signal(Globals.player_FOV)
	fov_label.text = str(int(Globals.player_FOV))
	
	master.set_value_no_signal(Globals.audio_masterVolume)
	sfx.set_value_no_signal(Globals.audio_SFXVolume)
	ambient.set_value_no_signal(Globals.audio_ambientVolume)
	music.set_value_no_signal(Globals.audio_musicVolume)
	master_label.text = str(Globals.audio_masterVolume)
	sfx_label.text = str(Globals.audio_SFXVolume)
	ambient_label.text = str(Globals.audio_ambientVolume)
	music_label.text = str(Globals.audio_musicVolume)
	
	mouse_sensitivity.set_value_no_signal(Globals.player_mouseSensitivity)



func _on_mouse_sensitivity_slider_value_changed(value: float) -> void:
	Globals.player_mouseSensitivity = value


func _on_music_slider_value_changed(value: float) -> void:
	Globals.audio_musicVolume = int(value)
	music_label.text = str(int(value))


func _on_ambient_slider_value_changed(value: float) -> void:
	Globals.audio_ambientVolume = int(value)
	ambient_label.text = str(int(value))


func _on_sfx_slider_value_changed(value: float) -> void:
	Globals.audio_SFXVolume = int(value)
	sfx_label.text = str(int(value))


func _on_master_slider_value_changed(value: float) -> void:
	Globals.audio_masterVolume = int(value)
	master_label.text = str(int(value))


func _on_window_mode_option_item_selected(index: int) -> void:
	if index == 0:
		Globals.window_type = "windowed"
	elif index == 1:
		Globals.window_type = "fullscreen"
	elif index == 2:
		Globals.window_type = "borderless"
	Globals.save_settings()
	Globals.apply_settings()


func _on_resolution_option_item_selected(index: int) -> void:
	if index == 0:
		Globals.window_resolution = "1920x1080"
	elif index == 1:
		Globals.window_resolution = "1792x1008"
	elif index == 2:
		Globals.window_resolution = "1664x936"
	elif index == 3:
		Globals.window_resolution = "1536x864"
	elif index == 4:
		Globals.window_resolution = "1408x792"
	elif index == 5:
		Globals.window_resolution = "1280x720"
	elif index == 6:
		Globals.window_resolution = "1152x648"
	elif index == 7:
		Globals.window_resolution = "1024x567"
	elif index == 8:
		Globals.window_resolution = "896x504"
	elif index == 9:
		Globals.window_resolution = "768x432"
	elif index == 10:
		Globals.window_resolution = "640x360"
	Globals.save_settings()
	Globals.apply_settings()


func _on_fov_slider_value_changed(value: float) -> void:
	Globals.player_FOV = value
	fov_label.text = str(int(value))
	Globals.save_settings()
	Globals.apply_settings()
