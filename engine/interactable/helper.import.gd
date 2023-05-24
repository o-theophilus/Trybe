@tool
extends EditorScenePostImport


func _post_import(scene):
	scene.set_script(load("res://interactable/wearable.gd"))
	var sb = scene.find_children("","StaticBody3D")[0]
	sb.set_script(load("res://interactable/helper.import.sb.gd"))
	print("** DONE **")
	return scene

