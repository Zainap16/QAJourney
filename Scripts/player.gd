extends CharacterBody3D

#signal bug_report_submitted
#@onready var checklist = get_tree().get_first_node_in_group("checklist")
const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var look_dir: Vector2
@onready var camera: Camera3D = $Camera3D
var camera_sens = 50
#@onready var bug_found_label: Label3D = $BugFoundLabel
@onready var bug_report_bug: ColorRect = $UI/BugReportBug
@onready var bug_label: Label = $UI/BugReportBug/BugLabel

var capMouse = false
var can_look := true
var can_move := true
var can_jump:= true

@onready var computer: Node3D = $"../Computer"

@onready var test_complete: ColorRect = $UI/TestComplete


var move_checked := false
var jump_checked := false
var checklist

var bug_report_shown := false
func _ready() -> void:
	#bug_found_label.visible = false
	
	bug_report_bug.visible = false
	test_complete.visible = false

func _physics_process(delta: float) -> void:
	if !can_move:
		return
	if not is_on_floor():
		velocity += get_gravity() * delta


	if Input.is_action_just_pressed("ui_accept") and is_on_floor():

		# Build 1 - Jump is broken
		if !can_jump:
			if !bug_report_shown:
				bug_report_shown = true
				show_bug_report("Player unable to jump")
			return

		# Jump works
		velocity.y = JUMP_VELOCITY

		if !jump_checked:
			jump_checked = true
			checklist.mark_jump()
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
	checklist = get_checklist()
	checklist.reset_checklist()

	can_jump = QaState.current_build != QaState.Build.BUILD_1
	move_checked = false
	jump_checked = false
	bug_report_shown = false
	
func show_bug_report(title):
	#print("Showing bug report")
	can_move = false
	can_look = false

	bug_report_bug.visible = true
	bug_label.text = title
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
func exit_bug_report():
	can_move = true
	can_look = true
	bug_report_bug.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_submit_button_pressed() -> void:
	#var computer = get_tree().get_first_node_in_group("Computer")
	computer.exit_platformer()
func level_completed():
	can_move = false
	can_look = false
	test_complete.visible= true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_return_to_desktop_button_pressed() -> void:
	can_move = true
	can_look = true
	test_complete.visible= false
	computer.exit_platformer()
func get_checklist():
	return get_tree().get_first_node_in_group("checklist")
