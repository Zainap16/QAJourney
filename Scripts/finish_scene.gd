extends Node3D

@onready var player = get_tree().get_first_node_in_group("player")

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name != "Player":
		return

	if QaState.current_build == QaState.Build.BUILD_4:
		player.show_bug_report("Finish trigger never activates.")
		return
#
	#checklist.tick_finish()
#
	#level_complete()
