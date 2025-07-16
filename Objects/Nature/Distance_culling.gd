extends Node3D

@onready var distance_player_begin_culling : float = Globals.view_distance
@onready var distance_camera_begin_culling : float = Globals.view_distance / 2

func _process(delta: float) -> void:
	if !is_instance_valid(get_tree().get_first_node_in_group("Player")):
		return
	
	var player : CharacterBody3D = get_tree().get_first_node_in_group("Player")
	var player_far := global_position.distance_to(player.global_position) >= distance_player_begin_culling
	var all_cameras_far := true
	
	for cam in get_tree().get_nodes_in_group("Cameras"):
		if global_position.distance_to(cam.global_position) < distance_camera_begin_culling:
			all_cameras_far = false
			break  # one is close, no need to keep checking

	visible = !(player_far && all_cameras_far)
	

func update_settings():
	distance_player_begin_culling = Globals.view_distance
	distance_camera_begin_culling = Globals.view_distance / 2
