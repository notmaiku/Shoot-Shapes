extends CharacterBody3D
 

const MOUSESENSENSITIVITY = 0.1
const RAYLENGTH = 1000

var speed = 8
var acceleration = 3
var jump_power = 30

@export var TILT_LOWER_LIMIT := deg_to_rad(-90.0)
@export var TILT_UPPER_LIMIT := deg_to_rad(90.0)
@export var CAMERA_CONTROLLER : Camera3D
@export var SCORE : Label
@onready var ELIMS = $"../UI/Fin/Elims"
@onready var head  = $CameraNode

var _mouse_rotation : Vector3
var _mouse_input : bool = false
var _rotation_input = 4.5
var _tilt_input : float
var _player_rotation : Vector3
var _camera_rotation : Vector3


#var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var gravity = 0.98

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	pass

func _physics_process(delta):
	# if not is_on_floor():
	# 	velocity.y -= gravity * delta
	var head_basis = head.get_global_transform().basis
	_update_camera(delta)
	
	var direction = Vector3()
	if Input.is_action_pressed("forward"):
		direction -= head_basis.z
	elif Input.is_action_pressed("backward"):
		direction += head_basis.z
	
	if Input.is_action_pressed("left"):
		direction -= head_basis.x
	elif Input.is_action_pressed("right"):
		direction += head_basis.x
	
	direction = direction.normalized()
	
	velocity = velocity.lerp(direction * speed, acceleration * delta)
	velocity.y -= gravity
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y += jump_power
	
	move_and_slide()
	pass

func _input(event):
	#if event.is_action_pressed("escape"):
		#get_tree().quit()
	pass

func _unhandled_input(event):
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif event.is_action_pressed("escape"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	_mouse_input = event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED
	if _mouse_input:
		_rotation_input = -event.relative.x 
		_tilt_input = -event.relative.y
	pass

func _update_camera(delta):
	_mouse_rotation.x += _tilt_input * delta
	_mouse_rotation.x = clamp(_mouse_rotation.x, TILT_LOWER_LIMIT, TILT_UPPER_LIMIT)
	_mouse_rotation.y += _rotation_input * delta

	_player_rotation = Vector3(0, _mouse_rotation.y, 0)
	_camera_rotation = Vector3(_mouse_rotation.x, 0, 0)

	CAMERA_CONTROLLER.transform.basis = Basis.from_euler(_camera_rotation)
	CAMERA_CONTROLLER.rotation.z = 0.0

	global_transform.basis = Basis.from_euler(_player_rotation)

	_rotation_input = 0.0
	_tilt_input = 0.0

func _process(_delta):
	if (Input.is_action_just_pressed("shoot")):
		shoot()
	pass

func shoot():
	var space_state = get_world_3d().direct_space_state
	
	var mousepos = get_viewport().get_mouse_position()
	var camera = CAMERA_CONTROLLER
	var origin = camera.project_ray_origin(mousepos)
	var end = origin + camera.project_ray_normal(mousepos) * RAYLENGTH
	var query = PhysicsRayQueryParameters3D.create(origin, end)
	query.collide_with_areas = true

	var result = space_state.intersect_ray(query)
	if result:
		var node = result["collider"].get_parent_node_3d()
		if node.is_in_group('enemy'):
			node.queue_free()
			var scoreIncrease = SCORE.text.to_int()
			var elimIncrease = ELIMS.text.to_int()
			elimIncrease += 1
			scoreIncrease += 1
			SCORE.text = str(scoreIncrease)
			ELIMS.text = str(elimIncrease)
	pass
