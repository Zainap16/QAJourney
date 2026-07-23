extends Node3D

@export var door: Node3D

@onready var label: Label3D = $Label3D
@onready var player = get_tree().get_first_node_in_group("player")
@onready var checklist = get_tree().get_first_node_in_group("checklist")
var player_in_area := false

#For example:
#
#The switch moves down.
#It plays a click sound.
#Maybe the light turns green.

func _ready():
	label.visible = false

func _process(_delta):

	if !player_in_area:
		return

	if Input.is_action_just_pressed("interact"):
		if QaState.current_build == QaState.Build.BUILD_3:
			player.show_bug_report("Switch does not open the door.")
			return

		door.open()
		checklist.mark_open_door()


func _on_area_3d_body_entered(body: Node3D) -> void:

	if body.name == "Player":
		player_in_area = true
		label.visible = true


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.name == "Player":
		player_in_area = false
		label.visible = false
