extends Area3D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var coin: Area3D = $"."
@onready var checklist = get_tree().get_first_node_in_group("checklist")


func _on_body_entered(body: Node3D) -> void:
	if body.name != "Player":
		return

	# Build 2 bug
	if QaState.current_build == QaState.Build.BUILD_2:
		player.show_bug_report("Coin cannot be collected.")
		return

	# Passed test
	checklist.mark_coin()

	queue_free()
