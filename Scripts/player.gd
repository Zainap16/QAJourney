extends CharacterBody3D



const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var look_dir: Vector2
@onready var camera: Camera3D = $Camera3D
var camera_sens = 50
@onready var bug_found_label: Label3D = $BugFoundLabel

var capMouse = false
var can_look := true
var can_move := true
var can_jump:= true

func _ready() -> void:
	bug_found_label.visible = false

func _physics_process(delta: float) -> void:
	if !can_move:
		return
	if not is_on_floor():
		velocity += get_gravity() * delta


	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and can_jump:
		velocity.y = JUMP_VELOCITY

	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	if Input.is_action_just_pressed("pause"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	_rotate_camera(delta)

	move_and_slide()
	
func _input(event):
	if !can_look:
		return
	if !can_look:
		return

	if event is InputEventMouseMotion:
		look_dir = event.relative * 0.01

func _rotate_camera(delta: float, sens_mod:float = 1.0):
	rotation.y -= look_dir.x * camera_sens * delta
	camera.rotation.x = clamp(camera.rotation.x - look_dir.y * camera_sens * sens_mod * delta, -1.5,1.5)
	look_dir = Vector2.ZERO
func update_build():
	bug_found_label.text = "Bug Detetced: Jump"
	bug_found_label.visible = true
	can_jump = QaState.current_build != QaState.Build.BUILD_1
	
