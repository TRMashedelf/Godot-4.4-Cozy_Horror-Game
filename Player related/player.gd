extends CharacterBody3D

@onready var camera = $Camera3D
@onready var body = $MeshInstance3D
@onready var ray = $Camera3D/RayCast3D
@onready var reticle = $Control/Reticle

@onready var gui_settings = preload("res://GUI/settings.tscn").instantiate()
@onready var gui_open = false

@onready var Is_collide_interatable = false


@export var SPEED = 3.0
@export var mouse_sensitivity: float

func _ready() -> void:
	body.hide()
	camera.fov = Globals.player_FOV

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and gui_open == false:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif event.is_action_pressed("ui_cancel"):
		open_gui("settings")
		esc_update()
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			self.rotate_y(-event.relative.x * mouse_sensitivity)
			camera.rotate_x(-event.relative.y * mouse_sensitivity)
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-85), deg_to_rad(75))
	
	if event.is_action_pressed("left_click") and gui_open == false:
		ray._interact("left_click")
	elif event.is_action_pressed("right_click") and gui_open == false:
		ray._interact("right_click")
	elif event.is_action_pressed("scroll_up") and gui_open == false:
		ray._interact("scroll_up")
	elif event.is_action_pressed("scroll_down") and gui_open == false:
		ray._interact("scroll_down")

func _physics_process(delta: float) -> void:
	update_reticle()
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction and gui_open == false:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()


func update_reticle():
	if ray.is_colliding() == true:
		if ray.colliding_interactable == true:
			reticle.DOT_RADIUS = 3.0
			reticle.queue_redraw()
		else:
			reticle.DOT_RADIUS = 0.0
			reticle.queue_redraw()
	else:
		reticle.DOT_RADIUS = 0.0
		reticle.queue_redraw()
		
func open_gui(GUI: String):
	if GUI == "settings":
		if gui_open == false:
			self.add_child(gui_settings)
			gui_open = true
		else:
			self.remove_child(gui_settings)
			Globals.save_settings()
			Globals.apply_settings()
			gui_open = false
		

func update_settings():
	await get_tree().process_frame
	camera.fov = Globals.player_FOV
	mouse_sensitivity = Globals.player_mouseSensitivity / 10000.0
	esc_update()

func esc_update():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if gui_open == false:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if Globals.window_type == "fullscreen" and gui_open == true:
		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
