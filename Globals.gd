extends Node

@onready var config = ConfigFile.new()
@onready var config_savepath = ProjectSettings.globalize_path("user://settings.cfg")

@export var player_FOV: float = 90.0
@export var player_mouseSensitivity: float = 40.0

@export var window_type: String = "borderless"
@export var window_resolution: String = "1920x1080"

@export var audio_masterVolume: int = 100
@export var audio_SFXVolume: int = 100
@export var audio_ambientVolume: int = 100
@export var audio_musicVolume: int = 100

@export var view_distance: float = 75.0

enum MenuState { NONE, MAIN, PAUSE, SETTINGS }
@export var current_menu := MenuState.NONE



func _ready() -> void:
	load_settings()
	current_menu = MenuState.NONE
	


func load_settings():
	var error = config.load(config_savepath)
	if error != OK:
		print("Error loading config file: ", error)
		return
	player_mouseSensitivity = config.get_value("controls", "player_mouseSensitivity", 40)

	window_type = config.get_value("graphics", "window_type", "borderless")
	window_resolution = config.get_value("graphics", "window_resolution", "1920x1080")
	player_FOV = config.get_value("graphics", "player_FOV", 90.0)
	view_distance = config.get_value("graphics", "view_distance", 75.0)

	audio_masterVolume = config.get_value("audio", "master_volume", 100)
	audio_SFXVolume = config.get_value("audio", "sfx_volume", 100)
	audio_ambientVolume = config.get_value("audio", "ambient_volume", 100)
	audio_musicVolume = config.get_value("audio", "music_volume", 100)
	print("Settings loaded from: ", config, " Located at: ", config_savepath)
	apply_settings()

func save_settings():
	config.set_value("graphics", "window_type", window_type)
	config.set_value("graphics", "window_resolution", window_resolution)
	config.set_value("graphics", "player_FOV", player_FOV)
	config.set_value("graphics", "view_distance", view_distance)
	
	config.set_value("controls", "player_mouseSensitivity", player_mouseSensitivity)
	
	config.set_value("audio", "master_volume", audio_masterVolume)
	config.set_value("audio", "sfx_volume", audio_SFXVolume)
	config.set_value("audio", "ambient_volume", audio_ambientVolume)
	config.set_value("audio", "music_volume", audio_musicVolume)
	
	var error = config.save(config_savepath)
	if error != OK:
		print("Failed to save settings.cfg to: ", config_savepath)
	else:
		print("Successfully saved settings.cfg to: ", config_savepath)


func apply_settings():
	if window_type == "fullscreen":
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
	elif window_type == "windowed":
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
	elif window_type == "borderless":
		borderless()
	
	var window_size_result: Array = split_string_to_sizes(window_resolution)
	var width = window_size_result[0]
	var height = window_size_result[1]
	width = int(width)
	height = int(height)
	DisplayServer.window_set_size(Vector2i(width, height))
	
	var root = get_tree().root
	_call_recursive_update(root)
	
	

func split_string_to_sizes(value: String):
	var delimiter = "x"
	var result_array = value.split(delimiter)
	return result_array


func _call_recursive_update(node: Node):
	if node.has_method("update_settings"):
		node.call("update_settings")
	for child in node.get_children():
		if child is Node:
			_call_recursive_update(child)

func borderless():
	var primary_screen := DisplayServer.get_primary_screen()
	var screen_size := DisplayServer.screen_get_size(primary_screen)
	var screen_pos := DisplayServer.screen_get_position(primary_screen)
	
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
	DisplayServer.window_set_size(screen_size)
	DisplayServer.window_set_position(screen_pos)
