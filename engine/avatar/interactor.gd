extends RayCast3D


func _physics_process(_delta):
	if is_colliding():
		var sb = get_collider()
		if sb.is_in_group("interactable"):
			sb.touching()

#
#		if Input.is_action_just_pressed("jump"):
#			var _e = emit_signal("collect", collectable.item, collectable.type)

#	elif collectable:
#		print("no")
#		collectable.is_highlighted = false
