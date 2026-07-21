extends Node3D

@export var platformer_scene: PackedScene
@onready var mini_game_holder: Node3D = $"../MiniGameHolder"
@onready var office: Node3D = $"../Office"
@onready var computer: Node3D = $"."

var player_in_area:= false
@onready var office_spawn: Marker3D = $"../Office/OfficeSpawn"

@onready var desktop: Control = $Desktop
@onready var computer_label: Label3D = $ComputerLabel
@onready var player = get_tree().get_first_node_in_group("player")
var player_interacted_with_computer:= false
func _ready() -> void:
	desktop.visible = false
	computer_label.visible = false
	

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

	var spawn = platformer.get_node("SpawnPoint") as Marker3D
	player.global_position = spawn.global_position
	player.global_rotation = spawn.global_rotation
	close_computer()
	office.visible = false
	computer.visible = false
	player.update_build()
	
#when platformer ends
#platformer.queue_free()
#
#office.visible = true
#
#player.global_position = office_spawn.global_position
#player.global_rotation = office_spawn.global_rotation
