extends Control

@onready var settings_gui := $Settings
@onready var pause_gui := $"Pause Menu"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Globals.current_menu == Globals.MenuState.NONE or Globals.current_menu == Globals.MenuState.MAIN:
		settings_gui.hide()
		pause_gui.hide()



func open_pause_gui():
	pause_gui.show()
	settings_gui.hide()
	Globals.current_menu = Globals.MenuState.PAUSE
	get_tree().paused = true

func open_settings_gui():
	pause_gui.hide()
	settings_gui.show()
	Globals.current_menu = Globals.MenuState.SETTINGS

func close_guis():
	pause_gui.hide()
	settings_gui.hide()
	Globals.current_menu = Globals.MenuState.NONE
	get_tree().paused = false
