extends StaticBody3D

signal touching_signal


func _init():
	add_to_group("interactable")

func touching():
	emit_signal("touching_signal")
