extends Area3D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var coin: Area3D = $"."




func _on_body_entered(body: Node3D) -> void:
	if body.name != "Player":
		return

	# Build 2 bug
	if QaState.current_build == QaState.Build.BUILD_2:
		coin.visible = true
		player.show_bug_report("Coin cannot be collected.")
		return
	
	# Normal behaviour
	queue_free()
