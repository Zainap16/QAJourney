extends Node


# QAState.gd (Autoload)

enum Build {
	BUILD_1,
	BUILD_2,
	BUILD_3,
	BUILD_4
}

@export var current_build = Build.BUILD_1

#func _on_body_entered(body):
	#if QAState.current_build == QAState.Build.BUILD_2:
		#return   # Bug: coin doesn't collect
#
	#queue_free()
	#
	#func _on_interact():
	#if QAState.current_build == QAState.Build.BUILD_3:
		#return   # Bug: button does nothing
#
	#door.open()
	
	#func _on_body_entered(body):
	#if QAState.current_build == QAState.Build.BUILD_4:
		#return   # Bug: finish never triggers
#
	#level_complete()
	
	
