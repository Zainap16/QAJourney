extends Node3D

@export var platformer_scene: PackedScene
@onready var mini_game_holder: Node3D = $"../MiniGameHolder"
@onready var office: Node3D = $"../Office"
@onready var computer: Node3D = $"."
@onready var email_pop: Control = $Desktop/EmailPop

var player_in_area:= false
@onready var office_spawn: Marker3D = $"../Office/OfficeSpawn"
@onready var notification: RichTextLabel = $Desktop/Notification
@onready var label_build: Label = $Desktop/ProgramsButtons/TestBuild/Label


@onready var desktop: Control = $Desktop
@onready var computer_label: Label3D = $ComputerLabel
@onready var player = get_tree().get_first_node_in_group("player")
var player_interacted_with_computer:= false
func _ready() -> void:
	desktop.visible = false
	computer_label.visible = false
	email_pop.visible = false
	notification.visible = false
	

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		if player_interacted_with_computer:
			close_computer()
		elif player_in_area:
			open_computer()

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		player_in_area = true
		computer_label.visible = true

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.name == "Player":
		player_in_area = false
		computer_label.visible = false

func open_computer():
	desktop.visible = true

	player.can_move = false
	player.can_look = false
	player_interacted_with_computer = true

	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func close_computer():
	desktop.visible = false
	player.can_move = true
	player.can_look = true
	player_interacted_with_computer = false
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func enter_new_world():
	desktop.visible = false
	player_interacted_with_computer = false
	

func _on_btn_test_build_pressed() -> void:
	var platformer = platformer_scene.instantiate()
	mini_game_holder.add_child(platformer)
	#player.bug_report_submitted.connect(_on_bug_report_submitted.bind(platformer))

	var spawn = platformer.get_node("SpawnPoint") as Marker3D
	player.global_position = spawn.global_position
	player.global_rotation = spawn.global_rotation
	close_computer()
	office.visible = false
	computer.visible = false
	player.update_build()
	
func exit_platformer():
	if mini_game_holder.get_child_count() > 0:
		mini_game_holder.get_child(0).queue_free()

	office.visible = true
	computer.visible = true
	player.exit_bug_report()
	player.global_position = office_spawn.global_position
	player.global_rotation = office_spawn.global_rotation

	player.can_move = true
	player.can_look = true

	if QaState.current_build == QaState.Build.BUILD_4:
		await get_tree().create_timer(1.0).timeout
		show_email_notification()
		
	else:
		QaState.current_build += 1


func _on_btn_mail_pressed() -> void:
#	open email
	email_pop.visible = true
	notification.visible = false
	

func show_email_notification():
	notification.visible = true


func _on_unlock_robot_button_pressed() -> void:
#	play automation
#	maybe disable test build button 
	email_pop.visible = false
	label_build.text = "[Run Automated Tests]"
	print("Show automation")
	pass
