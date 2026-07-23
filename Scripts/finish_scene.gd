extends Node3D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var finish_label: Label3D = $FinishLabel
@onready var checklist = get_tree().get_first_node_in_group("checklist")
func _ready() -> void:
	finish_label.visible = false

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name != "Player":
		return
	else:
		finish_label.visible = true
		finish_label.text = "Level Complete."

	if QaState.current_build == QaState.Build.BUILD_4:
		checklist.mark_finish()
		player.level_completed()
		
		return


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.name == "Player":
		finish_label.visible = false
