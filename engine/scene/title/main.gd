extends Control


func _ready():
	%to_auth.pressed.connect(change_screen.bind("auth"))
	%login/submit.pressed.connect(change_screen.bind("avatar_edit"))
	%signup/submit.pressed.connect(change_screen.bind("avatar_edit"))
	%login/submit.pressed.connect(preload_scene)
	%signup/submit.pressed.connect(preload_scene)
	$avatar_edit.saved_avatar.connect(next_scene)
	change_screen("title")


func change_screen(screen_name):
	for child in get_children():
		child.visible = false
	get_node(screen_name).visible = true


func preload_scene():
	world_machine.next_scene = preload("res://scene/main_area/main.tscn")

func next_scene():
	world_machine.change_scene(world_machine.next_scene)





