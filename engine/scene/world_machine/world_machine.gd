extends Node

var next_scene

func _ready():
	process_scene()


func change_scene(node):
#	get_tree().root.remove_child(get_tree().current_scene)
	get_tree().current_scene.queue_free()
	node = node.instantiate()
	get_tree().root.add_child(node)
	get_tree().current_scene = node
	process_scene()


func process_scene():
	if (
		"scene_type" in get_tree().current_scene
		and get_tree().current_scene.scene_type == "level"
	):
		$ui.visible = true
	else:
		$ui.visible = false





