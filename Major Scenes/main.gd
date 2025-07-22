extends Node3D

@onready var map = preload("res://Major Scenes/map.tscn").instantiate()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_child(map)
